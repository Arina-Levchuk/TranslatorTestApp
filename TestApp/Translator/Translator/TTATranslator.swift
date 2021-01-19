//
//  TTATranslator.swift
//  Translator
//
//  Created by admin on 3/14/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

struct TTATranslator {
    let name: String
    var url: URL? = nil
    var translatorIcon: UIImage? = nil
    var queryDict: [String: String]?

}

struct TTATranslatorLanguage {
    let language: String
    var flagImg: UIImage? = nil
    let langCode: String
}

struct TTAAppearanceMode {
    let mode: String
    var modeImg: UIImage? = nil
}
