//
//  TipViewController.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 15/03/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit
import Mapbox

class TipViewController: UIViewController, UITextViewDelegate {
    
    
    
    //MARK: Ret layout fejl (Især constraints og størrelse på snapshot)
    
    //MARK: Hent alle tips fra database og vis dem
    
    //MARK: Lav Navigation til TipDef (Benyt UINavigationController) og tilbage igen
    

    let confirmButton: UIButton = UIButton()
    let cancelButton: UIButton = UIButton()
    
    let marker = #imageLiteral(resourceName: "Marker")
    
    var mapSnapshot: UIImage?
    var mapViewForSnapshot: MGLMapView?
    
    @IBOutlet weak var tipPlacementSnap: UIImageView!
    
    @IBOutlet weak var SendTipTextView: UITextView!
    
    let firestoreController = FirestoreController.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setUpTextView()
        addButtons()
        
        createSnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func addMarkerOnSnapshot() {
        let markerView = UIImageView(image: marker) // Create the view holding the image
        markerView.frame = CGRect(x: tipPlacementSnap.bounds.width/2 - 20, y: tipPlacementSnap.bounds.height/2-50, width: 42, height: 50) // The size and position of the marker
        
        tipPlacementSnap.addSubview(markerView) // Add the front image on top of the background
    }

    @objc func createSnapshot() {
        // Get the markers coordinates.
        let annotation = mapViewForSnapshot?.annotations?.first?.coordinate
        
        // Create the snapshots view point to be where the marker is placed on the map.
        let camera = MGLMapCamera(lookingAtCenter: annotation!, altitude: 100, pitch: 20, heading: 0)
        
        // Use the map's style, camera, size, and zoom level to set the snapshot's options.
        let options = MGLMapSnapshotOptions(styleURL: mapViewForSnapshot?.styleURL, camera: camera, size: CGSize(width: 290, height: 200))
        options.zoomLevel = 16
        
        // Create an indicator so the user knows that the snapshot is loading.
        let indicator = UIActivityIndicatorView(frame: CGRect(x: tipPlacementSnap.bounds.width/2 - 30, y: tipPlacementSnap.bounds.height/2 - 30, width: 60, height: 60))
        tipPlacementSnap.addSubview(indicator)
        indicator.startAnimating()
        
        let snapshotter = MGLMapSnapshotter.init(options: options)
        snapshotter.start { (snapshot, error) in
            if error != nil {
                print("Unable to create a map snapshot.")
            }
            self.tipPlacementSnap.image = snapshot?.image
           
            self.addMarkerOnSnapshot()
            
            indicator.stopAnimating()
            snapshotter.cancel() //only needs to be here because of a bug where the garbage collector cleans up the snapshotter before a snapshot has been generated.
        }
    }
    
    
    func setUpTextView(){
        SendTipTextView.delegate = self
        SendTipTextView.layer.borderColor = UIColor.white.cgColor
        SendTipTextView.layer.borderWidth = 2.0
        SendTipTextView.layer.cornerRadius = 10
        SendTipTextView.clipsToBounds = true
        SendTipTextView.textColor = UIColor.lightGray
    }
    
    @objc private func onClickConfirm() {
        if SendTipTextView.text == "" {
            displayAlert()
            return
        }
        
        guard let markerLocation = mapViewForSnapshot?.annotations?.first?.coordinate else { return}
        
        let tip = TipDTO(description: SendTipTextView.text, latitude: markerLocation.latitude, longitude: markerLocation.longitude)
        
        firestoreController.createPTip(tip) { (completed) -> (Void) in
            if completed == true {
                
            }
        }
        
        
        
    }
    
    @objc private func onClickCancel() {
        navigationController?.popToRootViewController(animated: true)
    }

    private func addButtons(){
        confirmButton.setTitle("Indsend tip", for: .normal)
        confirmButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        confirmButton.backgroundColor = UIColor.init(red: 103/255, green: 150/255, blue: 190/255, alpha: 1)
        confirmButton.layer.cornerRadius = 20
        view.addSubview(confirmButton)
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -25).isActive = true
        confirmButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -10).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
    
        
        cancelButton.setTitle("Annuller", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        cancelButton.backgroundColor = UIColor.gray
        cancelButton.layer.cornerRadius = 20
        view.addSubview(cancelButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -25).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 10).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        confirmButton.addTarget(self, action: #selector(onClickConfirm), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(onClickCancel), for: .touchUpInside)
    
    }

}

