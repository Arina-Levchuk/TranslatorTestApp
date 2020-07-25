//
//  CustomCell.swift
//  Translator
//
//  Created by admin on 7/7/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    static let reuseIdentifier = "CustomCell"
    
//    var translation: Result? {
//        didSet {
//            guard let translationResult = translation else { return }
//            textToTranslateLabel.text = translationResult.textToTranslate
//            
//            while (translationResult.resultFromYandex == nil) && (translationResult.resultFromFunTranslator == nil) {
////                  ??
//                showActivityIndicator(animate: true)
//            }
//            showActivityIndicator(animate: false)
//            if let resultFromYandex = translationResult.resultFromYandex {
//                translationResultLabel.text = resultFromYandex
//            } else if let resultFromFunTranslator = translationResult.resultFromFunTranslator {
//                translationResultLabel.text = resultFromFunTranslator
//            } else {
////               How to display error message??
//                translationResultLabel.text = errorMessage.text
//            }
//
//        }
//    }
    
    var cellTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    var cellSubtitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0   // to remove any maximum limit, and use as many lines as needed, set the value of this property to 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    let errorMessage: UILabel = {
        let lbl = UILabel()
        lbl.text = "Error. Please retry"
        lbl.textColor = .red
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let spinner: UIActivityIndicatorView! = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    func showSpinner(animate: Bool) {
        if animate == true {
            spinner.isHidden = false
            spinner.frame = cellSubtitle.frame
            spinner.startAnimating()
        }  else  {
            spinner.stopAnimating()
            spinner.hidesWhenStopped = true
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(cellTitle)
        contentView.addSubview(cellSubtitle)
        contentView.addSubview(errorMessage)
        errorMessage.isHidden = true
        contentView.addSubview(spinner)
        spinner.isHidden = true
        
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        cellSubtitle.translatesAutoresizingMaskIntoConstraints = false
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
//        Horizontal position for each label
        cellTitle.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        cellTitle.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true

        cellSubtitle.leadingAnchor.constraint(equalTo: cellTitle.leadingAnchor).isActive = true
        cellSubtitle.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        spinner.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

//      ??
        errorMessage.leadingAnchor.constraint(equalTo: cellTitle.leadingAnchor).isActive = true
        errorMessage.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
    
//        Vertical position for each label
        cellTitle.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: contentView.layoutMarginsGuide.topAnchor, multiplier: 1).isActive = true
        cellSubtitle.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: cellTitle.lastBaselineAnchor, multiplier: 1).isActive = true
        contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: cellSubtitle.lastBaselineAnchor, multiplier: 1).isActive = true
//        spinner.topAnchor.constraint(equalToSystemSpacingBelow: cellTitle.lastBaselineAnchor, multiplier: 1).isActive = true
//        spinner.bottomAnchor.constraint(equalTo: spinner.topAnchor, constant: -20).isActive = true
//  OR
//        spinner.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
//        ??
        errorMessage.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: cellTitle.lastBaselineAnchor, multiplier: 1).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
