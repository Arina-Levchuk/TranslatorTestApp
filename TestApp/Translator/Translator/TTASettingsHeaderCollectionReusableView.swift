//
//  TTASettingsHeaderCollectionReusableView.swift
//  Translator
//
//  Created by admin on 1/17/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

final class TTASettingsHeaderCollectionReusableView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = .systemGreen
        setupHeaderView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .natural
        lbl.textColor = .label
//        lbl.numberOfLines = 0
//        lbl.clipsToBounds = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setupHeaderView() {
        addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        layer.borderColor = UIColor.systemGray.cgColor
        layer.borderWidth = 1
        
    }
        
}
