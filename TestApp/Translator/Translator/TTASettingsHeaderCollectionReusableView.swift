//
//  TTASettingsHeaderCollectionReusableView.swift
//  Translator
//
//  Created by admin on 1/17/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

final class TTASettingsHeaderCollectionReusableView: UICollectionReusableView {
    
    static let reuseID = "TTACVHeader"
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .systemGray5
        
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.borderWidth = 0.5
        
        setupHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = UIColor.systemGray5.cgColor
    }
    
    let headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .natural
        lbl.textColor = .label
//        lbl.numberOfLines = 0
//        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    
    func setupHeaderView() {
        addSubview(headerLabel)
//        headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, multiplier: 2).isActive = true
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0),
            headerLabel.lastBaselineAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: 0),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
                
    }
        
}
