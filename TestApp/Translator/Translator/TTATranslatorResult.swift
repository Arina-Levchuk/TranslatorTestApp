//
//  TTATranslatorResult.swift
//  Translator
//
//  Created by admin on 7/7/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class TTATranslatorResult {
    let textToTranslate: String
    var translation: String?
//    var responseStatus: ResponseResult?
    
    var setResponseResult: ((_ result: ResponseResult) -> Void)?
    
    enum ResponseResult {
        case success, failure
    }
    
    
    init(textToTranslate: String, translation: String? = nil, responseStatus: ResponseResult? = nil) {
        self.textToTranslate = textToTranslate
        self.translation = translation
//        self.responseStatus = responseStatus
        
//        setResponseResult = { response in
//            self.responseStatus = response
//        }
        
    }
//    
//    deinit {
//        print("Result for \(textToTranslate) was deallocated")
//    }
//    
}
