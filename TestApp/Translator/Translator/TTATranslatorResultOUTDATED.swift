//
//  TTATranslatorResult.swift
//  Translator
//
//  Created by admin on 7/7/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

//class TTATranslatorResult {
//    let textToTranslate: String
//    var translation: String?
////    var responseStatus: ResponseResult?
//
//    var setResponseResult: ((_ result: ResponseResult) -> Void)?
//
//    enum ResponseResult {
//        case success, failure
//    }
//
//
//    init(textToTranslate: String, translation: String? = nil, responseStatus: ResponseResult? = nil) {
//        self.textToTranslate = textToTranslate
//        self.translation = translation
//        self.responseStatus = responseStatus
        
//        setResponseResult = { response in
//            self.responseStatus = response
//        }
        
//    
//    deinit {
//        print("Result for \(textToTranslate) was deallocated")
//    }
//    




//import Foundation
//import CoreData
//
//@objc(TTAResultTable)
//public class TTATranslationResult: NSManagedObject {
//
//    enum ResponseStatus: String {
//        case success, failure
//    }
//    var setResponseStatus: ((_ status: ResponseStatus?) -> Void)?
//    
//    
//    convenience init(requestToTranslate: String, translatedText: String? = nil, responseStatus: ResponseStatus? = nil, insertIntoManagedObjectContext context: NSManagedObjectContext) {
//        let entity = NSEntityDescription.entity(forEntityName: "TTATranslationResult", in: context)!
//        self.init(entity: entity, insertInto: context)
//        self.requestToTranslate = requestToTranslate
//        self.translatedText = translatedText
//        self.responseStatus = responseStatus?.rawValue
//        
//        setResponseStatus = { status in
//            if let status = status {
//                self.responseStatus = status.rawValue
//            } else {
//                return
//            }
//        }
//
//    }
//    
//}





//
//  TTATranslatorResult+CoreDataClass.swift
//  Translator
//
//  Created by admin on 9/20/20.
//  Copyright © 2020 admin. All rights reserved.
//
//

//import Foundation
//import CoreData
//
//@objc(TTATranslatorResult)
//public class TTATranslatorResult: NSManagedObject {
//    
//    enum ResponseStatus: String {
//        case success, failure
//    }
//    
//    var setResponseStatus: ((_ status: ResponseStatus?) -> Void)?
//
//
//    convenience init(textToTranslate: String, translation: String? = nil, responseStatus: ResponseStatus? = nil, insertIntoManagedObjectContext context: NSManagedObjectContext) {
//        let entity = NSEntityDescription.entity(forEntityName: "TTATranslationResult", in: context)!
//        self.init(entity: entity, insertInto: context)
//        self.textToTranslate = requestToTranslate
//        self.translation = translatedText
//        self.responseStatus = responseStatus?.rawValue
//
//        setResponseStatus = { status in
//            if let status = status {
//                self.responseStatus = status.rawValue
//            } else {
//                return
//            }
//        }
//    }
//}

//import Foundation
//import CoreData
//
//
//extension TTATranslatorResult {
//
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<TTATranslatorResult> {
//        return NSFetchRequest<TTATranslatorResult>(entityName: "TTATranslatorResult")
//    }
//
//    @NSManaged public var textToTranslate: String
//    @NSManaged public var translation: String?
//    @NSManaged public var responseStatus: String?
//
//}
