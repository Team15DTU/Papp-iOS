//
//  ViewController.swift
//  Papp
//
//  Created by Nikolaj Wassmann on 07/02/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func sendToMapView() {
        
        let storyboard = UIStoryboard(name: "MapView", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "MapView")
        
        secondVC.modalPresentationStyle = .fullScreen
        
        present(secondVC, animated: false, completion: nil)
    }
    
    
    @IBAction func sendToSignIn() {
        
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "Sign")
        
        secondVC.modalPresentationStyle = .fullScreen
        
        present(secondVC, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // MARK: If user is logged in and have given permissions, send them to MapViewController using below
        /*
         let storyboard = UIStoryboard(name: "test", bundle: nil)
         let secondVC = storyboard.instantiateViewController(identifier: "LoginViewController")
         
         secondVC.modalPresentationStyle = .fullScreen
         
         present(secondVC, animated: false, completion: nil)
         */
        
        // MARK: Else send them to LoginViewController
        
        
    }
    
    


}

