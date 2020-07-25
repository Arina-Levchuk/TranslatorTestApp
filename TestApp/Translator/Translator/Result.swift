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
    var resultFromYandex: String?
    var resultFromFunTranslator: String?
    var error: String?

    
//    init(textToTranslate: String, resultFromYandex: [String]?, resultFromFunTranslator: String?) {
    init(textToTranslate: String) {
        self.textToTranslate = textToTranslate
//        self.resultFromYandex = resultFromYandex
//        self.resultFromFunTranslator = resultFromFunTranslator
    }
    
}
