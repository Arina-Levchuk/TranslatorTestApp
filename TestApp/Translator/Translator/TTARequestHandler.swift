//
//  TTARequestHandler.swift
//  Translator
//
//  Created by Arina Levchuk on 26.10.22.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation

class TTARequestHandler {
    
    func createTranslatorRequestFor(url: URL, data: TTATranslatorResult) {
        var url = url
    
        if let queryArray = self.selectedTranslator?.queryDict {
            for (key, value) in queryArray {
                url = url.append(key, value: value)
                url = url.append("lang", value: "en-\(self.selectedLanguage!.langCode)")
            }
        }

        url = url.append("text", value: data.textToTranslate)
        print(url)
        
        let getRequest = URLRequest(url: url)
    }
}
