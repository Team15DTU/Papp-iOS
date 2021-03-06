//
//  SettingsSection.swift
//  Papp-iOS
//
//  Created by Nikolaj Wassmann on 22/04/2020.
//  Copyright © 2020 Nikolaj Wassmann. All rights reserved.
//

protocol SectionType: CustomStringConvertible {
    var containsNotificationSwitch: Bool { get }
    var containsReportSwitch: Bool { get }
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case Social
    case Communications
    case Information
    
    var description: String {
        switch self {
        case .Social: return "Generelt"
        case .Communications: return "Kommunikation"
        case .Information: return "Information"
        }
    }
    
}

enum GeneralOptions: Int, CaseIterable, SectionType {
    case location
    case map
    
     var description: String {
        switch self {
        case .location: return "Lokation"
        case .map: return "Kort"
        }
    }
    
    var containsNotificationSwitch: Bool {
        return false
    }
    var containsReportSwitch: Bool {
        return false
    }
}

enum CommuncationOptions: Int, CaseIterable, SectionType {
    case notifications
    case reportCrashes
    
    var description: String {
        switch self {
        case .notifications: return "Notifikationer"
        case .reportCrashes: return "Rapportér Nedbrud"
        }
    }
    
    var containsNotificationSwitch: Bool {
        switch self {
        case .notifications: return true
        case .reportCrashes: return false
        }
    }
    var containsReportSwitch: Bool {
        switch self {
        case .notifications: return false
        case .reportCrashes: return true
        }
    }
}

enum InformationOptions: Int, CaseIterable, SectionType {
    case aboutUs
    case reportProblem
    case faq
    case help
    
    var description: String {
        switch self {
        case .aboutUs: return "Om Os"
        case .reportProblem: return "Rapportér et problem"
        case .faq: return "FAQ"
        case .help: return "Hjælp"
        }
    }
    
    var containsNotificationSwitch: Bool {
        switch self {
        case .aboutUs: return false
        case .reportProblem: return false
        case .faq: return false
        case .help: return false
        }
    }
    var containsReportSwitch: Bool {
        return false
    }
}
