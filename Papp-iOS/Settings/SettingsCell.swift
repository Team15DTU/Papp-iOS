//
//  SettingsCell.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 22/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsCell: UITableViewCell {
    
    // MARK: - Fields
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    let userDefaults = UserDefaults()
    
    var sectionType: SectionType? {
        didSet {
            guard let sectionType = sectionType else { return }
            
            textLabel?.text = sectionType.description
            switchControlNotification.isHidden = !sectionType.containsNotificationSwitch
            switchControlReport.isHidden = !sectionType.containsReportSwitch
        }
    }
    
    lazy var switchControlNotification: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = userDefaults.bool(forKey: "Notification")
        switchControl.onTintColor = UIColor(red: 103/255, green: 150/255, blue: 190/255, alpha: 1)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(handleSwitchNotificationAction), for: .valueChanged)
        return switchControl
    }()
    
    lazy var switchControlReport: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = userDefaults.bool(forKey: "Report")
        switchControl.onTintColor = UIColor(red: 103/255, green: 150/255, blue: 190/255, alpha: 1)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(handleSwitchReportAction), for: .valueChanged)
        return switchControl
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(switchControlNotification)
        switchControlNotification.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControlNotification.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        addSubview(switchControlReport)
        switchControlReport.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControlReport.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selector
    
    @objc func handleSwitchNotificationAction(sender: UISwitch) {
         if sender.isOn {
            addNotifications()
            }
         else {
            userDefaults.set(false, forKey: "Notification")
        }
        }
       
    
    @objc func handleSwitchReportAction(sender: UISwitch) {
        if sender.isOn {
            userDefaults.set(true, forKey: "Report")
        }
        else {
            userDefaults.set(false, forKey: "Report")
        }
    }
    
    func permissionForNotification(_ granted: Bool){
        if granted {
            self.showNotification(userNotificationCenter)
            switchControlNotification.isOn = true
            userDefaults.set(true, forKey: "Notification")
        }
        else {
            switchControlNotification.isOn = false
            userDefaults.set(false, forKey: "Notification")
        }
        
    }
    
}
