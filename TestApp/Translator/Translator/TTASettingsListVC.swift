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
    
    var appModes: [AppearanceMode] = []
    var selectedAppMode: AppearanceMode!
    
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
        cv.register(TTASettingsListCell.self, forCellWithReuseIdentifier: "translatorsCVCell")
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
        cv.register(TTASettingsGridCell.self, forCellWithReuseIdentifier: TTASettingsGridCell.ReuseID.flagsCVCell.description)
        cv.register(TTASettingsHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        cv.register(TTASettingsFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .white
        return cv
    }()
    
    lazy var appearanceModesCV: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.register(TTASettingsGridCell.self, forCellWithReuseIdentifier: "appearanceModeCVCell")
        cv.register(TTASettingsHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        cv.register(TTASettingsFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "Footer")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .systemPurple
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Settings"
        
        setupViewLayout()
        
//        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: (translatorsCV.frame.height) + (flagsCV.frame.height))
        
        print(allLanguages)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        translatorsCV.collectionViewLayout.invalidateLayout()
        self.translatorsCV.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//      makes scrollView with multiple CVs scrollable
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: (translatorsCV.frame.height) + (flagsCV.frame.height))
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
        flagsCV.leadingAnchor.constraint(equalTo: translatorsCV.leadingAnchor).isActive = true
        flagsCV.trailingAnchor.constraint(equalTo: translatorsCV.trailingAnchor).isActive = true
        flagsCV.topAnchor.constraint(equalTo: translatorsCV.bottomAnchor).isActive = true
//        flagsCV.heightAnchor.constraint(equalToConstant: CGFloat((90 * allLanguages.count/3) + (8 * 3) + (50 * 2))).isActive = true
        flagsCV.heightAnchor.constraint(equalToConstant: CGFloat((allLanguages.count > 3 ? (90 * allLanguages.count/3) : 90) + (8 * 3) + (50 * 2))).isActive = true
        
        scrollView.addSubview(appearanceModesCV)
        appearanceModesCV.leadingAnchor.constraint(equalTo: translatorsCV.leadingAnchor).isActive = true
        appearanceModesCV.trailingAnchor.constraint(equalTo: translatorsCV.trailingAnchor).isActive = true
        appearanceModesCV.topAnchor.constraint(equalTo: flagsCV.bottomAnchor).isActive = true
//        flagsCV.heightAnchor.constraint(equalToConstant: CGFloat((90 * allLanguages.count/3) + (8 * 3) + (50 * 2))).isActive = true
        appearanceModesCV.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        
    }
    

}

