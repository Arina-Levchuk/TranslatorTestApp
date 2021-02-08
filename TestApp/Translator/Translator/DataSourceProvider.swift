//
//  DataSourceProvider.swift
//  Translator
//
//  Created by admin on 4/22/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

protocol DataSourceProviderDelegate {
    func updateTable(insertItem: [IndexPath])
}

protocol DataSourceProvider {
    associatedtype T
    var items: [[T]] { get set }
    var delegate: DataSourceProviderDelegate? { get set }
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> T?
    
    func updateCell(at indexPath: IndexPath, with value: T)

//    func update(completion:@escaping (() -> Void))
        
}

extension DataSourceProvider {
    func numberOfSections() -> Int {
        return items.count
    }

    func numberOfItems(in section: Int) -> Int {
        guard section >= 0 && section < items.count else {
            return 0
        }
        return items[section].count
    }
    
    func item(at indexPath: IndexPath) -> T? {
        guard indexPath.section >= 0 && indexPath.section < items.count && indexPath.row >= 0 && indexPath.row < items[indexPath.section].count else {
                return nil
        }
        return items[indexPath.section][indexPath.row]
    }
    
    mutating func updateCell(at indexPath: IndexPath, with value: T) {
        guard indexPath.section >= 0 && indexPath.section < items.count && indexPath.row >= 0 && indexPath.row < items[indexPath.section].count else {
                return
        }
        items[indexPath.section][indexPath.row] = value
    }
    
    
}



//    func sendToTranslate(from address: URL, with text: String, completionHandler: @escaping (TTATranslationResult?, Error?) -> Void) {
//
//        let result = TTATranslationResult(textToTranslate: text)
//
//        var url = address
//
//        if let queryArray = selectedTranslator?.queryDict {
//            for (key, value) in queryArray {
//                url = url.append(key, value: value)
//            }
//        }
//
//        url = url.append("text", value: text)
//        print(url)
//
//        let request = URLRequest(url: url)
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request) { (data, response, error) in
//            if error != nil || data == nil {
//                completionHandler(nil, error)
//                print("Client error!")
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                completionHandler(nil, error)
//                print("Server error!")
//                return
//            }
//
//            guard let mime = response.mimeType, mime == "application/json" else {
//                completionHandler(nil, error)
//                print("Wrong MIME type!")
//                return
//            }
//
//            DispatchQueue.main.async {
//                guard let responseData = data else {  return  }
//                let decoder = JSONDecoder()
//                do {
//                    let decodedData = try! decoder.decode(TTADecodedResponse.self, from: responseData)
//
//                    if decodedData.text != nil {
//                        result.translation = decodedData.text?.joined(separator: "")
//                    } else {
//                        result.translation = decodedData.translated
//                    }
////                    print(result)
//                    completionHandler(result, nil)
//
//                } catch {
//                    completionHandler(nil, error)
//                    print("JSON parsing error")
//                }
//            }
//        }
//        task.resume()
//    }
