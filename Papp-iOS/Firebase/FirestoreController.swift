//
//  FirestoreController.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 09/03/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import Foundation
import Firebase
import FBSDKCoreKit

class FirestoreController {
    
    var facebookName: String?
    var facebookEmail: String?
    
    enum Collections: String {
        case User = "User"
        case Tips = "Tips"
        case Pvagt = "Pvagt"
    }
    
    init() {
        
    }
    
    
    let db = Firestore.firestore()
    
    
    func createUser(name: String, email: String ) {
        db.collection(Collections.User.rawValue).addDocument(data: ["name" : name, "email": email] ) {
            error in
            if let error = error {
                print("ERROR: Could not add user \(error)")
            } else {
                print("Sucessfully added user to DB")
            }
        }
    }
    
    func createUser(){
        getDataFromFacebook()
        db.collection(Collections.User.rawValue).addDocument(data: ["name": facebookName as Any, "email" : facebookEmail as Any] ) {
            error in
            if let error = error {
                print("ERROR: Could not add user \(error)")
            } else {
                print("Sucessfully added user to DB")
            }
        }
    }
    
    
    func getDataFromFacebook() {
       if let user = Auth.auth().currentUser {
       for profile in user.providerData {
        facebookName = profile.displayName
        facebookEmail = profile.email
       }
       }
    }
}
