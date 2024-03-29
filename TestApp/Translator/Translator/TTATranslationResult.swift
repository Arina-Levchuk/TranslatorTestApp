//
//  TTATranslationResult.swift
//  Translator
//
//  Created by admin on 7/7/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class TTATranslatorResult {
    let textToTranslate: String
    var translation: String?
//    var resultFromYandex: String?
//    var resultFromFunTranslator: String?
//    var error: String?
    var responseStatus: ResponseResult?
    
    
//    var arrayOfResults: [TTATranslationResult] = []
    
    var setResponseStatus: ((_ result: ResponseResult) -> Void)?
    
    enum ResponseResult {
        case success, failure
    }
    
    
    init(textToTranslate: String, translation: String? = nil, responseStatus: ResponseResult? = nil) {
        self.textToTranslate = textToTranslate
        self.translation = translation
        self.responseStatus = responseStatus
        
        setResponseStatus = { response in
            self.responseStatus = response
        }
        
    }
//    
//    deinit {
//        print("Result for \(textToTranslate) was deallocated")
//    }
//    
}
