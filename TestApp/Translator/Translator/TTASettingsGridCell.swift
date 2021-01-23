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
        
        self.backgroundColor = .systemGray6
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray4.cgColor
        
        contentView.isUserInteractionEnabled = false
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellTitle.text = nil
        cellIcon.image = nil
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
        
        self.contentView.addSubview(cellIcon)
        self.contentView.addSubview(cellTitle)

        cellIcon.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        cellIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cellIcon.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        cellIcon.heightAnchor.constraint(equalToConstant: contentView.frame.height * (2/3)).isActive = true
//        cellTitle.topAnchor.constraint(equalTo: cellIcon.bottomAnchor).isActive = true
        
        
        cellTitle.topAnchor.constraint(equalTo: cellIcon.bottomAnchor).isActive = true
        cellTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cellTitle.heightAnchor.constraint(equalToConstant: contentView.frame.height * (1/3)).isActive = true
        
//        cellIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        cellIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        cellIcon.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        cellIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
}

//extension TTASettingsGridCell: ReusableCVCell {}
