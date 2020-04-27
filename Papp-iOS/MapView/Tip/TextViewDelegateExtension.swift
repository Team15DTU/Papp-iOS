//
//  TextViewDelegateExtension.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 27/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import Foundation
import UIKit

extension TipViewController {
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if tipTextView.textColor == UIColor.lightGray {
            tipTextView.text = ""
            tipTextView.textColor = UIColor.white
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {

        if tipTextView.text == "" {
            tipTextView.text = "Skriv dit tip her"
            tipTextView.textColor = UIColor.lightGray
        }
    }
    
    func displayNoTextAlert () {
        let alert = UIAlertController(title: "Fejl!", message: "For at kunne indsende et tip skal du skrive noget tekst til tippet", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil)
        )
        present(alert, animated: true)
    }
    
    func displayCompletedAlert () {
        let alert = UIAlertController(title: "Bekræftet", message: "Dit tip er hermed blevet registeret", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Fedt!", style: .default, handler: nil)
        )
        present(alert, animated: true)
    }
    
}
