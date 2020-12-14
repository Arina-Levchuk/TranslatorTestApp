//
//  TTASettingsListCell.swift
//  Translator
//
//  Created by admin on 11/26/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TTASettingsListCell: UICollectionViewCell {
    static let reuseID = "TTATranslatorsListCell"
    
//    ???? collection view cell init???
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellLayout()
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func setupCellLayout() {
        self.contentView.addSubview(cellView)
        self.cellView.addSubview(cellIcon)
        self.cellView.addSubview(cellTitle)
        cellView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        cellView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
//        cellIcon.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
//        cellIcon.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        cellIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        cellIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        cellIcon.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        cellIcon.widthAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
        
        cellTitle.leadingAnchor.constraint(equalTo: cellIcon.trailingAnchor, constant: 16).isActive = true
        cellTitle.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
//        cellTitle.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
//        cellTitle.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
    }
}
