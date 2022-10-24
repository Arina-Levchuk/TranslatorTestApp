//
//  TTAResultsTableVCLocalizationKeys.swift
//  Translator
//
//  Created by admin on 9.02.21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

enum TTAResultTableVCKeys: String, StringsLocalizedProtocol {
    
    typealias T = Self
    
    case title = "resultVCtitle"
    case inputFielLabel = "resultVCinputFieldLabel"
    case cellErrorMessage = "resultCellErrorMessage"
    
    static func localizedString(type: TTAResultTableVCKeys) -> String {
        return TTALocalizationManager.shared.localizeStringForKey(key: type.rawValue, comment: "")
    }
}
