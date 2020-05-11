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

    let confirmButton: UIButton = UIButton()
    let cancelButton: UIButton = UIButton()
    let snapShotImageView: UIImageView = UIImageView()
    let tipTextView: UITextView = UITextView()
    
    let marker = #imageLiteral(resourceName: "Marker")
    
    let firestoreController = FirestoreController.init()
    
    var mapViewController: MapViewController?
    var mapSnapshot: UIImage?
    var mapViewForSnapshot: MGLMapView?

    init(_ mapViewController: MapViewController) {
        self.mapViewController = mapViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
           super.init(coder: coder)
       }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setUpTextView()
        addButtons()
        addImageView()
        
        createSnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.title = "Indberet tip"
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func addMarkerOnSnapshot() {
        let markerView = UIImageView(image: marker) // Create the view holding the image
        markerView.frame = CGRect(x: snapShotImageView.bounds.width/2 - 20, y: snapShotImageView.bounds.height/2-50, width: 42, height: 50) // The size and position of the marker
        
        snapShotImageView.addSubview(markerView) // Add the front image on top of the background
    }

    @objc func createSnapshot() {
        // Get the markers coordinates.
        let annotation = mapViewForSnapshot?.annotations?.first?.coordinate
        
        // Create the snapshots view point to be where the marker is placed on the map.
        let camera = MGLMapCamera(lookingAtCenter: annotation!, altitude: 100, pitch: 20, heading: 0)
        
        // Use the map's style, camera, size, and zoom level to set the snapshot's options.
        let options = MGLMapSnapshotOptions(styleURL: mapViewForSnapshot?.styleURL, camera: camera, size: CGSize(width: 290, height: 200))
        options.zoomLevel = 16
        
        // Create an indicator to show the user that the snapshot is loading.
        let indicator = UIActivityIndicatorView(frame: CGRect(x: snapShotImageView.bounds.width/2, y: snapShotImageView.bounds.height/2, width: 150, height: 150))
        snapShotImageView.addSubview(indicator)
        indicator.startAnimating()
        
        let snapshotter = MGLMapSnapshotter.init(options: options)
        snapshotter.start { (snapshot, error) in
            if error != nil {
                print("Unable to create a map snapshot.")
            }
            self.snapShotImageView.image = snapshot?.image
            
            self.addMarkerOnSnapshot()
            
            indicator.stopAnimating()
            snapshotter.cancel() //only needs to be here because of a bug where the garbage collector cleans up the snapshotter before a snapshot has been generated.
        }
    }
    
    
    @objc func onClickConfirm() {
        if tipTextView.text == "" {
            displayNoTextAlert()
            return
        }
        
        guard let markerLocation = mapViewForSnapshot?.annotations?.first?.coordinate else { return}
        
        
        
        let tip = TipDTO(description: tipTextView.text, latitude: markerLocation.latitude, longitude: markerLocation.longitude)
        
        firestoreController.createPTip(tip) { (completed) -> (Void) in
            if completed == true {
                self.displayCompletedAlert()
            }
        }
        
        mapViewController?.tabBar(mapViewController!.mapTabBar, didSelect: mapViewController!.tabBarItems[0])
        mapViewController?.mapTabBar.selectedItem = mapViewController?.tabBarItems[0]
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func onClickCancel() {
        navigationController?.popToRootViewController(animated: true)
    }

  

}

