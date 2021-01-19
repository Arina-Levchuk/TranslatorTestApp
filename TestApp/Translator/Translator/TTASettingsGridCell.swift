//
//  TTASettingsGridCell.swift
//  Translator
//
//  Created by admin on 12/29/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TTASettingsGridCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupGridCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let cellTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setupGridCellLayout() {
        
//        self.contentView.addSubview(cellTitle)
        self.contentView.addSubview(cellIcon)
        
        cellIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cellIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
//        cellIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        cellIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        cellIcon.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        cellIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
}

extension TTASettingsGridCell: ReusableCVCell {}
