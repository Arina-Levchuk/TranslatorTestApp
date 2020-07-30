//
//  TTATranslationResult.swift
//  Translator
//
//  Created by admin on 7/7/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class TTATranslationResult {
    let textToTranslate: String
    var translation: String?
//    var resultFromYandex: String?
//    var resultFromFunTranslator: String?
//    var error: String?
    var responseStatus: ResponseResult?
    
    
//    var arrayOfResults: [TTATranslationResult] = []
    
    var addResponseStatus: ((_ result: ResponseResult) -> Void)?
    
    enum ResponseResult {
        case success, failure
    }
    
    init(textToTranslate: String) {
        self.textToTranslate = textToTranslate
        
        addResponseStatus = { response in
            self.responseStatus = response
        }
        
    }
//    
//    deinit {
//        print("Result for \(textToTranslate) was deallocated")
//    }
//    
}
