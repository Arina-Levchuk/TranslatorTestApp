//
//  TTAResultTable+CoreDataClass.swift
//  Translator
//
//  Created by admin on 9/16/20.
//  Copyright © 2020 admin. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TTAResultTable)
public class TTATranslationResult: NSManagedObject {

    enum ResponseStatus: String {
        case success, failure
    }
    var setResponseStatus: ((_ status: ResponseStatus?) -> Void)?
    
    
    convenience init(requestToTranslate: String, translatedText: String? = nil, responseStatus: ResponseStatus? = nil, insertIntoManagedObjectContext context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "TTATranslationResult", in: context)!
        self.init(entity: entity, insertInto: context)
        self.requestToTranslate = requestToTranslate
        self.translatedText = translatedText
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



