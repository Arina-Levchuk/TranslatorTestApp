//
//  Result.swift
//  Translator
//
//  Created by admin on 7/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct Result {
    let textToTranslate: String
    var yandexTranslatorResult: [String]? = nil
    var funTranslatorResult: String? = nil
    
    init(textToTranslate: String) {
        self.textToTranslate = textToTranslate
    }
}
