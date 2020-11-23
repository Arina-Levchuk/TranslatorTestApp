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


public class TTATranslatorResult: NSManagedObject {

    enum ResponseStatus: String {
        case success, failure
        
        var description: String {
            return self.rawValue
        }
        
    }

    var setResponseStatus: ((_ status: ResponseStatus?) -> Void)?
    
    func setTimeStamp() -> Double {
        let currentDate = Date()
        self.timeStamp = currentDate.timeIntervalSince1970
//        print("\(Date(timeIntervalSince1970: timeStamp))")
        return timeStamp
    }
        
    convenience init(textToTranslate: String, insertInto context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entity(forEntityName: "TTATranslatorResult", in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.textToTranslate = textToTranslate
        
        self.timeStamp = setTimeStamp()
        
        setResponseStatus = { [weak self] status in
            if let status = status {
                self?.responseStatus = status.description
            } else {
                return
            }
        }
    }
    
}

extension TTATranslatorResult: TTAUserLocationVCDelegate {
    func passUserCoordinates(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

}
