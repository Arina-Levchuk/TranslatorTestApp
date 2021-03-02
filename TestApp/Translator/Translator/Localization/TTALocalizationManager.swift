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
        
        let RTLview: () = UIView.appearance().semanticContentAttribute = .forceRightToLeft
        let LTRview: () = UIView.appearance().semanticContentAttribute = .forceLeftToRight
    
        TTALocalizationManager.shared.getSelectedLocale().isRTL ? RTLview : LTRview
        
        TTALocalizationManager.shared.getSelectedLocale().isRTL ? (UILabel.appearance().semanticContentAttribute = .forceRightToLeft) :
        (UILabel.appearance().semanticContentAttribute = .forceLeftToRight)
        
        TTALocalizationManager.shared.getSelectedLocale().isRTL ? (UIScrollView.appearance().semanticContentAttribute = .forceRightToLeft) : (UIScrollView.appearance().semanticContentAttribute = .forceLeftToRight)
        
        TTALocalizationManager.shared.getSelectedLocale().isRTL ? (UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft) : (UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight)
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
