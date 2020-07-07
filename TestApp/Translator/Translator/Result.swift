//
//  Result.swift
//  Translator
//
//  Created by admin on 7/7/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct Result {
    let textToTranslate: String
    var resultFromYandex: [String]? = nil
    var resultFromFunTranslator: String? = nil
    
    init(textToTranslate: String) {
        self.textToTranslate = textToTranslate
    }
}
