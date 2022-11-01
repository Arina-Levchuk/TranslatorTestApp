//
//  TTATranslationHandler.swift
//  Translator
//
//  Created by Arina Levchuk on 25.10.22.
//  Copyright © 2022 admin. All rights reserved.
//

import Foundation
import Combine

class TTATranslationHandler {
    
    weak var translatorDelegate: TTASettingsListDelegate? = nil
    var selectedTranslator: TTATranslator? = nil
    var selectedLanguage: TTATranslatorLanguage? = nil
    
    init() {
        self.selectedLanguage = TTASettingsListVC.allLanguages.first
        self.selectedTranslator = TTASettingsListVC.allTranslators.first
        self.translatorDelegate = self
    }
    
    
    func getTranslation(of data: TTATranslatorResult, from address: URL, completionHandler: @escaping (TTATranslatorResult?, Error?) -> Void) {
        var url = address
    
        if let queryArray = self.selectedTranslator?.queryDict {
            for (key, value) in queryArray {
                url = url.append(key, value: value)
                url = url.append("lang", value: "en-\(self.selectedLanguage!.langCode)")
            }
        }

        url = url.append("text", value: data.textToTranslate)
        print(url)
        
        let getRequest = URLRequest(url: url)
                
        let session = URLSession.shared
        let task = session.dataTask(with: getRequest) { (data, response, error) in
            if error != nil || data == nil {
                completionHandler(nil, error)
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completionHandler(nil, error)
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                completionHandler(nil, error)
                print("Wrong MIME type!")
                return
            }
            
            DispatchQueue.main.async {
                guard let responseData = data else {  return  }
                let decoder = JSONDecoder()
                do {
                    let decodedData = try! decoder.decode(TTADecodedResponse.self, from: responseData)
                    
                    if decodedData.text != nil {
                        data.translation = decodedData.text?.joined(separator: "")
                    } else {
                        data.translation = decodedData.translated
                    }
                    completionHandler(request, nil)
                } catch {
                    completionHandler(nil, error)
                    print("JSON parsing error")
                }
            }
        }
        task.resume()
    }
    
    func getResult() {
        guard let request
//        self.getTranslation(to: <#T##URL#>, with: <#T##TTATranslatorResult#>, completionHandler: <#T##(TTATranslatorResult?, Error?) -> Void#>)
    }
    
    private func translate() {
        
    }
}

extension TTATranslationHandler: TTASettingsListDelegate {
    
    func newLanguageSelected(language: TTATranslatorLanguage) {
        self.selectedLanguage = language
    }
    
    func newTranslatorIsSelected(translator: TTATranslator) {
        self.selectedTranslator = translator
    }
}
