//
//  Result.swift
//  Translator
//
//  Created by admin on 6/30/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class DecodedResponse: Decodable {
//  Yandex JSON model
    var text: [String]?
    
    enum YandexResponseKeys: String, CodingKey {
        case text
    }

//    Fun Translator JSON model
    var contents: String?
    var translated: String?
    
    enum FunTranslationResponseKeys: String, CodingKey {
        case contents
    }
    
    enum FunTranslationContentsKeys: String, CodingKey {
        case translated
    }
    
    
    required init(from decoder: Decoder) throws {
        if let yandexContainer = try? decoder.container(keyedBy: YandexResponseKeys.self) {
            self.text = try? yandexContainer.decodeIfPresent([String].self, forKey: .text)
        } 
        
        if let funResponseContainer = try? decoder.container(keyedBy: FunTranslationResponseKeys.self) {
            if let funContentsContainer = try? funResponseContainer.nestedContainer(keyedBy: FunTranslationContentsKeys.self, forKey: .contents) {
                self.translated = try funContentsContainer.decode(String.self, forKey: .translated)
            }
        }
    }
}
