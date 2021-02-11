//
//  TTASettingsVCLocalizationKeys.swift
//  Translator
//
//  Created by admin on 9.02.21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation


enum TTASettingsVCKeys {
    
    case title
//    case translators(translatorName: TTATranslatorsKeys)
//    case languages(lang: TTALanguagesKeys)
//    case appearanceModes(theme: TTAAppearanceModesKeys)
//    case localizationSettings(locale: TTALocalizationSettingsKeys)
    
    enum TTATranslatorsKeys {
        case sectionHeader
        case sectionFooter
        case translatorName(name: TTATranslatorName)
        
        enum TTATranslatorName {
            case yoda, klingon, shakespeare, yandex, valyrian
        
            func returnTranslatorNameKey() -> String {
                switch self {
                case .yoda:
                    return NSLocalizedString("yodaTranslatorName", comment: "")
                case .klingon:
                    return NSLocalizedString("klingonTranslatorName", comment: "")
                case .shakespeare:
                    return NSLocalizedString("shakespeareTranslatorName", comment: "")
                case .yandex:
                    return NSLocalizedString("yandexTranslatorName", comment: "")
                case .valyrian:
                    return NSLocalizedString("valyrianTranslatorName", comment: "")
                }
            }
        }
        
        func returnTranslatorKey() -> String {
            switch self {
            case .sectionHeader:
                return NSLocalizedString("translatorViewHeader", comment: "")
            case .sectionFooter:
                return NSLocalizedString("translatorViewFooter", comment: "")
            case let .translatorName(name):
                return NSLocalizedString("\(name.returnTranslatorNameKey())", comment: "")
            }
        }
    }
    
    func returnSettingsKey() -> String {
        switch self {
        case .title:
            return NSLocalizedString("settingsVCtitle", comment: "")
//        case let .translators(translatorName):
//            return NSLocalizedString("\(translatorName.returnTranslatorKey())", comment: "")
//        case .languages:
//            return NSLocalizedString("", comment: "")
//        case .appearanceModes:
//            return NSLocalizedString("", comment: "")
//        case .localizationSettings:
//            return NSLocalizedString("", comment: "")
        }
    }
    
    enum TTALanguagesKeys {
        case sectionHeader
        case sectionFooter
//        case languageName(name: TTALanguageName)
        
        enum TTALanguageName {
            case rus, hebrew, polish, chinese, spanish, ukr
            
            func returnLangName() -> String {
                switch self {
                case .rus:
                    return NSLocalizedString("rusLang", comment: "")
                case .hebrew:
                    return NSLocalizedString("hebLang", comment: "")
                case .polish:
                    return NSLocalizedString("polLang", comment: "")
                case .chinese:
                    return NSLocalizedString("chinLang", comment: "")
                case .spanish:
                    return NSLocalizedString("spanLang", comment: "")
                case .ukr:
                    return NSLocalizedString("ukrLang", comment: "")
                }
            }
        }
        
        func returnLangKey() -> String {
            switch self {
            case .sectionHeader:
                return NSLocalizedString("flagViewHeader", comment: "")
            case .sectionFooter:
                return NSLocalizedString("flagViewFooter", comment: "")
//            case let .languageName(name):
//                return NSLocalizedString("\(name.returnLangName())", comment: "")
            }
        }
    }
    
    enum TTAAppearanceModesKeys {
        case sectionHeader, sectionFooter
    
        func returnAppModeKey() -> String {
            switch self {
            case .sectionHeader:
                return NSLocalizedString("appModeViewHeader", comment: "")
            case .sectionFooter:
                return NSLocalizedString("appModeViewFooter", comment: "")
            }
        }
    }
    
    enum TTALocalizationSettingsKeys {
        case sectionHeader
        case sectionFooter
//        case localeName(name: TTALocaleName)
        
        func returnLocaleSettingKey() -> String {
            switch self {
            case .sectionHeader:
                return NSLocalizedString("localizationViewHeader", comment: "")
            case .sectionFooter:
                return NSLocalizedString("localizationViewFooter", comment: "")
//            case let .localeName(name):
//                return NSLocalizedString("\(name.returnLocaleName())", comment: "")
            }
        }
        
        enum TTALocaleName {
            case arabic, english
            
            func returnLocaleName() -> String {
                switch self {
                case .arabic:
                    return NSLocalizedString("arabicLocaleName", comment: "")
                case .english:
                    return NSLocalizedString("engLocaleName", comment: "")
                }
            }
        }
        
    }
}
