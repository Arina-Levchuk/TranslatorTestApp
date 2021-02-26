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
        lbl.textColor = .label
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
//        lbl.textAlignment = .natural
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    let cellSubtitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .label
        lbl.font = UIFont.systemFont(ofSize: 17)
//        lbl.textAlignment = .natural
        lbl.numberOfLines = 0   // to remove any maximum limit, and use as many lines as needed, set the value of this property to 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    let locationButton: UIButton = {
        let button = UIButton.init(type: .custom)
//        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
        button.isEnabled = false
        return button
    }()
    
    let retryButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "retryButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return button
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
    
    let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setUpHorizontalView() {
      
        cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        cellTitle.leadingAnchor.constraint(equalTo: cellView.layoutMarginsGuide.leadingAnchor, constant: 10).isActive = true
        cellTitle.trailingAnchor.constraint(equalTo: retryButton.leadingAnchor).isActive = true
        
        cellSubtitle.leadingAnchor.constraint(equalTo: cellTitle.leadingAnchor).isActive = true
        cellSubtitle.trailingAnchor.constraint(equalTo: cellTitle.trailingAnchor).isActive = true
        
        spinner.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        
        locationButton.leadingAnchor.constraint(equalTo: retryButton.trailingAnchor).isActive = true
        locationButton.trailingAnchor.constraint(equalTo: cellView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        retryButton.leadingAnchor.constraint(equalTo: cellTitle.trailingAnchor).isActive = true
        retryButton.trailingAnchor.constraint(equalTo: locationButton.leadingAnchor, constant: -10).isActive = true
  
    }
    
    func setUpVerticalView() {
        
        cellView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        cellTitle.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: cellView.layoutMarginsGuide.topAnchor, multiplier: 1).isActive = true
            
        cellSubtitle.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: cellTitle.lastBaselineAnchor, multiplier: 1).isActive = true
        
        cellView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: cellSubtitle.lastBaselineAnchor, multiplier: 1).isActive = true
                
//        locationButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        locationButton.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        spinner.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        retryButton.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
    
    }
    
    func setCellDirection() {
        
        if TTALocalizationManager.shared.getSelectedLocale().isRTL {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            cellTitle.semanticContentAttribute = .forceRightToLeft
            cellSubtitle.semanticContentAttribute = .forceRightToLeft
            locationButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            cellTitle.semanticContentAttribute = .forceLeftToRight
            cellSubtitle.semanticContentAttribute = .forceLeftToRight
            locationButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        }
        
//        if UserDefaults.standard.appLocale.description == TTALocaleName.arabic.description {
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//            cellTitle.semanticContentAttribute = .forceRightToLeft
//            cellSubtitle.semanticContentAttribute = .forceRightToLeft
//            locationButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
//        } else {
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//            cellTitle.semanticContentAttribute = .forceLeftToRight
//            cellSubtitle.semanticContentAttribute = .forceLeftToRight
//            locationButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
//        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellView)
        
        cellView.addSubview(cellTitle)
        cellView.addSubview(cellSubtitle)
        cellView.addSubview(locationButton)
        cellView.addSubview(retryButton)
        retryButton.isHidden = true
        
        cellView.addSubview(spinner)
        spinner.isHidden = true
        
        setUpHorizontalView()
        setUpVerticalView()
        
        setCellDirection()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onAppLangDidChange(_:)), name: .didChangeAppLang, object: nil)
        
    }
    
    @objc func onAppLangDidChange(_ notification: NSNotification) {
        setCellDirection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellTitle.text = nil
        cellSubtitle.text = nil
        spinner.isHidden = true
        retryButton.isHidden = true
        cellSubtitle.textColor = .black
    }
    
}

