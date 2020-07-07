//
//  DecodedResult.swift
//  Translator
//
//  Created by admin on 7/7/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class DecodedResponse: Decodable {
    let text: [String]?
    
    let contents: String
    let translated: String
    
    enum YandexCodingKey: CodingKeys {
        case text
    }
    
    enum FunTranslatorMainKey: CodingKeys {
        case contents
    }
    
    enum FunTranslatorContentsKey: CodingKeys {
        case translated
    }
    
    init(decoder: Decoder) {
        
    }
    
    
    
    
}
