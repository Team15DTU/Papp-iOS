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
import FBSDKCoreKit
import FirebaseAuth


class MapViewController: UIViewController, MGLMapViewDelegate, UITabBarDelegate {
    
    //MARK: Fields
    
    // Had to make Globalvariables to store control tabbar navigation
    // If we could have used UITabBarController we wouldnt have to do this
    struct GlobalVariables {
        static var previousItem: Int = 0
        static var tabBar: UITabBar?
        static var items: [UITabBarItem]?
    }
    
    var rightMenuNavigationController: SideMenuNavigationController!
    
    var mStyle: MGLStyle!
    
    var onMapTapRecognizer = UITapGestureRecognizer()
    
    var onTipTapRecognizer = UITapGestureRecognizer()
    
    var previousSelectedTabBarItem: Int!
    
    let confirmButton: UIButton = UIButton()
    
    let cancelButton: UIButton = UIButton()
    
    let topText: UILabel = UILabel()
    
    let fireStoreController = FirestoreController.init()
    
    let pin: MGLPointFeature? = MGLPointFeature()
    
    @IBOutlet weak var mapView: MGLMapView!
    
    @IBOutlet weak var mapTabBar: UITabBar!
    
    @IBOutlet var tabBarItems: [UITabBarItem]!
    
    @IBOutlet weak var trackButton: UIButton!
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set backbutton text to nothing
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationController?.view.backgroundColor = UIColor.white
        
        rightMenuNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as? SideMenuNavigationController
        
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: mapView, forMenu: .right)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view, forMenu: .right)
        SideMenuManager.default.rightMenuNavigationController?.statusBarEndAlpha = 0
        SideMenuManager.default.rightMenuNavigationController?.presentationStyle = .menuSlideIn
        
        mapTabBar.selectedItem = tabBarItems[0]
        
        GlobalVariables.previousItem = mapTabBar.selectedItem!.tag
        
        mapTabBar.delegate = self
        
        enableTipMapTap()
        
        //MARK: Needs to be moved in to its own style 
        trackButton.layer.cornerRadius = trackButton.frame.width/2
        trackButton.layer.borderWidth = 1
        trackButton.layer.borderColor = UIColor.lightGray.cgColor
        
        mapView.showsUserLocation = true
        
        mapView.userTrackingMode = .follow
        
        mapView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if GlobalVariables.previousItem == 3{
            mapTabBar.selectedItem = tabBarItems[0]
        }
        else {
            mapTabBar.selectedItem = tabBarItems[GlobalVariables.previousItem]
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: User interaction
    
    @IBAction func onClickTrackButton() {
        mapView.userTrackingMode = .follow
        
        trackButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
    }
    
    
}
