//
//  LoginViewController.swift
//  Papp
//
//  Created by Nikolaj Wassmann on 10/02/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//


import UIKit
import Firebase

class SignViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField?
    
    @IBOutlet weak var passwordTextField: UITextField?
    
    @IBOutlet weak var emailSignUpTextField: UITextField?
    
    @IBOutlet weak var nameSignUpTextField: UITextField?
    
    @IBOutlet weak var passwordSignUpTextField: UITextField?
    
    @IBOutlet weak var emailForgotTextField: UITextField?
    
    @IBAction func login() {
        Auth.auth().signIn(withEmail: emailTextField!.text!, password: passwordTextField!.text!) { [weak self] authResult, error in
            guard self != nil else { return }
        // [START_EXCLUDE]
            if error != nil {
              print("Error! Could not login")
              return
            }
            let storyboard = UIStoryboard(name: "MapView", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "MapView")
          
            secondVC.modalPresentationStyle = .fullScreen
          
            self?.present(secondVC, animated: false, completion: nil)
        }
    }
    
    @IBAction func signUp() {
        Auth.auth().createUser(withEmail: emailSignUpTextField!.text!, password: passwordSignUpTextField!.text!){ [weak self] authResult, error in
            guard self != nil else { return }
        // [START_EXCLUDE]
            if error != nil {
              print("Error! Could not create user")
              return
            }
            let storyboard = UIStoryboard(name: "MapView", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "MapView")
          
            secondVC.modalPresentationStyle = .fullScreen
          
            self?.present(secondVC, animated: false, completion: nil)
        }
    }
    
    @IBAction func forgotPassword() {
        Auth.auth().sendPasswordReset(withEmail: emailForgotTextField!.text!) { error in
          // [START_EXCLUDE]
            if error != nil {
                print("Error! Could not send reset email")
              return
            }
            let alertController = UIAlertController(title: "Email Reset", message:
                "We have send you reset password email", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

            self.present(alertController, animated: true, completion: nil)
          // [END_EXCLUDE]
        }
    }
    
    @IBAction func toSignUp() {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "Sign")
        
        secondVC.modalPresentationStyle = .fullScreen
        
        present(secondVC, animated: false, completion: nil)
    }
    
    @IBAction func toSignIn() {
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "Sign")
        
        secondVC.modalPresentationStyle = .fullScreen
        
        present(secondVC, animated: false, completion: nil)
    }
    
    @IBAction func toForgotPassword() {
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "Sign")
        
        secondVC.modalPresentationStyle = .fullScreen
        
        present(secondVC, animated: false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        emailTextField?.delegate = self
        passwordTextField?.delegate = self
        emailSignUpTextField?.delegate = self
        nameSignUpTextField?.delegate = self
        passwordSignUpTextField?.delegate = self
        emailForgotTextField?.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
}
