//
//  ProfileContentView.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 29/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit

class ProfileContentView: UIView {
    
    
    let userNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Test label"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func setupViews() {
        addSubview(userNameLabel)
    }
    
    
    func setupConstraints() {
        userNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

}
