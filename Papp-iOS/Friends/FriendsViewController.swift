//
//  FriendsViewController.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 28/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()

        // Do any additional setup after loading the view.
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 103/255, green: 150/255, blue: 190/255, alpha: 1)
        navigationItem.title = "Inviter Venner"
    }

}
