//
//  ForgotPasswordExtension.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 16/03/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit
import FirebaseAuth

extension SignViewController {
    
    //MARK: Public methods
    
    func sendNewPassword() {
        Auth.auth().sendPasswordReset(withEmail: emailForgotTextField!.text!) { error in
          // [START_EXCLUDE]
            if error != nil {
                print("Error! Could not send reset email \(error!.localizedDescription)")
              return
            }
            let alertController = UIAlertController(title: "Email Reset", message:
                "We have send you reset password email", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alertController, animated: true, completion: nil)
          // [END_EXCLUDE]
        }
    }
    
    func transitionToForgotPassword() {
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "Sign")
               
        secondVC.modalPresentationStyle = .fullScreen
               
        present(secondVC, animated: false, completion: nil)
    }
    
}
