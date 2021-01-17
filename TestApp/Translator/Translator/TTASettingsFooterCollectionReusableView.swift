//
//  TTASettingsFooterCollectionReusableView.swift
//  Translator
//
//  Created by admin on 1/17/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

final class TTASettingsFooterCollectionReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFooterViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let footerLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.textAlignment = .natural
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setupFooterViewLayout() {
        
        
    }
    
}
