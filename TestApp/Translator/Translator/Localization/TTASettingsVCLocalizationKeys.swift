//
//  TTASettingsVCLocalizationKeys.swift
//  Translator
//
//  Created by admin on 9.02.21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

enum TTASettingsVCKeys: String, StringsLocalizedProtocol {

//  MARK: - Main Settings View
    typealias T = Self
    
    case title = "settingsVCtitle"

    static func localizedString(type: TTASettingsVCKeys) -> String {
        return TTALocalizationManager.shared.localizeStringForKey(key: type.rawValue, comment: "")
//        return NSLocalizedString(type.rawValue, tableName: nil, bundle: TTALocalizationManager.shared.bundle!, value: "", comment: "")
    }
    
//  MARK: - Translators Section
    enum TTATranslatorsKeys: String, StringsLocalizedProtocol {
                
        typealias T = Self
        
        case sectionHeader = "translatorViewHeader"
        case sectionFooter = "translatorViewFooter"
        
        static func localizedString(type: TTASettingsVCKeys.TTATranslatorsKeys) -> String {
            return TTALocalizationManager.shared.localizeStringForKey(key: type.rawValue, comment: "")
//            return NSLocalizedString(type.rawValue, tableName: nil, bundle: TTALocalizationManager.shared.bundle!, value: "", comment: "")
        }
        
        enum TTATranslatorName: String, StringsLocalizedProtocol {

            typealias T = Self
            
            case yoda = "yodaTranslatorName"
            case klingon = "klingonTranslatorName"
            case shakespeare = "shakespeareTranslatorName"
            case yandex = "yandexTranslatorName"
            case valyrian = "valyrianTranslatorName"
            
            static func localizedString(type: TTASettingsVCKeys.TTATranslatorsKeys.TTATranslatorName) -> String {
                return TTALocalizationManager.shared.localizeStringForKey(key: type.rawValue, comment: "")
//                return NSLocalizedString(type.rawValue, tableName: nil, bundle: TTALocalizationManager.shared.bundle!, value: "", comment: "")
            }
        
        }
    
    }
    
//  MARK: - Languages (flags) Section
    
    enum TTALanguagesKeys: String, StringsLocalizedProtocol {
        
        typealias T = Self
        
        case sectionHeader = "flagViewHeader"
        case sectionFooter = "flagViewFooter"
        
        static func localizedString(type: TTASettingsVCKeys.TTALanguagesKeys) -> String {
            return TTALocalizationManager.shared.localizeStringForKey(key: type.rawValue, comment: "")
//            return NSLocalizedString(type.rawValue, tableName: nil, bundle: TTALocalizationManager.shared.bundle!, value: "", comment: "")
        }
        
        enum TTALanguageName: String, StringsLocalizedProtocol {
            
            typealias T = Self
            
            case rus = "rusLang"
            case hebrew = "hebLang"
            case polish = "polLang"
            case chinese = "chinLang"
            case spanish = "spanLang"
            case ukr = "ukrLang"
            
            static func localizedString(type: TTASettingsVCKeys.TTALanguagesKeys.TTALanguageName) -> String {
                return TTALocalizationManager.shared.localizeStringForKey(key: type.rawValue, comment: "")
//                return NSLocalizedString(type.rawValue, tableName: nil, bundle: TTALocalizationManager.shared.bundle!, value: "", comment: "")
            }
    
        }
        
    }
   
//  MARK: - Appearance Mode Settings Section
    
    enum TTAAppearanceModesKeys: String, StringsLocalizedProtocol {
        
        typealias T = Self
        
        case sectionHeader = "appModeViewHeader"
        case sectionFooter = "appModeViewFooter"
    
        static func localizedString(type: TTASettingsVCKeys.TTAAppearanceModesKeys) -> String {
            return TTALocalizationManager.shared.localizeStringForKey(key: type.rawValue, comment: "")
//            return NSLocalizedString(type.rawValue, tableName: nil, bundle: TTALocalizationManager.shared.bundle!, value: "", comment: "")
        }
    }
    
//  MARK: - Localization Settings Section
    
    enum TTALocalizationSettingsKeys: String, StringsLocalizedProtocol {

        typealias T = Self
        
        case sectionHeader = "localizationViewHeader"
        case sectionFooter = "localizationViewFooter"

        static func localizedString(type: TTASettingsVCKeys.TTALocalizationSettingsKeys) -> String {
            return TTALocalizationManager.shared.localizeStringForKey(key: type.rawValue, comment: "")
//            return NSLocalizedString(type.rawValue, tableName: nil, bundle: TTALocalizationManager.shared.bundle!, value: "", comment: "")
        }

        enum TTALocaleName: String, StringsLocalizedProtocol {

            typealias T = Self
            
            case arabic = "arabicLocaleName"
            case english = "engLocaleName"
            
            static func localizedString(type: TTASettingsVCKeys.TTALocalizationSettingsKeys.TTALocaleName) -> String {
                return TTALocalizationManager.shared.localizeStringForKey(key: type.rawValue, comment: "")
//                return NSLocalizedString(type.rawValue, tableName: nil, bundle: TTALocalizationManager.shared.bundle!, value: "", comment: "")
            }

        }
        
    }
    
}
