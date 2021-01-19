//
//  TTASettingsListCell.swift
//  Translator
//
//  Created by admin on 11/26/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TTASettingsListCell: UICollectionViewCell {
      
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupListCellLayout()
        
        self.backgroundColor = .systemBackground
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.systemGray5.cgColor
        
        contentView.isUserInteractionEnabled = false
        
//        self.layer.cornerRadius = 10
//        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellTitle.text = nil
        cellIcon.image = nil
    }
    
    let cellTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
        
    let cellIcon : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    func setupListCellLayout() {
        
        contentView.addSubview(cellIcon)
        contentView.addSubview(cellTitle)

        cellIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cellIcon.widthAnchor.constraint(equalToConstant: 51).isActive = true
        cellIcon.heightAnchor.constraint(equalToConstant: 51).isActive = true
        
        cellTitle.leadingAnchor.constraint(equalTo: cellIcon.trailingAnchor, constant: 20).isActive = true
        cellTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
}

extension TTASettingsListCell: ReusableCVCell {}
