//
//  TipExtension.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 14/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit
import Mapbox

extension MapViewController
{
    
    func enterTip() {
        showLayout()
        enableMapClick()
    }
    
    func exitTip() {
        hideLayout()
        disableMapClick()
        removeAnnotations()
    }
    
    private func showLayout() {
        
    }
    
    private func hideLayout() {
        
    }
    
    private func enableMapClick() {
        onMapTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
        for recognizer in mapView.gestureRecognizers! where recognizer is UITapGestureRecognizer {
            onMapTapRecognizer.require(toFail: recognizer)
        }
        mapView.addGestureRecognizer(onMapTapRecognizer)
    }
    
    private func disableMapClick() {
        mapView.removeGestureRecognizer(onMapTapRecognizer)
    }
    
    private func removeAnnotations(){
        if (mapView.annotations?.count == 1) {
        mapView.removeAnnotations(mapView.annotations!)
        }
    }
    
    
}
