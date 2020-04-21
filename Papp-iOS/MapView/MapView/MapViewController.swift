//
//  MapViewController.swift
//  Papp
//
//  Created by Nikolaj Wassmann on 10/02/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit
import Mapbox
import SideMenu


class MapViewController: UIViewController, MGLMapViewDelegate, UITabBarDelegate {
    
    //MARK: Fields
    
    var rightMenuNavigationController: SideMenuNavigationController!
    
    var mStyle: MGLStyle!
    
    var onMapTapRecognizer = UITapGestureRecognizer()
    
    var previousSelectedTabBarItem: Int!
    
    let confirmButton: UIButton = UIButton()
    
    let cancelButton: UIButton = UIButton()
    
    let topText: UILabel = UILabel()
    
    let fireStoreController = FirestoreController.init()
    
    let pin: MGLPointAnnotation? = MGLPointAnnotation()
    
    @IBOutlet weak var mapView: MGLMapView!
    
    @IBOutlet weak var mapTabBar: UITabBar!
    
    @IBOutlet var tabBarItems: [UITabBarItem]!
    
    @IBOutlet weak var trackButton: UIButton!
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rightMenuNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as? SideMenuNavigationController
        
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: mapView, forMenu: .right)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view, forMenu: .right)
        SideMenuManager.default.rightMenuNavigationController?.statusBarEndAlpha = 0
        SideMenuManager.default.rightMenuNavigationController?.presentationStyle = .menuSlideIn
        
        mapTabBar.selectedItem = tabBarItems[0]
        
        previousSelectedTabBarItem = mapTabBar.selectedItem?.tag
        
        mapTabBar.delegate = self
        
        //MARK: Needs to be moved in to its own style 
        trackButton.layer.cornerRadius = trackButton.frame.width/2
        trackButton.layer.borderWidth = 1
        trackButton.layer.borderColor = UIColor.lightGray.cgColor
        
        mapView.showsUserLocation = true
        
        mapView.userTrackingMode = .follow
        
        mapView.delegate = self
        
        fireStoreController.getAllPVagt(mapView)
        
    }
    
    //MARK: Delegate methods
    
    func mapView(_ mapView: MGLMapView, didUpdateUserLocation userLocation: Any!){
    }
    
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        

    }
    
    func mapView(_ mapView: MGLMapView, regionWillChangeAnimated animated: Bool){
        
        if mapView.userTrackingMode == .none {
            trackButton.setImage(UIImage(systemName: "location"), for: .normal)
        }
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
          mStyle = style
    }
    
    //MARK: User interaction
    
    @IBAction func onClickTrackButton() {
        mapView.userTrackingMode = .follow
        
        trackButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
    }
    
    @objc @IBAction func handleMapTap(sender: UITapGestureRecognizer) {
        let tapPoint: CGPoint = sender.location(in: mapView)
        let coordinate: CLLocationCoordinate2D = mapView.convert(tapPoint, toCoordinateFrom: nil)
        
        
        if mStyle.sources.count > 0 {
            mapView.removeAnnotation(pin!)
            pin!.coordinate = coordinate
            mapView.addAnnotation(pin!)
        }
        else {
        
        pin!.coordinate = coordinate
        
        let shapeSource = MGLShapeSource(identifier: "marker-source", shape: pin, options: nil)
        
        let shapeLayer = MGLSymbolStyleLayer(identifier: "marker-style", source: shapeSource)
        
        mStyle.addSource(shapeSource)
        mStyle.addLayer(shapeLayer)
        mapView.addAnnotation(pin!)
        }
    }
}
