//
//  TTALocale.swift
//  Translator
//
//  Created by admin on 11.02.21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

struct TTAAppLocale {
    let name: String
    let code: TTALocaleName
    let isRTL: Bool
}

enum TTALocaleName: String {
    case english = "en"
    case arabic = "ar"

    var description: String {
        return self.rawValue
    }
}

extension UserDefaults {
    
    var appLocale: TTALocaleName {
        get {
            register(defaults: [#function: TTALocaleName.english.description])
            return TTALocaleName(rawValue: string(forKey: #function)!) ?? .english
        } set {
            set(newValue.rawValue, forKey: #function)
        }
    }
}
