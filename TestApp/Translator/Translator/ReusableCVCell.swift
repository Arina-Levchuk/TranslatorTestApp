//
//  ReusableCVCell.swift
//  Translator
//
//  Created by admin on 12/28/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol ReusableCVCell {
    
    static var reuseIdentifier: String { get }
    
}


extension ReusableCVCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
