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
    
    let cellTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.textColor = .label
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
//        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cellIcon : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    func setupListCellLayout() {
        
        self.contentView.addSubview(cellView)
        self.cellView.addSubview(cellIcon)
        self.cellView.addSubview(cellTitle)
        
        cellView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true

        cellIcon.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor).isActive = true
        cellIcon.centerYAnchor.constraint(equalTo: self.cellView.centerYAnchor).isActive = true
        cellIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        cellTitle.leadingAnchor.constraint(equalTo: self.cellView.leadingAnchor, constant: 50).isActive = true
        cellTitle.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
    }
    
}

extension TTASettingsListCell: ReusableCVCell {}
