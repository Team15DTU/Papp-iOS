//
//  SignViewDatasource.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 16/03/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit

extension SignViewController {
    
    func setUpGreyButtons( button: UIButton?){
        button?.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        button?.layer.cornerRadius = 10
        button?.layer.borderWidth = 1
        button?.layer.borderColor = UIColor.white.cgColor
    }
    
    
    func setUpFacebookbutton(){
        let icon = UIImage(named: "facebook")!
        facebookButton?.setImage(icon, for: .normal)
        facebookButton?.imageView?.contentMode = .scaleAspectFit
        facebookButton?.imageEdgeInsets = UIEdgeInsets(top: 0, left: -90, bottom: 0, right: 0)
        facebookButton?.backgroundColor = UIColor.init(red: 66/255, green: 103/255, blue: 178/255, alpha: 1)
        facebookButton?.layer.cornerRadius = 10
        facebookButton?.layer.borderWidth = 1
        facebookButton?.layer.borderColor = UIColor.white.cgColor
    }
    
    func setUpTextFields(_ textField: UITextField) {
        let bottomline = CALayer()
        
        bottomline.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width-45, height: 2)
        
        bottomline.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        
        textField.borderStyle = .none
        
        textField.layer.addSublayer(bottomline)
    }
    
}
