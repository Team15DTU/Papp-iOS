//
//  SettingsLocationViewController.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 22/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit

class SettingsLocationViewController: UIViewController {
    
    let middleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lokation"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(middleLabel)
        middleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        middleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // Do any additional setup after loading the view.
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
