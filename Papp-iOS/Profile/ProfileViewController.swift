//
//  ProfileViewController.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 28/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.addViews()
        view.setupConstraints()
        return view
    }()
    
    let profileContentView: ProfileContentView = {
        let view = ProfileContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setupViews()
        view.setupConstraints()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 103/255, green: 150/255, blue: 190/255, alpha: 1)
        configureNavigationBar()
        
        view.addSubview(profileHeaderView)
        view.addSubview(profileContentView)
        
        profileHeaderView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        profileHeaderView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        profileHeaderView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        profileHeaderView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        profileContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        profileContentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        profileContentView.topAnchor.constraint(equalTo: profileHeaderView.bottomAnchor).isActive = true
        
        

        // Do any additional setup after loading the view.
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 103/255, green: 150/255, blue: 190/255, alpha: 1)
        navigationItem.title = "Min Profil"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Rediger", style: .plain, target: self, action: #selector(editUser))
        
    }
    
    @objc func editUser() {
        let editProfileViewController = EditProfileViewController()
        editProfileViewController.view.backgroundColor = UIColor(red: 103/255, green: 150/255, blue: 190/255, alpha: 1)
        navigationController?.pushViewController(editProfileViewController, animated: true)
    }

}
