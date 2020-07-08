//
//  CustomCell.swift
//  Translator
//
//  Created by admin on 7/7/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var translation: Result? {
        didSet {
            guard let textToTranslate = translation?.textToTranslate else { return }
            textToTranslateLabel.text = textToTranslate
            if let resultFromYandex = translation?.resultFromYandex?.joined(separator: "") {
                translationResultLabel.text = resultFromYandex
            } else if let resultFromFunTranslator = translation?.resultFromFunTranslator {
                translationResultLabel.text = resultFromFunTranslator
            } else {
//               How to display error message label??
                errorMessage
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
        
        contentView.addSubview(textToTranslateLabel)
        contentView.addSubview(translationResultLabel)
        contentView.addSubview(errorMessage)
        
        textToTranslateLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        textToTranslateLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        textToTranslateLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        textToTranslateLabel.bottomAnchor.constraint(equalTo: translationResultLabel.topAnchor).isActive = true
        
        translationResultLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        translationResultLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        translationResultLabel.topAnchor.constraint(equalTo: textToTranslateLabel.bottomAnchor).isActive = true
        translationResultLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        
        errorMessage.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 20).isActive = true
        errorMessage.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -20).isActive = true
        errorMessage.topAnchor.constraint(equalTo: textToTranslateLabel.bottomAnchor).isActive = true
        errorMessage.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



//override func tableView(_ tableView: UITableView,
//           heightForRowAt indexPath: IndexPath) -> CGFloat {
//   // Make the first row larger to accommodate a custom cell.
//  if indexPath.row == 0 {
//      return 80
//   }
//
//   // Use the default size for all other rows.
//   return UITableView.automaticDimension
//}
