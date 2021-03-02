//
//  TTALocalizationManager.swift
//  Translator
//
//  Created by admin on 10.02.21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
import UIKit

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
        
        let path: String? = Bundle.main.path(forResource: language, ofType: "lproj")
        
        if let path = path {
            self.bundle = Bundle(path: path)
        } else {
            resetLocalization()
        }
        
        changeAppearance()
                
    }
    
    func changeAppearance() {

        UIView.appearance().semanticContentAttribute = TTALocalizationManager.shared.getSelectedLocale().isRTL ? .forceRightToLeft : .forceLeftToRight

        UINavigationBar.appearance().semanticContentAttribute = TTALocalizationManager.shared.getSelectedLocale().isRTL ? .forceRightToLeft : .forceLeftToRight

    }
    
    func resetLocalization() {
        bundle = Bundle.main
    }
    
    func getSelectedLocale() -> TTAAppLocale {
        
        var language: TTAAppLocale? = nil
        let selectedLocale = UserDefaults.standard.appLocale.description
        
        for lang in TTASettingsListVC.allAppLocales {
            if lang.code.description == selectedLocale {
                language = lang
            }
        }
        
        return language!
    }

}

extension UILabel {
    func determineTextDirection() {
        guard self.text != nil else { return }
        
//        let tagger = NSLinguisticTagger(tagSchemes: [.language], options: 0)
//        tagger.string = self.text
//        
//        let lang = tagger.dominantLanguage
        
//        let rtl = lang == TTALocaleName.arabic.description
        
        let rtl = TTALocalizationManager.shared.getSelectedLocale().isRTL
        self.textAlignment = rtl ? .right : .left
    }
}

extension UITextView {
    func determineTextDirection() {

//        let appLang = UserDefaults.standard.appLocale.description
        
//        let rtl = appLang == TTALocaleName.arabic.description
        
        let rtl = TTALocalizationManager.shared.getSelectedLocale().isRTL
        
        self.textAlignment = rtl ? .right : .left
        
    }
    
}


//extension UIApplication {
//    
//    var TTAuserInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
//        
//        get {
//            let direction = TTALocalizationManager.shared.getSelectedLocale().isRTL ? (UIUserInterfaceLayoutDirection.rightToLeft) : (UIUserInterfaceLayoutDirection.leftToRight)
//        
//            return direction
//        }
//    }
//}