extension TTASettingsListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.translatorsCV:
            return allTranslators.count
        case self.flagsCV:
            return allLanguages.count
        case self.appearanceModesCV:
            return 2
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let reusableCell: TTASettingsListCell = collectionView.dequeueReusableCell(for: indexPath)
        
        if collectionView == translatorsCV {
            
            let cell: TTASettingsListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "translatorsCVCell", for: indexPath) as! TTASettingsListCell
            
            let currentTranslator = allTranslators[indexPath.row]

            cell.cellIcon.image = currentTranslator.translatorIcon
            cell.cellTitle.text = currentTranslator.name
            
            let selectedTranslatorCell = UIView(frame: cell.bounds)
            selectedTranslatorCell.backgroundColor = .systemYellow
            
            cell.selectedBackgroundView = nil
            if currentTranslator.url == selectedTranslator.url {
                cell.isSelected = true
                cell.selectedBackgroundView = selectedTranslatorCell
            }
            
            return cell
            
        } else if collectionView == flagsCV {
            let flagCell = flagsCV.dequeueReusableCell(withReuseIdentifier: TTASettingsGridCell.ReuseID.flagsCVCell.description, for: indexPath) as! TTASettingsGridCell

            let currentLang = allLanguages[indexPath.row]
            flagCell.setupGridCellLayout(for: .squareCell)
            
            flagCell.cellIcon.image = currentLang.flagImg
            flagCell.cellTitle.text = currentLang.language
            
            let selectedLangCell = UIView(frame: flagCell.bounds)
            selectedLangCell.backgroundColor = .systemPink
            
            flagCell.selectedBackgroundView = nil
            if currentLang.langCode == selectedLanguage.langCode {
                flagCell.isSelected = true
                flagCell.selectedBackgroundView = selectedLangCell
            }
            
            return flagCell
        } else if collectionView == appearanceModesCV {
            let appModeCell = appearanceModesCV.dequeueReusableCell(withReuseIdentifier: "appearanceModeCVCell", for: indexPath) as! TTASettingsGridCell

            appModeCell.setupGridCellLayout(for: .roundCell)
            
            appModeCell.cellIcon.image = UIImage(named: "dark")
            appModeCell.cellTitle.text = "AppMode"
            
//            let selectedLangCell = UIView(frame: appModeCell.bounds)
//            selectedLangCell.backgroundColor = .systemPink
            
//            appModeCell.selectedBackgroundView = nil
//            if currentLang.langCode == selectedLanguage.langCode {
//                appModeCell.isSelected = true
//                appModeCell.selectedBackgroundView = selectedLangCell
//            }
            
            return appModeCell
            
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemSize: CGSize = CGSize.zero
        
        if collectionView == translatorsCV {
            itemSize = CGSize.init(width: self.scrollView.contentSize.width, height: 51)
        } else if collectionView == flagsCV {
            itemSize = CGSize.init(width: ((self.scrollView.contentSize.width - 16 - 16)/3), height: 90)
        } else if collectionView == appearanceModesCV {
            itemSize = CGSize.init(width: 80, height: 80)
        }
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? TTASettingsHeaderCollectionReusableView {
//                headerView.backgroundColor = .purple
                
                if collectionView == translatorsCV {
                    headerView.headerLabel.text = "TRANSLATION SERVICE"
                } else if collectionView == flagsCV {
                    headerView.headerLabel.text = "TRANSLATION LANGUAGE"
                } else if collectionView == appearanceModesCV {
                    headerView.headerLabel.text = "APPEARANCE MODE"
                }
                
                return headerView
            }
        case UICollectionView.elementKindSectionFooter:
            if let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as? TTASettingsFooterCollectionReusableView {
//                footerView.backgroundColor = .green
                
                if collectionView == translatorsCV {
                    footerView.footerLabel.text = "Select the service which will provide you with the translation"
                } else if collectionView == flagsCV {
                    footerView.footerLabel.text = "Select the language of translation"
                } else if collectionView == appearanceModesCV {
                    footerView.footerLabel.text = "Select appearance mode which will be applied to the whole app"
                }
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
        var sectionInset: CGFloat = CGFloat.zero
        
        if collectionView == translatorsCV {
            sectionInset = 0
        } else if collectionView == flagsCV {
            sectionInset = 8
        } else if collectionView == appearanceModesCV {
            sectionInset = 0
        }
        
        return sectionInset
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var edgeInsets: UIEdgeInsets = UIEdgeInsets.zero
        
        if collectionView == translatorsCV {
            edgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        } else if collectionView == flagsCV {
            edgeInsets = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        } else if collectionView == appearanceModesCV {
            edgeInsets = UIEdgeInsets.init(top: 8, left: 20, bottom: 8, right: 20)
        }
        return edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        var itemInset: CGFloat = CGFloat.zero
        
        if collectionView == flagsCV || collectionView == appearanceModesCV {
            itemInset = CGFloat.init(8)
        } else {
            return itemInset
        }
        return itemInset
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("SELECTED")
        
        if collectionView == translatorsCV {
            self.selectedTranslator = allTranslators[indexPath.row]
            self.translatorsCV.reloadData()
            self.delegate?.newTranslatorIsSelected(translator: self.selectedTranslator)
        } else if collectionView == flagsCV {
            self.selectedLanguage = allLanguages[indexPath.row]
            self.flagsCV.reloadData()
            self.delegate?.newLanguageSelected(language: self.selectedLanguage)
        }

    }

    
}



extension UICollectionView {
    func dequeueReusableCell<T: TTASettingsListCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else { fatalError("Unable to Dequeue Reusable Table View Cell")}
        
        return cell
    }
}
