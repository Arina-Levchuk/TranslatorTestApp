//
//  DRAFT.swift
//  Translator
//
//  Created by admin on 6/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


//    func sendToTranslate(to adress: URL, text: String) {
////        let translatorURL = translatorVC.selectedURL!
//        guard let url = URL(string: "\(adress)") else {  return  }
//
////        let text = inputField.text
//        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        print(encodedText as Any)
//        let data: Data = "text=\(encodedText)".data(using: .utf8)!
//        print(data)
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        let header = [
//            "key": "trnsl.1.1.20200504T182931Z.03785aecf85306af.7922af70293ac75cde1e43526b6b4c4cd682cf8e",
//            "lang": "en-ru",
//            "Content-Type": "application/x-www-form-urlencoded"
//        ]
//        request.allHTTPHeaderFields = header
//
////        request.setValue("trnsl.1.1.20200504T182931Z.03785aecf85306af.7922af70293ac75cde1e43526b6b4c4cd682cf8e", forHTTPHeaderField: "key")
////        request.addValue("en-ru", forHTTPHeaderField: "lang")
////        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//        request.httpBody = data
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print(error)
//            } else if let response = response {
//                print(response)
//            } else if let data = data {
//
//                print(data)
//            }
//
//            DispatchQueue.main.async {
//                guard let responseData = data else {
//                    print("Error: did not receive data")
//                    return
//                }
//                let decoder = JSONDecoder()
//                do {
//                    let decodedResponse = try? decoder.decode(TranslationResult.self, from: responseData)
//                    print(decodedResponse)
//                } catch {
//                    print(error)
//                }
//// OR with JSONSerialization
////                do {
////                    let json = try? JSONSerialization.jsonObject(with: responseData, options: [])
////                    print(json as Any)
////                } catch {
////                    print(error)
////                }
//            }
//
//
//        }
//        task.resume()
//
//    }
//
//    func sendToTranslateFunTranslator(to adress: URL, text: String) {
//        guard let url = URL(string: "\(adress)") else { return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
////        let requestBody = ["text": "\(textToTranslate)"]
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
////        let requestData = "text=Mister Obivan has lost the planet".data(using: .utf8)!
//        var requestData = [
//            "text": "Mister Obivan has lost the planet"
//        ]
//        let encodedData: Data = requestData.add
//        request.httpBody = requestData
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//
//            guard let response = response else {
//                print("A server error occured.")
//                return
//            }
//
//            guard let data = data else {
//                print("No data returned.")
//                return
//            }
//            do {
//                let json = try? JSONSerialization.jsonObject(with: data, options: [])
//                print(json as Any)
//            } catch {
//                print(error)
//            }
//        }
//        task.resume()
//
//
//    }
    
//    func sendToTranslate(to adress: URL, with text: String) {
//    func sendToTranslate() {
//        let translatorURL = translatorVC.selectedURL!
//        guard let url = URL(string: "\(translatorURL)") else {  return  }
//
//        let text = inputField.text!
//    //        let parameters = ["text": "\(text)"]
//
//        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//    //  Params for Yandex translator?
//        let parameters = [
//            "?key=": "trnsl.1.1.20200504T182931Z.03785aecf85306af.7922af70293ac75cde1e43526b6b4c4cd682cf8e",
//            "&text=": "\(encodedText!)",
//            "&lang=": "en-ru",
//            "&format=": "plain",
//            "&options=": "1",
////            "callback": "task"
//        ]
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
////        Здесь JSON, а мне для яндекса нужно
////        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {  return  }
////        request.httpBody = httpBody
//
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//
//            guard let data = data else {    return  }
//            do {
//                let json = try? JSONSerialization.jsonObject(with: data, options: [])
//                print(json!)
//            } catch {
//                print(error)
//            }
//            let responseForCell = TranslationResult(response: response, responseData: data, error: error)
//            self.arrayOfResponses.append(responseForCell)
//        }
//        task.resume()
//
//    }



// РАБОТАЕТ, НО С ХАРДКОДОМ, НО РАБОТАЕТ

//    func postRequest() {

//        let url = URL(string: "https://api.funtranslations.com/translate/yoda.json")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let requestData = ["text": "Master Obiwan has lost a planet."]
//        let jsonData = try? JSONSerialization.data(withJSONObject: requestData, options: [])
//        request.httpBody = jsonData
//        let session = URLSession.shared
//        let task = session.dataTask(with: request) { (data, response, error) in
//            if error != nil || data == nil {
//                print("Client error!")
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                print("Server error")
//                return
//            }
//
//            guard let mime = response.mimeType, mime == "application/json" else {
//                print("Wrong MIME type!")
//                return
//            }
//
//            do {
//                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
//                print(json as Any)
//            } catch {
//                print("JSON error: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//
//    }
