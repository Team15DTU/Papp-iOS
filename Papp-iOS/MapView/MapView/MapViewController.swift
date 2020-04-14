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
    
    var rightMenuNavigationController: SideMenuNavigationController!
    
    var mStyle: MGLStyle!
    
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
        
        rightMenuNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as? SideMenuNavigationController
        
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: mapView, forMenu: .right)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view, forMenu: .right)
        SideMenuManager.default.rightMenuNavigationController?.statusBarEndAlpha = 0
        SideMenuManager.default.rightMenuNavigationController?.presentationStyle = .menuSlideIn
        
        mapTabBar.selectedItem = tabBarItems[0]
        
        mapTabBar.delegate = self
        
        //MARK: Needs to be moved in to its own style 
        trackButton.layer.cornerRadius = trackButton.frame.width/2
        trackButton.layer.borderWidth = 1
        trackButton.layer.borderColor = UIColor.lightGray.cgColor
        
        mapView.showsUserLocation = true
        
        mapView.userTrackingMode = .follow
        
        mapView.delegate = self
        
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
        for recognizer in mapView.gestureRecognizers! where recognizer is UITapGestureRecognizer {
            singleTap.require(toFail: recognizer)
        }
        mapView.addGestureRecognizer(singleTap)
        
        
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
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
          mStyle = style
    }
    
    @objc @IBAction func handleMapTap(sender: UITapGestureRecognizer) {
        let tapPoint: CGPoint = sender.location(in: mapView)
        let coordinate: CLLocationCoordinate2D = mapView.convert(tapPoint, toCoordinateFrom: nil)
        
        if mapView.annotations?.count != nil, let existingAnnotations = mapView.annotations {
            mapView.removeAnnotations(existingAnnotations)
            let pin = MGLPointAnnotation()
            pin.coordinate = coordinate
            mapView.addAnnotation(pin)
        }
        else {
        
        let pin = MGLPointAnnotation()
        pin.coordinate = coordinate
        
        let shapeSource = MGLShapeSource(identifier: "marker-source", shape: pin, options: nil)
        
        let shapeLayer = MGLSymbolStyleLayer(identifier: "marker-style", source: shapeSource)
        
        mStyle.addSource(shapeSource)
        mStyle.addLayer(shapeLayer)
        mapView.addAnnotation(pin)
        }
        
       
        
        
 
    }
}
