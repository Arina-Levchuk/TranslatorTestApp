//
//  TTAMapVCLocalizationKeys.swift
//  Translator
//
//  Created by admin on 9.02.21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

enum TTAMapVCKeys: String {
    case alertTitle, alertMessage, alertSettingsButtonTitle, alertCancelButtonTitle
    
    var mapVCKey: String {
        switch self {
        case .alertTitle:
            return NSLocalizedString("locationAccessAlertTitle", comment: "")
        case .alertMessage:
            return NSLocalizedString("locationAccessAlertMessage", comment: "")
        case .alertSettingsButtonTitle:
            return NSLocalizedString("locationAccessAlertSettingsButtonTitle", comment: "")
        case .alertCancelButtonTitle:
            return NSLocalizedString("locationAccessAlertCancelButtonTitle", comment: "")
        }
    }
}
