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
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected \(item.title)")
        
        
        
        
        
        
        
        
        if item.tag == 2{
         
        }
        if item.tag == 3{
            present(rightMenuNavigationController, animated: true, completion: nil)
        }
        
    
        
        //dismiss(animated: true, completion: nil)
    }
}
