//
//  SignUpExtension.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 16/03/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit
import FirebaseAuth

extension SignViewController {
    
    func signUpWithFirestore() {
        let user = UserDTO.init(name: nameSignUpTextField!.text!, email: emailSignUpTextField!.text!)
        Auth.auth().createUser(withEmail: emailSignUpTextField!.text!, password: passwordSignUpTextField!.text!){ [weak self] authResult, error in
            guard self != nil else { return }
        // [START_EXCLUDE]
            if error != nil {
                print("Error! Could not create user \(error!.localizedDescription)")
              return
            }
             self?.fireStoreController.createUser(name: user.name, email: user.email)
            self?.goToMapView()
        }
    }
    
    func transitionToSignUp(){
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "Sign")
        
        secondVC.modalPresentationStyle = .fullScreen
        
        present(secondVC, animated: false, completion: nil)
    }
    
}
