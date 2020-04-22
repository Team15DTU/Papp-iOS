//
//  TipViewController.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 15/03/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit

class TipViewController: UIViewController, UITextViewDelegate {

    let confirmButton: UIButton = UIButton()
    
    let cancelButton: UIButton = UIButton()
    
    @IBOutlet weak var SendTipTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SendTipTextView.delegate = self
        SendTipTextView.layer.borderColor = UIColor.white.cgColor
        SendTipTextView.layer.borderWidth = 2.0
        SendTipTextView.layer.cornerRadius = 10
        SendTipTextView.clipsToBounds = true
        SendTipTextView.textColor = UIColor.lightGray
        
        addButtons()
        // Do any additional setup after loading the view.
    }

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
    
    @objc private func onClickConfirm() {
        
    }
    
    @objc private func onClickCancel() {
        dismiss(animated: false, completion: nil)
    }

    private func addButtons(){
        confirmButton.setTitle("Indsend tip", for: .normal)
        confirmButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        confirmButton.backgroundColor = UIColor.init(red: 103/255, green: 150/255, blue: 190/255, alpha: 1)
        confirmButton.layer.cornerRadius = 20
        view.addSubview(confirmButton)
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -25).isActive = true
        confirmButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -10).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
    
        
        cancelButton.setTitle("Annuller", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        cancelButton.backgroundColor = UIColor.gray
        cancelButton.layer.cornerRadius = 20
        view.addSubview(cancelButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -25).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 10).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        confirmButton.addTarget(self, action: #selector(onClickConfirm), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(onClickCancel), for: .touchUpInside)
    
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

