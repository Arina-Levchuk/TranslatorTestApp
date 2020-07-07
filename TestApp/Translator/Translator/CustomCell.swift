//
//  CustomCell.swift
//  Translator
//
//  Created by admin on 7/7/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    let textToTranslateView = UILabel()
    let translationResultView = UILabel()
    
    
    
//    var activityIndicator = UIActivityIndicatorView()
    
//    func showActivityIndicator() {
//        var activityView = UIActivityIndicatorView(style: .white)
//        activityView.center = self.view.center
//        self.view.addSubview(activityView)
//        activityView.startAnimating()
//    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textToTranslateView.translatesAutoresizingMaskIntoConstraints = false
        translationResultView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(textToTranslateView)
        contentView.addSubview(translationResultView)
        
        textToTranslateView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        textToTranslateView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        textToTranslateView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        textToTranslateView.bottomAnchor.constraint(equalTo: translationResultView.topAnchor).isActive = true
        
        translationResultView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        translationResultView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        translationResultView.topAnchor.constraint(equalTo: textToTranslateView.bottomAnchor).isActive = true
        translationResultView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        
//        textToTranslateView.font = UIFont.boldSystemFont(ofSize: 18) 
        
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
