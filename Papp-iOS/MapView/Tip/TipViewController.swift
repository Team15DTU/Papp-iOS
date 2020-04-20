//
//  TipViewController.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 15/03/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    @IBOutlet weak var SendTipTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        SendTipTextField.borderStyle = UITextField.BorderStyle.roundedRect
        SendTipTextField.layer.masksToBounds = true
        SendTipTextField.layer.borderColor = UIColor.white.cgColor
        SendTipTextField.layer.borderWidth = 1.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
