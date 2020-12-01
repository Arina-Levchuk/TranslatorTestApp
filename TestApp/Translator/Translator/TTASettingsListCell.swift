//
//  TTASettingsListCell.swift
//  Translator
//
//  Created by admin on 11/26/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TTASettingsListCell: UICollectionViewCell {
    static let reuseID = "TTASettingsListCell"
    
//    ???? collection view cell init???
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupCellLayout()
    }
    
    let cellTitle: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setupCellLayout() {
        self.contentView.addSubview(cellTitle)
        cellTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        cellTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
}
