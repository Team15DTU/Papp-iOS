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
        confirmButton.removeTarget(self, action: #selector(onClickConfirmTip), for: .touchUpInside)
        cancelButton.removeTarget(self, action: #selector(onClickCancelTip), for: .touchUpInside)
    }
    
    @objc private func onClickConfirmTip() {
        if mapView.annotations?.count == 1 {
            let tipViewController = TipViewController(self)
          //  let storyboard = UIStoryboard(name: "TipDef", bundle: nil)
            //let tipVC = storyboard.instantiateViewController(withIdentifier: "tipViewController") as! tipViewController
                  
            
            
            tipViewController.mapViewForSnapshot = mapView
            
            tipViewController.view.backgroundColor = .darkGray
            
            navigationController?.pushViewController(tipViewController, animated: true)
            
           // tipVC.modalPresentationStyle = .fullScreen

            //present(tipVC, animated: false, completion: nil)
        }
    }
    
    @objc private func onClickCancelTip() {
        tabBar(mapTabBar, didSelect: tabBarItems[0])
        mapTabBar.selectedItem = tabBarItems[0]
    }
 
    
    //MARK: Support methods
    
    private func showLayout() {
        animateUpLocationIcon()
        addButtons()
        addTopText()
    }
    
    private func hideLayout() {
        animateDownLocationIcon()
        confirmButton.removeFromSuperview()
        cancelButton.removeFromSuperview()
        topText.removeFromSuperview()
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
        confirmButton.addTarget(self, action: #selector(onClickConfirmTip), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(onClickCancelTip), for: .touchUpInside)
    }
    
    private func addTopText() {
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
