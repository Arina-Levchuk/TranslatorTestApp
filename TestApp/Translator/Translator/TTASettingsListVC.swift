//
//  TTASettingsListVC.swift
//  Translator
//
//  Created by admin on 1/14/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

protocol TTASettingsListDelegate: class {
    func newTranslatorIsSelected(translator: TTATranslator)
    
    func newLanguageSelected(language: TTATranslatorLanguage)
}

class TTASettingsListVC: UIViewController {

    var allTranslators: [TTATranslator] = []
    var selectedTranslator: TTATranslator!
    
    var allLanguages: [TTATranslatorLanguage] = []
    var selectedLanguage: TTATranslatorLanguage!
    
    weak var delegate: TTASettingsListDelegate? = nil
    
    init(selectedTranslator: TTATranslator, allTranslators: [TTATranslator], selectedLanguage: TTATranslatorLanguage, allLanguages: [TTATranslatorLanguage], delegate: TTASettingsListDelegate?) {
        
        self.selectedTranslator = selectedTranslator
        self.allTranslators = allTranslators
        
        self.selectedLanguage = selectedLanguage
        self.allLanguages = allLanguages
        
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var scrollView: UIScrollView = {
        var sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .systemYellow
        return sv
    }()
    
    lazy var translatorsCV: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.register(TTASettingsListCell.self, forCellWithReuseIdentifier: TTASettingsListCell.reuseIdentifier)
        cv.register(TTASettingsHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        cv.register(TTASettingsFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .white
        return cv
    }()
    
    lazy var flagsCV: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.register(TTASettingsListCell.self, forCellWithReuseIdentifier: TTASettingsListCell.reuseIdentifier)
//        cv.register(TTASettingsHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
//        cv.register(TTASettingsFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .systemPink
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Settings"
        
        setupViewLayout()
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: (translatorsCV.frame.height))
        
        print(allLanguages)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        translatorsCV.collectionViewLayout.invalidateLayout()
        self.translatorsCV.layoutIfNeeded()
    }
    
    func setupViewLayout() {
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollView.addSubview(translatorsCV)
        translatorsCV.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        translatorsCV.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        translatorsCV.heightAnchor.constraint(equalToConstant: CGFloat((51 * allTranslators.count) + (50 * 2))).isActive = true
        
        scrollView.addSubview(flagsCV)
        flagsCV.topAnchor.constraint(equalTo: translatorsCV.bottomAnchor).isActive = true
//        flagsCV.widthAnchor.constraint(equalTo: self.translatorsCV.widthAnchor).isActive = true
        flagsCV.heightAnchor.constraint(equalToConstant: 200).isActive = true

    }
    

}

extension TTASettingsListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.translatorsCV:
            return allTranslators.count
        case self.flagsCV:
            return allLanguages.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let reusableCell: TTASettingsListCell = collectionView.dequeueReusableCell(for: indexPath)
        
//        let cell: TTASettingsListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TTASettingsListCell", for: indexPath) as! TTASettingsListCell
        
//        switch collectionView {
//        case self.translatorsCV:
//            let currentTranslator = allTranslators[indexPath.row]
//            
//            reusableCell.cellIcon.image = currentTranslator.translatorIcon
//            reusableCell.cellTitle.text = currentTranslator.name
//            
//            let selectedView = UIView(frame: reusableCell.bounds)
//            selectedView.backgroundColor = .systemYellow
//            
//            reusableCell.selectedBackgroundView = nil
//            if currentTranslator.url == selectedTranslator.url {
//                reusableCell.isSelected = true
//                reusableCell.selectedBackgroundView = selectedView
//            }
//        case self.flagsCV:
//            let currentFlag = allFlags[indexPath.row]
//            
//        }
        let currentTranslator = allTranslators[indexPath.row]
        
        reusableCell.cellIcon.image = currentTranslator.translatorIcon
        reusableCell.cellTitle.text = currentTranslator.name
        
        let selectedView = UIView(frame: reusableCell.bounds)
        selectedView.backgroundColor = .systemYellow
        
        reusableCell.selectedBackgroundView = nil
        if currentTranslator.url == selectedTranslator.url {
            reusableCell.isSelected = true
            reusableCell.selectedBackgroundView = selectedView
        }
        
        return reusableCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.scrollView.contentSize.width, height: 51)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? TTASettingsHeaderCollectionReusableView {
//                headerView.backgroundColor = .purple
                headerView.headerLabel.text = "TRANSLATION SERVICE"
                return headerView
            }
        case UICollectionView.elementKindSectionFooter:
            if let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as? TTASettingsFooterCollectionReusableView {
//                footerView.backgroundColor = .green
                footerView.footerLabel.text = "Select the service which will provide you with the translation"
                return footerView
            }
        default:
            return UICollectionReusableView()
        }
        return UICollectionReusableView()

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("SELECTED")
        self.selectedTranslator = allTranslators[indexPath.row]
        self.translatorsCV.reloadData()
        self.delegate?.newTranslatorIsSelected(translator: self.selectedTranslator)
        
        self.selectedLanguage = allLanguages[indexPath.row]
        self.flagsCV.reloadData()
        self.delegate?.newLanguageSelected(language: self.selectedLanguage)
    }

    
}



extension UICollectionView {
    func dequeueReusableCell<T: TTASettingsListCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else { fatalError("Unable to Dequeue Reusable Table View Cell")}
        
        return cell
    }
}