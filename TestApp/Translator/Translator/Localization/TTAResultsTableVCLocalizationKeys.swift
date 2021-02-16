//
//  TTAResultsTableVCLocalizationKeys.swift
//  Translator
//
//  Created by admin on 9.02.21.
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

enum TTAResultTableVCKeys: String, StringsLocalizedProtocol {
    
    typealias T = Self
    
    case title = "resultVCtitle"
    case inputFielLabel = "resultVCinputFieldLabel"
    case cellErrorMessage = "resultCellErrorMessage"
    
    static func localizedString(type: TTAResultTableVCKeys) -> String {
        return NSLocalizedString(type.rawValue, comment: "")
    }
    
}
