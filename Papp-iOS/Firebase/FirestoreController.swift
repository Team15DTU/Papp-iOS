//
//  FirestoreController.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 09/03/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import Firebase
import FBSDKCoreKit
import UIKit
import Mapbox

class FirestoreController {
    
    //MARK: - Fields
    
    var facebookName: String?
    var facebookEmail: String?
    
    enum Collections: String {
        case User = "User"
        case Tips = "Tips"
        case Pvagt = "Pvagt"
    }
    
    //MARK: - Basic constructor
    
    init() {
        
    }
    
    //MARK: - Local initialization
    
    let db = Firestore.firestore()
    
    //MARK: - Create methods
    
    func createUser(name: String, email: String ) {
        
        let userid = Auth.auth().currentUser?.uid
        
        db.collection(Collections.User.rawValue).document(userid!).setData(["name" : name, "email": email])
    }
    
    func createUser(){
        getDataFromFacebook()
        
        let userid = Auth.auth().currentUser?.uid
        
        doesUserExist { (sucess) in
            if sucess == true {
                print("The user already exists")
            }
            else {
                self.db.collection(Collections.User.rawValue).document(userid!).setData(["name" : self.facebookName!, "email": self.facebookEmail!])
            }
        }
    }
    
    func createPVagt(_ pvagt: PVagtDTO, _ mapViewController: MapViewController){
        db.collection(Collections.Pvagt.rawValue).addDocument(data: ["latitude": pvagt.latitude as Any, "longitude": pvagt.longitude as Any]) {
            error in
            if let error = error {
                print("ERROR: Could not add PVagt \(error)")
            }
            else {
                print("Sucessfully added PVagt to DB")
                let alert = UIAlertController(title: "Bekræftet", message: "Dit tip er hermed blevet registeret", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Fedt!", style: .default, handler: nil)
                )
                mapViewController.present(alert, animated: true)
                
            }
        }
    }
    
    func createPTip(_ tip: TipDTO, _ completion: @escaping(Bool) -> (Void)){
        db.collection(Collections.Tips.rawValue).addDocument(data: ["description":tip.description as Any, "latitude": tip.latitude as Any, "longitude": tip.longitude as Any]){
            error in
            if let error = error {
                print("ERROR: Could not add Tip \(error)")
                completion(false)
            }
            else {
                print("Sucessfully added Tip to DB")
                completion(true)
            }
        }
    }
    
    //MARK: - Read methods
    
    func getDataFromFacebook() {
        if let user = Auth.auth().currentUser {
            for profile in user.providerData {
                facebookName = profile.displayName
                facebookEmail = profile.email
            }
        }
    }
    
    func doesUserExist (_ completion: @escaping (Bool) -> Void){
        let docRef = db.collection(Collections.User.rawValue).whereField("email", isEqualTo: facebookEmail!)
        
        docRef.getDocuments { (querysnapshot, err) in
            if let _ = err {
                print("Error checking user email")
            }
            else if (querysnapshot?.isEmpty)! {
                completion(false)
            }
            else {
                for document in (querysnapshot?.documents)! {
                    if document.data()["email"] != nil {
                        completion(true)
                    }
                }
            }
        }
    }
    
