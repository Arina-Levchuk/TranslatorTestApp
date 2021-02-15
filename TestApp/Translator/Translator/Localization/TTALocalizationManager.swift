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

enum MemberRegistrationFormFormStrings: String, StringsLocalizedProtocol {
    
    typealias T = Self
    
    case contacts = "Contacts"
    case title = ""

    
    static func localizedString(type: MemberRegistrationFormFormStrings) -> String {
        return NSLocalizedString(type.rawValue, comment: "")
    }
}

class TTALocalizationManager: NSObject {
   
    static let localizationManager = TTALocalizationManager()
    
    var bundle: Bundle!
    
    private override init() {
        super.init()
//        MemberRegistrationFormFormStrings.localizedString(type: .)
        bundle = Bundle.main
    }
    
    func localizeStringForKey(key: String, comment: String) -> String {
        return bundle.localizedString(forKey: key, value: comment, table: nil)
    }
    
    func setLocale(languageCode: String) {
        var appLanguage = UserDefaults.standard.object(forKey: #function) as! [String]
        appLanguage.remove(at: 0)
        appLanguage.insert(languageCode, at: 0)
        UserDefaults.standard.set(languageCode, forKey: #function)
        UserDefaults.standard.synchronize()
        
        if let langDirectoryPath = Bundle.main.path(forResource: languageCode, ofType: "lproj") {
            bundle = Bundle.init(path: langDirectoryPath)
        } else {
            resetLocalization()
        }
    }
    
    func resetLocalization() {
        bundle = Bundle.main
    }
    
    
    
}
