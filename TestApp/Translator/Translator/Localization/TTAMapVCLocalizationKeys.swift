//
//  TTAMapVCLocalizationKeys.swift
//  Translator
//
//  Created by admin on 9.02.21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

enum TTAMapVCKeys: String, StringsLocalizedProtocol {
    
    typealias T = Self
    
    case noAccessAlertTitle = "locationAccessAlertTitle"
    case noAccessAlertMessage = "locationAccessAlertMessage"
    case alertSettingsButtonTitle = "locationAccessAlertSettingsButtonTitle"
    case alertCancelButtonTitle = "locationAccessAlertCancelButtonTitle"
    case noLocationDataAlertTitle = "noLocationDataAlertTitle"
    case noLocationDataAlertMessage = "noLocationDataAlertMessage"
    case noLocationDataAlertButton = "noLocationDataAlertButton"
    
    static func localizedString(type: TTAMapVCKeys) -> String {
        return NSLocalizedString(type.rawValue, comment: "")
    }

}
