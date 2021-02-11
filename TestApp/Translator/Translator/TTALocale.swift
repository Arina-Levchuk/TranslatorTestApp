//
//  TTALocale.swift
//  Translator
//
//  Created by admin on 11.02.21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

struct TTALocale {
    let name: String
    let code: TTAAppLocale
}

enum TTAAppLocale: String {
    case english
    case arabic
    
    enum TTALocaleCode: String {
        case en, ar
        
        func returnLangCode() -> String {
            switch self {
            case .en, .ar:
                return self.rawValue
            }
        }
    }
    
    func returnLocaleCode() -> String {
        switch self {
        case .english:
            return TTALocaleCode.returnLangCode(.en)()
        case .arabic:
            return TTALocaleCode.returnLangCode(.ar)()
        }
    }
}


extension UserDefaults {
    
    var appLocale: TTAAppLocale {
        get {
            register(defaults: [#function: TTAAppLocale.returnLocaleCode(.english)()])
            return TTAAppLocale(rawValue: string(forKey: #function)!) ?? .english
        } set {
            set(newValue.rawValue, forKey: #function)
        }
    }
    
}
