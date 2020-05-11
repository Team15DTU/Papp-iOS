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
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
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
        firestoreController.getNameCurrentOfUser { (name) -> (Void) in
            self.textLabel.text = name
        }
        addSubview(profileImageView)
        addSubview(textLabel)
        addSubview(backgroundImageView)
        bringSubviewToFront(profileImageView)
        bringSubviewToFront(textLabel)
    }
    
    func setupConstraints () {
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        textLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        backgroundImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
    }

}
