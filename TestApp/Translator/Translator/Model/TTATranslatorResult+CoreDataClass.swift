//
//  TTATranslatorResult+CoreDataClass.swift
//  Translator
//
//  Created by admin on 9/20/20.
//  Copyright © 2020 admin. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TTATranslatorResult)
public class TTATranslatorResult: NSManagedObject {
    
    enum ResponseStatus: String {
        case success, failure
    }
    
    var setResponseStatus: ((_ status: ResponseStatus?) -> Void)?


    convenience init(textToTranslate: String, translation: String? = nil, responseStatus: ResponseStatus? = nil, insertIntoManagedObjectContext context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "TTATranslationResult", in: context)!
        self.init(entity: entity, insertInto: context)
        self.textToTranslate = requestToTranslate
        self.translation = translatedText
        self.responseStatus = responseStatus?.rawValue

        setResponseStatus = { status in
            if let status = status {
                self.responseStatus = status.rawValue
            } else {
                return
            }
        }
    }
}
