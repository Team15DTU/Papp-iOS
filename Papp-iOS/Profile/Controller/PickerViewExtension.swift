//
//  PickerViewExtension.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 03/05/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import Foundation
import UIKit

extension EditProfileViewController {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        savedCountry = dataArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: dataArray[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    
}
