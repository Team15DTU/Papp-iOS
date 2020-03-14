//
//  ViewController.swift
//  Papp
//
//  Created by Nikolaj Wassmann on 07/02/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signOut()
        dispatchLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        signOut()
            dispatchLogin()
    }
    
    func dispatchLogin() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                if (AccessToken.current != nil){
                    print("Facebook login")
                    self.sendToMapView()
                }
                else if (Auth.auth().currentUser != nil){
                       print("Firebase login")
                    self.sendToMapView()
                }
                else {
                    self.sendToSignIn()
                }
        })
    }
    
    func sendToMapView() {
         
         let storyboard = UIStoryboard(name: "MapView", bundle: nil)
         let secondVC = storyboard.instantiateViewController(identifier: "MapView")
         
         secondVC.modalPresentationStyle = .fullScreen
         
         present(secondVC, animated: false, completion: nil)
     }
     
     
     func sendToSignIn() {
         
         let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
         let secondVC = storyboard.instantiateViewController(identifier: "Sign")
         
         secondVC.modalPresentationStyle = .fullScreen
         
         present(secondVC, animated: false, completion: nil)
     }
    
    func signOut() {
        guard Auth.auth().currentUser != nil else {
               return
           }

           do {
              try Auth.auth().signOut()
            AccessToken.current = nil
           } catch let error as NSError {
               print(error.localizedDescription)
           }
    }
    
    


}

