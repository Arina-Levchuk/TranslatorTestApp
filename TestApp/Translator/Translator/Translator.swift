//
//  TranslationService.swift
//  Translator
//
//  Created by admin on 3/14/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

struct Translator {
    let name: String
//    let logo: UIImage?
    var url: URL? = nil
}

struct TranslationResult: Decodable {
    let response: String?
    let responseData: String?
    let error: String?
    
}
