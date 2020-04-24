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
    
    //MARK: Fields
    
    var facebookName: String?
    var facebookEmail: String?
    
    enum Collections: String {
        case User = "User"
        case Tips = "Tips"
        case Pvagt = "Pvagt"
    }
    
    //MARK: Basic constructor
    
    init() {
        
    }
    
    //MARK: Local initialization
    
    let db = Firestore.firestore()
    
    //MARK: Public methods
    
    func createUser(name: String, email: String ) {
        db.collection(Collections.User.rawValue).addDocument(data: ["name" : name, "email": email] ) {
            error in
            if let error = error {
                print("ERROR: Could not add user \(error)")
            } else {
                print("Sucessfully added user to DB")
            }
        }
    }
    
    func createUser(){
        getDataFromFacebook()
        db.collection(Collections.User.rawValue).addDocument(data: ["name": facebookName as Any, "email" : facebookEmail as Any] ) {
            error in
            if let error = error {
                print("ERROR: Could not add user \(error)")
            } else {
                print("Sucessfully added user to DB")
            }
        }
    }
    
    func getDataFromFacebook() {
       if let user = Auth.auth().currentUser {
       for profile in user.providerData {
        facebookName = profile.displayName
        facebookEmail = profile.email
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
    
    func createPTip(_ tip: TipDTO){
        db.collection(Collections.Tips.rawValue).addDocument(data: ["description":tip.description as Any, "latitude": tip.latitude as Any, "longitude": tip.longitude as Any]){
            error in
            if let error = error {
                print("ERROR: Could not add Tip \(error)")
            }
            else {
                print("Sucessfully added Tip to DB")
            }
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
            
            style.addSource(shapeSource)
            style.addLayer(shapeLayer)
        }
        
    }
}
