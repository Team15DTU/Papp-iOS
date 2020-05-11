//
//  AnimateExtension.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 20/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit

extension MapViewController {
    
    func animateUpLocationIcon() {
        UIView.animate(withDuration: 0.3, animations: {
            self.trackButton.transform = self.trackButton.transform.translatedBy(x: 0, y: -50)
        }, completion: nil)
    }
    
    func animateDownLocationIcon() {
        UIView.animate(withDuration: 0.3, animations: {
            self.trackButton.transform = self.trackButton.transform.translatedBy(x: 0, y: 50)
        }, completion: nil)
    }
}
