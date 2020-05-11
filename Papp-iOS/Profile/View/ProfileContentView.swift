//
//  ProfileContentView.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 29/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit

class ProfileContentView: UIView {
    
    let descriptionHeaderLabel : UILabel = {
        let label = UILabel()
        label.text = "Om mig"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Her kan du skriver noget om dig selv"
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationHeader : UILabel = {
        let label = UILabel()
        label.text = "Land"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationLabel : UILabel = {
        let label = UILabel()
        label.text = "Danmark"
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func setupViews() {
        addSubview(descriptionLabel)
        addSubview(descriptionHeaderLabel)
        addSubview(locationHeader)
        addSubview(locationLabel)
    }
    
    
    func setupConstraints() {
        descriptionHeaderLabel.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor).isActive = true
        descriptionHeaderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        descriptionLabel.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: descriptionHeaderLabel.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        locationHeader.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor).isActive = true
        locationHeader.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
        
        locationLabel.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalTo: locationHeader.bottomAnchor, constant: 20).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
    }

}
