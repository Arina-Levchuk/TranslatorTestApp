//
//  TTAResultsTableLocalizationKeys.swift
//  Translator
//
//  Created by admin on 9.02.21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

//enum TTAAppSection {
//    case resultsTableVC, mapVC, settingsVC
//}

enum TTAResultTableVCKeys {
    case title, inputFielLabel, cellErrorMessage
    
    func returnResultTableVCKey() -> String {
//    var resultTableVCKey: String {
        switch self {
        case .title:
            return NSLocalizedString("resultVCtitle", comment: "")
        case .inputFielLabel:
            return NSLocalizedString("resultVCinputFieldLabel", comment: "")
        case .cellErrorMessage:
            return NSLocalizedString("resultCellErrorMessage", comment: "")
        }
        
    }
}
