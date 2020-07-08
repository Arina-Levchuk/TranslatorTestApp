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
    
    var translation: Result? {
        didSet {
            guard let translationResult = translation else { return }
            textToTranslateLabel.text = translationResult.textToTranslate
            if let resultFromYandex = translationResult.resultFromYandex?.joined(separator: "") {
                translationResultLabel.text = resultFromYandex
            } else if let resultFromFunTranslator = translationResult.resultFromFunTranslator {
                translationResultLabel.text = resultFromFunTranslator
            } else {
//               How to display error message label??
                translationResultLabel.text = errorMessage.text
            }
            
//            if translation?.resultFromYandex?.joined(separator: "") != nil || ((translation?.resultFromFunTranslator) != nil) {
//
//            }
//            translationResultLabel.text = translation?.resultFromYandex?.joined(separator: "") ?? translation?.resultFromFunTranslator ?? errorMessage.text
        }
    }
    
    private let textToTranslateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let translationResultLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let errorMessage: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Error. Please retry"
        lbl.textColor = .red
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
//    var activityIndicator = UIActivityIndicatorView()
    
//    func showActivityIndicator() {
//        var activityView = UIActivityIndicatorView(style: .white)
//        activityView.center = self.view.center
//        self.view.addSubview(activityView)
//        activityView.startAnimating()
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        textToTranslateLabel.translatesAutoresizingMaskIntoConstraints = false
//        translationResultLabel.translatesAutoresizingMaskIntoConstraints = false
//        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(textToTranslateLabel)
        contentView.addSubview(translationResultLabel)
//        ??
//        contentView.addSubview(errorMessage)

//        Horizontal position for each label
        textToTranslateLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        textToTranslateLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        translationResultLabel.leadingAnchor.constraint(equalTo: textToTranslateLabel.leadingAnchor).isActive = true
        translationResultLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        errorMessage.leadingAnchor.constraint(equalTo: textToTranslateLabel.leadingAnchor).isActive = true
        errorMessage.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
    
//        Vertical position for each label
        textToTranslateLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: contentView.layoutMarginsGuide.topAnchor, multiplier: 1).isActive = true
        contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: translationResultLabel.lastBaselineAnchor, multiplier: 1).isActive = true
        translationResultLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: textToTranslateLabel.lastBaselineAnchor, multiplier: 1).isActive = true
//        errorMessage.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: textToTranslateLabel.lastBaselineAnchor, multiplier: 1).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




