//
//  SignInExtension.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 16/03/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import Lottie

extension SignViewController {
    
    //MARK: Public methods
    
    func signInWithFirebase() {
        let animation = Animation.named("loading")
        signInAnimationView.animation = animation
        signInAnimationView.loopMode = .loop
        signInAnimationBackground.isHidden = false
        signInAnimationView.play()
        Auth.auth().signIn(withEmail: emailTextField!.text!, password: passwordTextField!.text!) { [weak self] authResult, error in
            guard self != nil else { return }
        // [START_EXCLUDE]
            if error != nil {
                self?.signInAnimationView.stop()
                self?.signInAnimationBackground.isHidden = true
              print("Error! Could not login \(error!.localizedDescription)")
              return
            }
            self?.signInAnimationView.stop()
            self?.signInAnimationBackground.isHidden = true
            self?.resetRoot()
        }
    }
    
    func signInWithFacebook() {
        let loginManager=LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self, handler: { result, error in

            guard let result = result else {
                print("No result found")
                return
            }
            if result.isCancelled {
                print("Cancelled \(error!.localizedDescription)")
            } else if let error = error {
                print("Process error \(error.localizedDescription)")
            } else {
                print("Logged in")
                self.facebookCreditialsToFirestore()
            }
        })
    }

    func transitionToSignIn() {
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "Sign")
        
        secondVC.modalPresentationStyle = .fullScreen
        
        present(secondVC, animated: false, completion: nil)
    }
    
    //MARK: Support methods
    
    private func facebookCreditialsToFirestore() {
        let animation = Animation.named("loading")
        signInAnimationView.animation = animation
        signInAnimationView.loopMode = .loop
        signInAnimationBackground.isHidden = false
        signInAnimationView.play()
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        // Perform login by calling Firebase APIs
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            self.signInAnimationView.stop()
            self.signInAnimationBackground.isHidden = true
            print("Login error: \(error.localizedDescription)")
            
            let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
            return
          }
            self.fireStoreController.createUser()
            self.signInAnimationView.stop()
            self.signInAnimationBackground.isHidden = true
            self.resetRoot()
        }
    }
    
}
