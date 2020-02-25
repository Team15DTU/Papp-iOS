//
//  MapViewController.swift
//  Papp
//
//  Created by Nikolaj Wassmann on 10/02/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit
import Mapbox

// MapViewController

class MapViewController: UIViewController, MGLMapViewDelegate {
    
    @IBOutlet weak var mapView: MGLMapView!
    
    @IBOutlet weak var mapTabBar: UITabBar!
    
    @IBOutlet var tabBarItems: [UITabBarItem]!
    
    @IBOutlet weak var trackButton: UIButton!
    
    @IBAction func onClickTrackButton() {
        mapView.userTrackingMode = .follow
        
        trackButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapTabBar.selectedItem = tabBarItems[0]
        
        //MARK: Needs to be moved in to its own style 
        trackButton.layer.cornerRadius = trackButton.frame.width/2
        trackButton.layer.borderWidth = 1
        trackButton.layer.borderColor = UIColor.lightGray.cgColor
    
        
        mapView.showsUserLocation = true
        
        mapView.userTrackingMode = .follow
        
        mapView.delegate = self
    

    }
    
    
    func mapView(_ mapView: MGLMapView, didUpdateUserLocation userLocation: Any!){
    }
    
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        

    }
    
    func mapView(_ mapView: MGLMapView, regionWillChangeAnimated animated: Bool){
        if mapView.userTrackingMode == .none {
            trackButton.setImage(UIImage(systemName: "location"), for: .normal)
        }
    }
    
    @objc @IBAction func handleMapPan(sender: UIPanGestureRecognizer) {
        print("test")
    }
}
