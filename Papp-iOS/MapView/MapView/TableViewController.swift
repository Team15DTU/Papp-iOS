//
//  TableViewController.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 22/03/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit

class TableViewController: UITableViewController {
    
    //MARK: Fields
    
    @IBOutlet var menuTableView: UITableView!
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        
        menuTableView.delegate = self
        
    }
    
    //MARK: Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(ReportsViewController(), animated: true)
            break
        case 1:
            navigationController?.pushViewController(SettingsViewController(), animated: true)
            break
        case 2:
            navigationController?.pushViewController(ProfileViewController(), animated: true)
            break
        case 3:
            navigationController?.pushViewController(FriendsViewController(), animated: true)
            break
        case 4:
            logout()
            break
        default:
            print("ERROR: Could not find TableViewCell at indexpath \(indexPath)")
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Support methods
    
    private func logout() {
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        do {
            try Auth.auth().signOut()
            AccessToken.current = nil
            transitionToSignIn()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func transitionToSignIn() {
        
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "Sign")
        
        secondVC.modalPresentationStyle = .fullScreen
        
        present(secondVC, animated: false, completion: nil)
    }
    
}
