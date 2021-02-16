//
//  TTALocalizationManager.swift
//  Translator
//
//  Created by admin on 10.02.21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

protocol StringsLocalizedProtocol where T.Type == Self.Type  {
    associatedtype T
    static func localizedString(type: T) -> String
}

class TTALocalizationManager: NSObject {
   
    static let shared = TTALocalizationManager()
    
    var bundle: Bundle? = nil
    
    private override init() {
        super.init()
        bundle = Bundle.main
    }
    
    func localizeStringForKey(key: String, comment: String) -> String {
        return bundle!.localizedString(forKey: key, value: comment, table: nil)
    }
    
    func setLocale(language: String) {
                
        UserDefaults.standard.setValue(language, forKey: UserDefaults.standard.appLocale.rawValue)
        
        let path: String? = Bundle.main.path(forResource: language, ofType: "lproj")
        
        if path == nil {
            resetLocalization()
        } else {
            self.bundle = Bundle(path: path!)
        }

    }
    
    func resetLocalization() {
        bundle = Bundle.main
    }
    
    func getSelectedLocale() -> String? {
        if let language = UserDefaults.standard.string(forKey: UserDefaults.standard.appLocale.rawValue) {
            return language
        }
        return nil
    }
    
    func localizeTTAapp(key: Any, comment: Any) -> String {
        return TTALocalizationManager.shared.localizeStringForKey(key: (key as! String), comment: (comment as! String))
    }
    
    
}

