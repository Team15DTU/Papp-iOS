//
//  EditProfileViewController.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 29/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let dataArray = ["Danmark", "England", "Deutschland", "España", "France", "Sverige"]
    
    let contentView: EditProfileContentView = {
        let view = EditProfileContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setupViews()
        view.setupConstraints()
        return view
    }()
    
    var savedCountry: String!
    
    let firestoreController = FirestoreController.init()
    
    let userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(contentView)
        
        hideKeyboardWhenTappedAround()
        
        //Set savedCountry to the one that is saved
        savedCountry = userDefaults.string(forKey: "country")
        
        contentView.locationPicker.dataSource = self
        contentView.locationPicker.delegate = self
        contentView.editProfileButton.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
        
        
        if savedCountry != nil {
            contentView.locationPicker.selectRow(dataArray.firstIndex(of: savedCountry)!, inComponent: 0, animated: false)
        }
        
        
        contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        //contentView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func saveProfile() {
        
        guard savedCountry != nil else { return }
        
        if contentView.descriptionTextField.text != "" {
            userDefaults.set(contentView.descriptionTextField.text, forKey: "descriptionText")
            firestoreController.editDescription(contentView.descriptionTextField.text!)
        }
        
        userDefaults.set(savedCountry, forKey: "country")
        
        firestoreController.editCountry(savedCountry)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
