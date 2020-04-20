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
    //MARK: Public methods
    
    func enterTip() {
        showLayout()
        enableMapClick()
    }
    
    func exitTip() {
        hideLayout()
        disableMapClick()
        removeAnnotations()
    }
    
    //MARK: Support methods
    
    private func showLayout() {
        animateUpLocationIcon()
        addButtons()
        addTopText()
    }
    
    private func hideLayout() {
        animateDownLocationIcon()
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
    
    private func addButtons(){
        let confirmButton = UIButton()
        confirmButton.setTitle("Bekræft", for: .normal)
        confirmButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        confirmButton.backgroundColor = UIColor.init(red: 103/255, green: 150/255, blue: 190/255, alpha: 1)
        confirmButton.layer.cornerRadius = 20
        view.addSubview(confirmButton)
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.bottomAnchor.constraint(equalTo: mapView.layoutMarginsGuide.bottomAnchor, constant: -25).isActive = true
        confirmButton.rightAnchor.constraint(equalTo: mapView.layoutMarginsGuide.rightAnchor, constant: -10).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
    
        
        let cancelButton = UIButton()
        cancelButton.setTitle("Annuller", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        cancelButton.backgroundColor = UIColor.gray
        cancelButton.layer.cornerRadius = 20
        view.addSubview(cancelButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.bottomAnchor.constraint(equalTo: mapView.layoutMarginsGuide.bottomAnchor, constant: -25).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: mapView.layoutMarginsGuide.leftAnchor, constant: 10).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
    }
    
    private func addTopText() {
        let topText = UILabel()
        topText.text = "Markér det sted hvor du vil sætte et tip"
        topText.textAlignment = .center
        topText.textColor = UIColor.white
        topText.font = UIFont(name: "Montserrat-Regular", size: 14)
        topText.backgroundColor = UIColor.init(red: 103/255, green: 150/255, blue: 190/255, alpha: 1)
        topText.layer.cornerRadius = 20
        topText.layer.masksToBounds = true
        view.addSubview(topText)
        
        topText.translatesAutoresizingMaskIntoConstraints = false
        topText.topAnchor.constraint(equalTo: mapView.layoutMarginsGuide.topAnchor).isActive = true
        topText.leftAnchor.constraint(equalTo: mapView.layoutMarginsGuide.leftAnchor, constant: 10).isActive = true
        topText.rightAnchor.constraint(equalTo: mapView.layoutMarginsGuide.rightAnchor, constant: -10).isActive = true
        
        topText.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}