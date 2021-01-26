//
//  TTASettingsFooterCollectionReusableView.swift
//  Translator
//
//  Created by admin on 1/17/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

final class TTASettingsFooterCollectionReusableView: UICollectionReusableView {
    
    static let reuseID = "TTACVFooter"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemGray5
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.borderWidth = 0.5
        
        setupFooterView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let footerLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .natural
        lbl.textColor = .label
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setupFooterView() {
        addSubview(footerLabel)
        
        NSLayoutConstraint.activate([
            footerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            footerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            footerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            footerLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0),
            footerLabel.lastBaselineAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: 0)
        ])
 
    }
    
}
