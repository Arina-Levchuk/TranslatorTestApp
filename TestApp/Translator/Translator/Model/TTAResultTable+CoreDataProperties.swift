//
//  TTAResultTable+CoreDataProperties.swift
//  Translator
//
//  Created by admin on 9/16/20.
//  Copyright © 2020 admin. All rights reserved.
//
//

import Foundation
import CoreData


extension TTATranslationResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TTATranslationResult> {
        return NSFetchRequest<TTATranslationResult>(entityName: "TTATranslationResult")
    }

    @NSManaged public var requestToTranslate: String
    @NSManaged public var translatedText: String?
//    private var status: TTATranslatorResult.ResponseResult?
    
//    public enum ResponseStatus {
//        case success, failure
//    }

}
