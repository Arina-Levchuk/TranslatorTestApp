//
//  TTATranslationResult+CoreDataProperties.swift
//  Translator
//
//  Created by admin on 9/20/20.
//  Copyright © 2020 admin. All rights reserved.
//
//

import Foundation
import CoreData


extension TTATranslationResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TTATranslationResult> {
        return NSFetchRequest<TTATranslationResult>(entityName: "TTATranslatorResult")
    }

    @NSManaged public var textToTranslate: String?
    @NSManaged public var translation: String?
    @NSManaged public var responseStatus: String?

}
