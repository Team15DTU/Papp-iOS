//
//  TopSideMenuViewController.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 24/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import SideMenu

class TopSideMenuViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var heartLabel: UILabel!
    
    let fireStoreController = FirestoreController.init()
    
    var previousSelectedTabBarItem: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fireStoreController.getNameCurrentOfUser { (name) -> (Void) in
            self.nameLabel.text = name
        }
        
        fireStoreController.setRoundFacebookProfileImage(profileImageView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        MapViewController.GlobalVariables.tabBar!.selectedItem = MapViewController.GlobalVariables.items![MapViewController.GlobalVariables.previousItem]
        
    }
    
}
