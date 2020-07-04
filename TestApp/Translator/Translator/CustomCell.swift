//
//  DynamicCell.swift
//  Translator
//
//  Created by admin on 6/30/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var translation: Result? {
        didSet {
            textFromInputFieldView.text = translation?.textToTranslate
            translationTextView.text = translation?.yandexTranslatorResult?.joined(separator: "") ?? translation?.funTranslatorResult ?? "Error. Please retry"
        }
    }
    
    
    let textFromInputFieldView = UITextView()
    let translationTextView = UITextView()
    let activityIndicator: UIActivityIndicatorView? = nil
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textFromInputFieldView.translatesAutoresizingMaskIntoConstraints = false
        translationTextView.translatesAutoresizingMaskIntoConstraints = false
        
        textFromInputFieldView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textFromInputFieldView.bottomAnchor.constraint(equalTo: translationTextView.topAnchor).isActive = true
//        textFromInputFieldView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive    = true
//        textFromInputFieldView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive    = true
        
        translationTextView.topAnchor.constraint(equalTo: textFromInputFieldView.bottomAnchor).isActive = true
        translationTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        translatedTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive    = true
//        translatedTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive    = true
        

        addSubview(textFromInputFieldView)
        addSubview(translationTextView)
        
        
        let stackView = UIStackView(arrangedSubviews: [textFromInputFieldView, translationTextView])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 2
        addSubview(stackView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
