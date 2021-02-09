////
////  TTALocalization.swift
////  Translator
////
////  Created by admin on 9.02.21.
////  Copyright © 2021 admin. All rights reserved.
////
//
//import Foundation
//
//enum TTAAppSection {
//    case resultsTableVC, mapVC, settingsVC
//
//    
//    
//}
//
//enum TTAResultTableVCKeys {
//    case title, inputFielLabel, cellErrorMessage
//    
//    var resultTableVCKey: String {
//        switch self {
//        case .title:
//            return NSLocalizedString("resultVCtitle", comment: "")
//        case .inputFielLabel:
//            return NSLocalizedString("resultVCinputFieldLabel", comment: "")
//        case .cellErrorMessage:
//            return NSLocalizedString("resultCellErrorMessage", comment: "")
//        }
//        
//    }
//}
//
//enum TTAMapVCKeys: String {
//    case alertTitle, alertMessage, alertSettingsButtonTitle, alertCancelButtonTitle
//    
//    var mapVCKey: String {
//        switch self {
//        case .alertTitle:
//            return NSLocalizedString("locationAccessAlertTitle", comment: "")
//        case .alertMessage:
//            return NSLocalizedString("locationAccessAlertMessage", comment: "")
//        case .alertSettingsButtonTitle:
//            return NSLocalizedString("locationAccessAlertSettingsButtonTitle", comment: "")
//        case .alertCancelButtonTitle:
//            return NSLocalizedString("locationAccessAlertCancelButtonTitle", comment: "")
//        }
//    }
//}
//
//enum TTASettingsVCKeys {
//    
//    case title
//    case translators(header: TTATranslatorsKeys, name: TTATranslatorsKeys.TTATranslatorName)
//    case languages(TTALanguagesKeys)
//    case appearanceModes(TTAAppearanceModesKeys)
//    case localizationSettings(TTALocalizationSettingsKeys)
//    
//    enum TTATranslatorsKeys {
//        case sectionHeader, sectionFooter, translatorName(TTATranslatorName)
//        
//        enum TTATranslatorName {
//            case yoda, klingon, shakespeare, yandex, valyrian
//            
//            var translatorNameKey: String {
//                switch self {
//                case .yoda:
//                    return NSLocalizedString("yodaTranslatorName", comment: "")
//                case .klingon:
//                    return NSLocalizedString("klingonTranslatorName", comment: "")
//                case .shakespeare:
//                    return NSLocalizedString("shakespeareTranslatorName", comment: "")
//                case .yandex:
//                    return NSLocalizedString("yandexTranslatorName", comment: "")
//                case .valyrian:
//                    return NSLocalizedString("valyrianTranslatorName", comment: "")
//                }
//            }
//        }
//        
//        func returnTranslatorKey() -> String {
////        var translatorKey: String {
//            switch self {
//            case .sectionHeader:
//                return NSLocalizedString("translatorViewHeader", comment: "")
//            case .sectionFooter:
//                return NSLocalizedString("translatorViewFooter", comment: "")
//            case .translatorName:
//                return NSLocalizedString("", comment: "")
//            
//            }
//        }
//    }
//    
//    func returnsettingsKey() -> String {
////    var settingsVCKey: String {
//        switch self {
//        case .title:
//            return NSLocalizedString("settingsVCtitle", comment: "")
//        case .translators
//            return NSLocalizedString("", comment: "")
//        case .languages:
//            return NSLocalizedString("", comment: "")
//        case .appearanceModes:
//            return NSLocalizedString("", comment: "")
//        case .localizationSettings:
//            return NSLocalizedString("", comment: "")
//        }
//    }
//    
//    enum TTALanguagesKeys {
//        case sectionHeader, sectionFooter, languageName(name: TTALanguageName)
//        
//        enum TTALanguageName {
//            case rus, hebrew, polish, chinese, spanish, ukr
//            
//            func returnLangName() -> String {
////            var languageName: String {
//                switch self {
//                case .rus:
//                    return NSLocalizedString("rusLang", comment: "")
//                case .hebrew:
//                    return NSLocalizedString("hebLang", comment: "")
//                case .polish:
//                    return NSLocalizedString("polLang", comment: "")
//                case .chinese:
//                    return NSLocalizedString("chinLang", comment: "")
//                case .spanish:
//                    return NSLocalizedString("spanLang", comment: "")
//                case .ukr:
//                    return NSLocalizedString("ukrLang", comment: "")
//                }
//            }
//        }
//        
//        var langKey: String {
//            switch self {
//            case .sectionHeader:
//                return NSLocalizedString("flagViewHeader", comment: "")
//            case .sectionFooter:
//                return NSLocalizedString("flagViewFooter", comment: "")
//            case let .languageName(name):
//                return NSLocalizedString("\(name)", comment: "")
//            }
//        }
//        
//    }
//    
//    enum TTAAppearanceModesKeys {
//        case sectionHeader, sectionFooter
//        
//        var appModeKey: String {
//            switch self {
//            case .sectionHeader:
//                return NSLocalizedString("appModeViewHeader", comment: "")
//            case .sectionFooter:
//                return NSLocalizedString("appModeViewFooter", comment: "")
//            }
//        }
//    }
//    
//    enum TTALocalizationSettingsKeys {
//        case sectionHeader, sectionFooter, localeName
////      TODO: TBD
//    }
//}
//
//
