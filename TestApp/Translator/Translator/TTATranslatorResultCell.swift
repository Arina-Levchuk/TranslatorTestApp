//
//  TTATranslatorResultCell.swift
//  Translator
//
//  Created by admin on 7/27/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TTATranslatorResultCell: UITableViewCell {
    static let reuseIdentifier = "TTATranslatorResultCell"
    
    let cellTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    let cellSubtitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0   // to remove any maximum limit, and use as many lines as needed, set the value of this property to 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    let errorLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .red
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.text = "Error. Please retry"
        return lbl
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    func showSpinner(animate: Bool) {
        if animate == true {
            spinner.isHidden = false
            spinner.startAnimating()
        }  else  {
            spinner.stopAnimating()
            spinner.hidesWhenStopped = true
        }
    }
    
    func setUpHorizontalView() {
//      Horizontal position for each label
        cellTitle.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        cellTitle.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        cellSubtitle.leadingAnchor.constraint(equalTo: cellTitle.leadingAnchor).isActive = true
        cellSubtitle.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        spinner.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    func setUpVerticalView() {
//      Vertical position for each label
        cellTitle.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: contentView.layoutMarginsGuide.topAnchor, multiplier: 1).isActive = true
            
        cellSubtitle.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: cellTitle.lastBaselineAnchor, multiplier: 1).isActive = true
        
        contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: cellSubtitle.lastBaselineAnchor, multiplier: 1).isActive = true
    
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellTitle)
        contentView.addSubview(cellSubtitle)
        
        contentView.addSubview(spinner)
        spinner.isHidden = true
        
        setUpHorizontalView()
        setUpVerticalView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellTitle.text = nil
        cellSubtitle.text = nil
        spinner.isHidden = true
        cellSubtitle.textColor = .black
    }
    
}
