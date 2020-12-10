//
//  AppearanceMode.swift
//  Translator
//
//  Created by admin on 12/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

enum AppearanceMode: String {
    case device
    case light
    case dark
    
    var description: String {
        return self.rawValue
    }
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .device:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

extension UserDefaults {
    var appearanceMode: AppearanceMode {
        get {
            register(defaults: [#function: AppearanceMode.device.description])
            return AppearanceMode(rawValue: string(forKey: #function)!) ?? .device
        } set {
            set(newValue.rawValue, forKey: #function)
        }
    }
}
