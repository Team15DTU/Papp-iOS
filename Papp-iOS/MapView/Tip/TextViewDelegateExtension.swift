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

        if SendTipTextView.textColor == UIColor.lightGray {
            SendTipTextView.text = ""
            SendTipTextView.textColor = UIColor.white
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {

        if SendTipTextView.text == "" {
            SendTipTextView.text = "Skriv dit tip her"
            SendTipTextView.textColor = UIColor.lightGray
        }
    }
    
    func displayAlert () {
        let alert = UIAlertController(title: "Fejl!", message: "For at kunne indsende et tip skal du skrive noget tekst til tippet", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil)
        )
        present(alert, animated: true)
    }
    
}
