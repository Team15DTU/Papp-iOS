//
//  ProfileHeaderView.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 28/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let firestoreController = FirestoreController.init()
    
    let profileImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backgroundImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "backgroundmountain")
        imageview.layer.opacity = 0.7
        imageview.contentMode = .scaleToFill
        return imageview
    }()
    
    func addViews () {
        firestoreController.setRoundFacebookProfileImage(profileImageView)
        addSubview(profileImageView)
        addSubview(textLabel)
        addSubview(backgroundImageView)
        bringSubviewToFront(profileImageView)
    }
    
    func setupConstraints () {
        textLabel.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: layoutMarginsGuide.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        backgroundImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
    }

}
