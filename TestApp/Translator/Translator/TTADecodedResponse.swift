//
//  DecodedResponse.swift
//  Translator
//
//  Created by admin on 7/7/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class TTADecodedResponse: Decodable {
// Yandex JSON
    var text: [String]?
    
// Fun Translator JSON
    var contents: String?
    var translated: String?
    
    enum YandexResponseKeys: String, CodingKey {
        case text
    }
    
    enum FunTranslatorResponseKeys: String, CodingKey {
        case contents
    }
    
    enum FunTranslatorContentsKeys: String, CodingKey {
        case translated
    }
    
    required init(from decoder: Decoder) throws {
        if let yandexContainer = try? decoder.container(keyedBy: YandexResponseKeys.self) {
            self.text = try? yandexContainer.decode([String].self, forKey: .text)
        }
        
        if let funTranslatorResponseContainer = try? decoder.container(keyedBy: FunTranslatorResponseKeys.self) {
            if let funContentsContainer = try? funTranslatorResponseContainer.nestedContainer(keyedBy: FunTranslatorContentsKeys.self, forKey: .contents) {
                self.translated = try funContentsContainer.decode(String.self, forKey: .translated)
            }
        }
    }
}
