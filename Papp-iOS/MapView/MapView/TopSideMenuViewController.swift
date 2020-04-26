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

class TopSideMenuViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var heartLabel: UILabel!
    
    let user = Auth.auth().currentUser
    
    let fireStoreController = FirestoreController.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = user?.displayName
        fireStoreController.setRoundFacebookProfileImage(profileImageView)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("Disappear")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
