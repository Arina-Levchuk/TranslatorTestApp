//
//  TTATranslatorResult+CoreDataProperties.swift
//  Translator
//
//  Created by admin on 9/20/20.
//  Copyright © 2020 admin. All rights reserved.
//
//

import Foundation
import CoreData

extension TTATranslatorResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TTATranslatorResult> {
        return NSFetchRequest<TTATranslatorResult>(entityName: "TTATranslatorResult")
    }

    @NSManaged public var responseStatus: String?
    @NSManaged public var textToTranslate: String
    @NSManaged public var translation: String?
    @NSManaged public var timeStamp: Double
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
}
