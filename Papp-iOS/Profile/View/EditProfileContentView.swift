//
//  EditProfileContentView.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 29/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit

class EditProfileContentView: UIView {
    
    let descriptionHeader: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Om mig"
        return label
    }()
    
    let descriptionTextField: UITextField = {
        let sampleTextField =  UITextField()
        sampleTextField.placeholder = "Skriv din beskrivelse her"
        sampleTextField.tintColor = .white
        sampleTextField.font = UIFont.systemFont(ofSize: 16)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.backgroundColor = .clear
        sampleTextField.textColor = .white
        sampleTextField.returnKeyType = UIReturnKeyType.default
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        sampleTextField.translatesAutoresizingMaskIntoConstraints = false
        return sampleTextField
    }()
    
    let locationHeader: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Land"
        return label
    }()
    
    let locationPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tintColor = .white
        return picker
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Rediger Profil", for: .normal)
        button.setTitleColor(UIColor(red: 103/255, green: 150/255, blue: 190/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        return button
    }()
    
    
    func setupViews() {
        addSubview(descriptionTextField)
        addSubview(descriptionHeader)
        addSubview(locationHeader)
        addSubview(locationPicker)
        addSubview(editProfileButton)
    }
    
    func setupConstraints() {
        
        descriptionHeader.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        descriptionHeader.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        
        descriptionTextField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        descriptionTextField.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        descriptionTextField.topAnchor.constraint(equalTo: descriptionHeader.bottomAnchor, constant: 20).isActive = true
        
        
        locationHeader.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 40).isActive = true
        locationHeader.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        locationHeader.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        locationPicker.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        locationPicker.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        locationPicker.topAnchor.constraint(equalTo: locationHeader.bottomAnchor, constant: -20).isActive = true
        
        editProfileButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        editProfileButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        editProfileButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
        editProfileButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
