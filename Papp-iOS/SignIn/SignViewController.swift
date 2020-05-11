//
//  LoginViewController.swift
//  Papp
//
//  Created by Nikolaj Wassmann on 10/02/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//


import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import Lottie

class SignViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Fields
    
    let fireStoreController = FirestoreController.init()
    
    @IBOutlet weak var signUpAnimationBackground: UIView!
    
    @IBOutlet weak var signUpAnimationView: AnimationView!
    
    @IBOutlet weak var signInAnimationBackground: UIView!
    
    @IBOutlet weak var signInAnimationView: AnimationView!
    
    @IBOutlet weak var loginButton: UIButton?
    
    @IBOutlet weak var emailTextField: UITextField?
    
    @IBOutlet weak var passwordTextField: UITextField?
    
    @IBOutlet weak var emailSignUpTextField: UITextField?
    
    @IBOutlet weak var nameSignUpTextField: UITextField?
    
    @IBOutlet weak var passwordSignUpTextField: UITextField!
    
    @IBOutlet weak var emailForgotTextField: UITextField?
    
    @IBOutlet weak var repeatPassword: UITextField?
    
    @IBOutlet weak var facebookButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton?
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        setUpGreyButtons(button: loginButton)
        setUpGreyButtons(button: signUpButton)
        setUpGreyButtons(button: forgotPasswordButton)
        setUpFacebookbutton()

        
        // Add delegate to textfields
        emailTextField?.delegate = self
        passwordTextField?.delegate = self
        emailSignUpTextField?.delegate = self
        nameSignUpTextField?.delegate = self
        passwordSignUpTextField?.delegate = self
        emailForgotTextField?.delegate = self
        repeatPassword?.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
                
        if emailTextField?.text != nil && passwordTextField?.text != nil{
        setUpTextFields(emailTextField!)
        setUpTextFields(passwordTextField!)
        }
        
        if emailSignUpTextField?.text != nil && nameSignUpTextField?.text != nil {
            setUpTextFields(emailSignUpTextField!)
            setUpTextFields(nameSignUpTextField!)
            setUpTextFields(passwordSignUpTextField!)
            setUpTextFields(repeatPassword!)
        }
        
        if emailForgotTextField?.text != nil {
            setUpTextFields(emailForgotTextField!)
        }
    }
    
    //MARK: Delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case emailTextField:
            emailTextField?.resignFirstResponder()
            passwordTextField?.becomeFirstResponder()
            break
        case passwordTextField:
            login()
            self.view.endEditing(true)
            break
        case nameSignUpTextField:
            nameSignUpTextField?.resignFirstResponder()
            emailSignUpTextField?.becomeFirstResponder()
            break
        case emailSignUpTextField:
            emailSignUpTextField?.resignFirstResponder()
            passwordSignUpTextField?.becomeFirstResponder()
            break
        case passwordSignUpTextField:
            passwordSignUpTextField?.resignFirstResponder()
            repeatPassword?.becomeFirstResponder()
            break
        case repeatPassword:
            signUp()
            self.view.endEditing(true)
            break
        case emailForgotTextField:
            forgotPassword()
            self.view.endEditing(true)
            break
        default:
            print("Cant find next button")
        }
        return true
    }
    
    //MARK: User interaction
       
       @IBAction func login() {
           signInWithFirebase()
       }
       
       @IBAction func facebookLogin() {
           signInWithFacebook()
       }
       
       @IBAction func signUp() {
           signUpWithFirestore()
       }
       
       @IBAction func forgotPassword() {
           sendNewPassword()
       }
       
       @IBAction func toSignUp() {
           transitionToSignUp()
       }
       
       @IBAction func toSignIn() {
           transitionToSignIn()
       }
       
       @IBAction func toForgotPassword() {
          transitionToForgotPassword()
       }
    
    //MARK: Public methods
    
     func resetRoot() {
        guard let rootVC = UIStoryboard.init(name: "MapView", bundle: nil).instantiateViewController(withIdentifier: "MapView") as? MapViewController else {
                return
            }
            let navigationController = UINavigationController(rootViewController: rootVC)

            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    
}

//MARK: Extension

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