    func getNameCurrentOfUser (_ completion: @escaping(String) -> (Void)){
        let userid = Auth.auth().currentUser?.uid
        var name: String!
        
        let docRef = db.collection(Collections.User.rawValue).document(userid!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                name = document["name"] as? String
                completion(name)
            } else {
                print("Document does not exist")
                completion("No name")
            }
        }
        
    }
    
    func setRoundFacebookProfileImage(_ imageView: UIImageView) {
        if(AccessToken.current != nil)
        {
            
            let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields" : "id"])
            let connection = GraphRequestConnection()
            
            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
                
                let data = result as! [String : AnyObject]
                
                let FBid = data["id"] as? String
                
                let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1")
                imageView.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
                imageView.layer.borderWidth = 1.0
                imageView.layer.masksToBounds = false
                imageView.layer.borderColor = UIColor.white.cgColor
                imageView.layer.cornerRadius = imageView.frame.size.width / 2
                imageView.clipsToBounds = true
            })
            connection.start()
        }
    }
    
    func getAllPVagt(_ mapView: MGLMapView, _ style: MGLStyle) {
        db.collection(Collections.Pvagt.rawValue).addSnapshotListener { documentSnapshot, error in
            guard error == nil else {
                print("Error fetching document: \(error!)")
                return
            }
            var pins = [MGLPointFeature()]
            for document in documentSnapshot!.documents {
                let data = document.data()
                
                let coordinate = CLLocationCoordinate2D(latitude: (data["latitude"] as! CLLocationDegrees), longitude: (data["longitude"] as! CLLocationDegrees))
                
                let pin = MGLPointFeature()
                pin.coordinate = coordinate
                pins.append(pin)
                
                
            }
            
            let image = UIImageView(image: UIImage(systemName: "exclamationmark.triangle.fill")!.withRenderingMode(.alwaysTemplate))
            image.tintColor = .red
            style.setImage(image.image!, forName: "exclamationmark.triangle.fill")
            
            
            
            let shapeSource = MGLShapeSource(identifier: "pvagt-source", features: pins, options: nil)
            
            let shapeLayer = MGLSymbolStyleLayer(identifier: "pvagt-style", source: shapeSource)
            
            
            shapeLayer.iconImageName = NSExpression(forConstantValue: "exclamationmark.triangle.fill")
            shapeLayer.iconColor = NSExpression(forConstantValue: UIColor.red)
            
            
            if style.source(withIdentifier: "pvagt-source") == nil{
                style.addSource(shapeSource)
                style.addLayer(shapeLayer)
            } else {
                //FIXME: To update the features, the only solution I could figure out is to reload the entire style. This causes blinking of the icons
                mapView.reloadStyle(nil)
            }
            
            
            
        }
        
    }
    
    func getAllPTips(_ mapView: MGLMapView, _ style: MGLStyle) {
        db.collection(Collections.Tips.rawValue).addSnapshotListener { documentSnapshot, error in
            guard error == nil else {
                print("Error fetching document: \(error!)")
                return
            }
            var pins = [MGLPointFeature()]
            for document in documentSnapshot!.documents {
                let data = document.data()
                
                let coordinate = CLLocationCoordinate2D(latitude: (data["latitude"] as! CLLocationDegrees), longitude: (data["longitude"] as! CLLocationDegrees))
                
                let description = data["description"] as! String
                
                let pin = MGLPointFeature()
                pin.coordinate = coordinate
                pin.title = description
                pin.attributes = ["description": description]
                pins.append(pin)
                
                
            }
            
            let image = UIImageView(image: UIImage(systemName: "message.fill")!.withRenderingMode(.alwaysTemplate))
            image.tintColor = .red
            style.setImage(image.image!, forName: "message.fill")
            
            
            
            let shapeSource = MGLShapeSource(identifier: "tip-source", features: pins, options: nil)
            
            let shapeLayer = MGLSymbolStyleLayer(identifier: "tip-style", source: shapeSource)
            
            
            shapeLayer.iconImageName = NSExpression(forConstantValue: "message.fill")
            shapeLayer.iconColor = NSExpression(forConstantValue: UIColor(red: 103/255, green: 150/255, blue: 190/255, alpha: 1))
            
            shapeLayer.text = NSExpression(forKeyPath: "description")
            shapeLayer.textColor = NSExpression(forConstantValue: UIColor.white)
            shapeLayer.textFontSize = NSExpression(format: "mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)",
                                                   [10: 10, 16: 16])
            shapeLayer.textTranslation = NSExpression(forConstantValue: NSValue(cgVector: CGVector(dx: 10, dy: 0)))
            shapeLayer.textJustification = NSExpression(forConstantValue: NSValue(mglTextJustification: .center))
            shapeLayer.textOpacity = NSExpression(forConstantValue: 0)
            shapeLayer.textHaloColor = NSExpression(forConstantValue: UIColor.white.withAlphaComponent(0.5))
            shapeLayer.textHaloWidth = NSExpression(forConstantValue: 1)
            shapeLayer.textAnchor = NSExpression(forConstantValue: NSValue(mglTextAnchor: .center))
            
            
            if style.source(withIdentifier: "tip-source") == nil{
                style.addSource(shapeSource)
                style.addLayer(shapeLayer)
            } else {
                //FIXME: To update the features, the only solution I could figure out is to reload the entire style. This causes blinking of the icons
                mapView.reloadStyle(nil)
            }
            
            
            
        }
        
    }
    
    func editCountry(_ country: String) {
        
        let currentUser = Auth.auth().currentUser
        db.collection(Collections.User.rawValue).document(currentUser!.uid).setData(["country" : country], merge: true)
        
    }
    
    func editDescription(_ description: String) {
        
        let currentUser = Auth.auth().currentUser
        db.collection(Collections.User.rawValue).document(currentUser!.uid).setData(["description" : description], merge: true)
        
    }
}
