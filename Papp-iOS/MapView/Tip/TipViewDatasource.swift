//
//  TipViewDatasource.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 27/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import Foundation
import UIKit

extension TipViewController {
    
    func setUpTextView(){
        tipTextView.delegate = self
        tipTextView.text = "Skriv dit tip her"
        tipTextView.layer.borderColor = UIColor.white.cgColor
        tipTextView.layer.borderWidth = 2.0
        tipTextView.layer.cornerRadius = 10
        tipTextView.font = UIFont.systemFont(ofSize: 16)
        tipTextView.backgroundColor = .clear
        tipTextView.textColor = UIColor.lightGray
        view.addSubview(tipTextView)
        
        tipTextView.translatesAutoresizingMaskIntoConstraints = false
        
        tipTextView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 20).isActive = true
        tipTextView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -20).isActive = true
        
        tipTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -210).isActive = true
        
        tipTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func addImageView() {
        snapShotImageView.layer.cornerRadius = 10
        view.addSubview(snapShotImageView)
        
        snapShotImageView.layer.masksToBounds = true
        
        snapShotImageView.contentMode = .scaleAspectFill
        
        snapShotImageView.translatesAutoresizingMaskIntoConstraints = false
        
        snapShotImageView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 20).isActive = true
        
        snapShotImageView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -20).isActive = true
        
        snapShotImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 60).isActive = true
        
        snapShotImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        
        
    }
    
    func addButtons(){
        confirmButton.setTitle("Indsend tip", for: .normal)
        confirmButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        confirmButton.backgroundColor = UIColor.init(red: 103/255, green: 150/255, blue: 190/255, alpha: 1)
        confirmButton.layer.cornerRadius = 20
        view.addSubview(confirmButton)
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -25).isActive = true
        confirmButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -10).isActive = true
        
        
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        
        cancelButton.setTitle("Annuller", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        cancelButton.backgroundColor = UIColor.gray
        cancelButton.layer.cornerRadius = 20
        view.addSubview(cancelButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -25).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 10).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        confirmButton.addTarget(self, action: #selector(onClickConfirm), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(onClickCancel), for: .touchUpInside)
        
    }
    
    
    
    
}
