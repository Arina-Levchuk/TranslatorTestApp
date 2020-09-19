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
    var responseIsOk: Bool?
//    public var setResponseStatus: ((_ status: ResponseStatus) -> Void)?
    public var setResponseStatus: ((_ status: Bool) -> Void)?
    
    
    convenience init(requestToTranslate: String, translatedText: String?, responseIsOk: Bool?, insertIntoManagedObjectContext context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "TTATranslationResult", in: context)!
        self.init(entity: entity, insertInto: context)
        self.requestToTranslate = requestToTranslate
        self.translatedText = translatedText
        self.responseIsOk = responseIsOk

        setResponseStatus = { response in
            self.responseIsOk = response
        }
    }
    
}



