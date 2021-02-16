//
//  TTASettingsListCell.swift
//  Translator
//
//  Created by admin on 11/26/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TTASettingsListCell: UICollectionViewCell {
    
    enum CellView {
        case withIcon, noIcon
    }
    
    enum ReuseID: String {
        case translatorsCVCell, textAppearanceCVCell
        
        var description: String {
            return self.rawValue
        }
    }
    
    var setupListCellView: ((_ cellView: CellView?) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupListCellView = { [weak self] cellView in
            
            if let cellView = cellView {
                self?.setupListCellLayout(for: cellView)
            }
            
        }
        
        self.backgroundColor = .systemBackground
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.systemGray5.cgColor
        
        contentView.isUserInteractionEnabled = false
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellTitle.text = nil
        cellIcon.image = nil
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = UIColor.systemGray5.cgColor
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
 
    func setupListCellLayout(for cell: CellView) {
        
        switch cell {
        case .withIcon:
            
            contentView.addSubview(cellIcon)
            contentView.addSubview(cellTitle)

            cellIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            cellIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            cellIcon.widthAnchor.constraint(equalToConstant: 51).isActive = true
            cellIcon.heightAnchor.constraint(equalToConstant: 51).isActive = true
            
            cellTitle.leadingAnchor.constraint(equalTo: cellIcon.trailingAnchor, constant: 20).isActive = true
            cellTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            
        case .noIcon:
            contentView.addSubview(cellTitle)

            cellTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            cellTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            
        }
        

    }
    
}

//extension TTASettingsListCell: ReusableCVCell {}
