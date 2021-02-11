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
}

enum TTALocaleName: String {
    case english
    case arabic
    
    enum TTALocaleCode: String {
        case en, ar
        
        func returnLocaleCode() -> String {
            switch self {
            case .en, .ar:
                return self.rawValue
            }
        }
    }
    
    func returnLocale() -> String {
        switch self {
        case .english:
            return TTALocaleCode.returnLocaleCode(.en)()
        case .arabic:
            return TTALocaleCode.returnLocaleCode(.ar)()
        }
    }
}


extension UserDefaults {
    
    var appLocale: TTALocaleName {
        get {
            register(defaults: [#function: TTALocaleName.returnLocale(.english)()])
            return TTALocaleName(rawValue: string(forKey: #function)!) ?? .english
        } set {
            set(newValue.rawValue, forKey: #function)
        }
    }
    
}
