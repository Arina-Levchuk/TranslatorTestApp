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
//    public var responseStatus: ResponseStatus?
//    var responseIsOk: Bool?
    var status: ResponseStatus?
//    public var setResponseStatus: ((_ status: ResponseStatus) -> Void)?
    enum ResponseStatus {
        case success, failure
    }
    var setResponseStatus: ((_ status: ResponseStatus?) -> Void)?
    
    
    convenience init(requestToTranslate: String, translatedText: String?, responseStatus: ResponseStatus?, insertIntoManagedObjectContext context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "TTATranslationResult", in: context)!
        self.init(entity: entity, insertInto: context)
        self.requestToTranslate = requestToTranslate
        self.translatedText = translatedText
        self.status = responseStatus
        
        setResponseStatus = { status in
            self.status = status
        }

    }
    
}



