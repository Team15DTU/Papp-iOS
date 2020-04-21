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
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dispatchLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dispatchLogin()
    }
    
    //MARK: Support methods
    
    private func dispatchLogin() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                if (AccessToken.current != nil){
                    print("Facebook login")
                    self.resetRoot()
                    self.sendToMapView()
                }
                else if (Auth.auth().currentUser != nil){
                       print("Firebase login")
                    self.resetRoot()
                    self.sendToMapView()
                }
                else {
                    self.sendToSignIn()
                }
        })
    }
    
    func resetRoot() {
           guard let rootVC = UIStoryboard.init(name: "MapView", bundle: nil).instantiateViewController(withIdentifier: "MapView") as? MapViewController else {
               return
           }
           let navigationController = UINavigationController(rootViewController: rootVC)

           UIApplication.shared.windows.first?.rootViewController = navigationController
           UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    private func sendToMapView() {
         
         let storyboard = UIStoryboard(name: "MapView", bundle: nil)
         let secondVC = storyboard.instantiateViewController(identifier: "MapView")
         
         secondVC.modalPresentationStyle = .fullScreen
         
         present(secondVC, animated: false, completion: nil)
     }
     
     
     private func sendToSignIn() {
         
         let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
         let secondVC = storyboard.instantiateViewController(identifier: "Sign")
         
         secondVC.modalPresentationStyle = .fullScreen
         
         present(secondVC, animated: false, completion: nil)
     }

}

