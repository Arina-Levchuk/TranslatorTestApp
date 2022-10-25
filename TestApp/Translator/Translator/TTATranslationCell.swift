//
//  TTATranslationCell.swift
//  Translator
//
//  Created by admin on 7/27/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SnapKit

class TTATranslationCell: UITableViewCell {
    static let reuseIdentifier = "TTATranslatorResultCell"
    static let boldFont = UIFont.boldSystemFont(ofSize: 17)
    static let subtitleFont = UIFont.systemFont(ofSize: 17)

    lazy var cellTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .label
        lbl.font = TTATranslationCell.boldFont
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    lazy var cellSubtitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .label
        lbl.font = TTATranslationCell.subtitleFont
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    lazy var locationButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
        button.isEnabled = false
        return button
    }()
    
    lazy var retryButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "retryButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        setCellDirection()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onAppLangDidChange(_:)), name: .didChangeAppLang, object: nil)
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
        cellSubtitle.textColor = .label
    }

// MARK: - Methods
    func showSpinner(animate: Bool) {
        if animate == true {
            spinner.isHidden = false
            spinner.startAnimating()
        }  else  {
            spinner.stopAnimating()
            spinner.hidesWhenStopped = true
        }
    }
    
    func setupUI() {
        self.addSubview(cellTitle)
        self.addSubview(cellSubtitle)
        self.addSubview(spinner)
        self.addSubview(locationButton)
        self.addSubview(retryButton)
        self.spinner.isHidden = true
        self.retryButton.isHidden = true
        
        cellTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalTo(retryButton.snp.leading).offset(-10)
        }
        
        cellSubtitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(cellTitle.snp.bottom).offset(5)
            make.trailing.equalTo(retryButton.snp.leading).offset(-10)
        }
        
        spinner.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        locationButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        retryButton.snp.makeConstraints { make in
            make.trailing.equalTo(locationButton.snp.leading).offset(-10)
            make.centerY.equalToSuperview()
        }
    }
    
    static func calculateCellHeight(item: TTATranslatorResult, width: CGFloat) -> CGFloat {
        let verticalInsets: CGFloat = (10 * 2) + 5
        let horizInsets: CGFloat = (16 * 2) + (10 * 2) + 65
        let textWidth: CGFloat = width - horizInsets
        
        let titleHeight: CGFloat = item.textToTranslate.height(withConstrainedWidth: textWidth, font: TTATranslationCell.boldFont)
        let subtitleHeight: CGFloat = (item.translation ?? "").height(withConstrainedWidth: textWidth, font: TTATranslationCell.subtitleFont)
        
        let fullHeight: CGFloat = verticalInsets + titleHeight + subtitleHeight
        
        return max(fullHeight, 44)
    }

    func setCellDirection() {
        UIView.appearance().semanticContentAttribute = TTALocalizationManager.shared.getSelectedLocale().isRTL ? .forceRightToLeft : .forceLeftToRight
        cellTitle.semanticContentAttribute = TTALocalizationManager.shared.getSelectedLocale().isRTL ? .forceRightToLeft : .forceLeftToRight
        cellSubtitle.semanticContentAttribute = TTALocalizationManager.shared.getSelectedLocale().isRTL ? .forceRightToLeft : .forceLeftToRight
        
        TTALocalizationManager.shared.getSelectedLocale().isRTL ? locationButton.setImage(UIImage(systemName: "chevron.left"), for: .normal) : locationButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    }
    
    @objc func onAppLangDidChange(_ notification: NSNotification) {
        setCellDirection()
    }
}
