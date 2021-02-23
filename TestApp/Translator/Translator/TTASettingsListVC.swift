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
    
//  MARK: - Properties
    
//    Translators
    var allTranslators: [TTATranslator] = []
    var selectedTranslator: TTATranslator!
    
//   Flags
    var allLanguages: [TTATranslatorLanguage] = []
    var selectedLanguage: TTATranslatorLanguage!
    
//  Appearance Modes
    var allAppModes: [TTAAppearanceMode] = [
        TTAAppearanceMode(mode: "Device's Mode", modeImg: UIImage(named: "device"), appMode: .device),
        TTAAppearanceMode(mode: "Light", modeImg: UIImage(named: "light"), appMode: .light),
        TTAAppearanceMode(mode: "Dark", modeImg: UIImage(named: "dark"), appMode: .dark)
    ]
    var selectedAppMode: TTAAppearanceMode!
    
//  App Languages
    var allAppLocales: [TTAAppLocale] = [
        TTAAppLocale(name: TTASettingsVCKeys.TTALocalizationSettingsKeys.TTALocaleName.localizedString(type: .english), code: .english),
        TTAAppLocale(name: TTASettingsVCKeys.TTALocalizationSettingsKeys.TTALocaleName.localizedString(type: .arabic), code: .arabic)
    ]
    var selectedLocale: TTAAppLocale!
    
    var defaults = UserDefaults.standard
    private var appearanceMode: AppearanceMode {
        get {
            return defaults.appearanceMode
        } set {
            defaults.appearanceMode = newValue
            setAppearanceMode(for: newValue)
        }
    }
    
    private var appLocale: TTALocaleName {
        get {
            return defaults.appLocale
        } set {
            defaults.appLocale = newValue
            TTALocalizationManager.shared.setLocale(language: newValue.description)
        }
    }
    
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
        cv.register(TTASettingsListCell.self, forCellWithReuseIdentifier: TTASettingsListCell.ReuseID.translatorsCVCell.description)
        cv.register(TTASettingsHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TTASettingsHeaderCollectionReusableView.reuseID)
        cv.register(TTASettingsFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: TTASettingsFooterCollectionReusableView.reuseID)
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
        cv.register(TTASettingsHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TTASettingsHeaderCollectionReusableView.reuseID)
        cv.register(TTASettingsFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: TTASettingsFooterCollectionReusableView.reuseID)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    lazy var appearanceModesCV: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.register(TTASettingsGridCell.self, forCellWithReuseIdentifier: TTASettingsGridCell.ReuseID.appearanceModeCVCell.description)
        cv.register(TTASettingsHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TTASettingsHeaderCollectionReusableView.reuseID)
        cv.register(TTASettingsFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: TTASettingsFooterCollectionReusableView.reuseID)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    lazy var localesCV: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.register(TTASettingsListCell.self, forCellWithReuseIdentifier: TTASettingsListCell.ReuseID.textAppearanceCVCell.description)
        cv.register(TTASettingsHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TTASettingsHeaderCollectionReusableView.reuseID)
        cv.register(TTASettingsFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: TTASettingsFooterCollectionReusableView.reuseID)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
//  MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = TTASettingsVCKeys.localizedString(type: .title)
        
        setupViewLayout()

        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: (translatorsCV.frame.height) + (flagsCV.frame.height) + (localesCV.frame.height))
        
        self.selectedAppMode = {
            var initialMode: TTAAppearanceMode? = nil
            for mode in self.allAppModes {
                if mode.appMode == appearanceMode {
                    initialMode = mode
                }
            }
            return initialMode
        }()
        
        self.selectedLocale = {
            var initialLocale: TTAAppLocale? = nil
            for locale in allAppLocales {
                if locale.code == appLocale {
                    initialLocale = locale
                }
            }
            return initialLocale
        }()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidChangeAppLanguage(_:)), name: .didChangeAppLang, object: nil)
        
//        NotificationCenter.default.removeObserver(self, name: .didChangeAppLang, object: nil)

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        translatorsCV.collectionViewLayout.invalidateLayout()
        flagsCV.collectionViewLayout.invalidateLayout()
        appearanceModesCV.collectionViewLayout.invalidateLayout()
//        self.translatorsCV.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//      makes scrollView with multiple CVs scrollable
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: (translatorsCV.frame.height) + (flagsCV.frame.height) + (appearanceModesCV.frame.height) + (localesCV.frame.height))
    }
    
    
//  MARK: - Methods
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
//        TODO: (8 * n) should be calculated as if n = 2 or any other value
        flagsCV.heightAnchor.constraint(equalToConstant: CGFloat((allLanguages.count > 3 ? (90 * allLanguages.count/3) : 90) + (8 * 2) + (50 * 2))).isActive = true
        
        scrollView.addSubview(appearanceModesCV)
        appearanceModesCV.leadingAnchor.constraint(equalTo: translatorsCV.leadingAnchor).isActive = true
        appearanceModesCV.trailingAnchor.constraint(equalTo: translatorsCV.trailingAnchor).isActive = true
        appearanceModesCV.topAnchor.constraint(equalTo: flagsCV.bottomAnchor).isActive = true
        
        let modeItemHeight: CGFloat = 100
        let verticalInset: CGFloat = 8
        let headerFooterHeight: CGFloat = 50
        appearanceModesCV.heightAnchor.constraint(equalToConstant: CGFloat(modeItemHeight + (verticalInset * 2) + (headerFooterHeight * 2))).isActive = true
//        print(appearanceModesCV.bounds.height)
        
        scrollView.addSubview(localesCV)
        localesCV.leadingAnchor.constraint(equalTo: translatorsCV.leadingAnchor).isActive = true
        localesCV.trailingAnchor.constraint(equalTo: translatorsCV.trailingAnchor).isActive = true
        localesCV.topAnchor.constraint(equalTo: appearanceModesCV.bottomAnchor).isActive = true
        localesCV.heightAnchor.constraint(equalToConstant: CGFloat((headerFooterHeight * 2) + (51 * 2))).isActive = true
    
    }
    
    private func setAppearanceMode(for theme: AppearanceMode) {
        view.window?.overrideUserInterfaceStyle = theme.userInterfaceStyle
    }
    
}

//  MARK: - Extensions

extension TTASettingsListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.translatorsCV:
            return allTranslators.count
        case self.flagsCV:
            return allLanguages.count
        case self.appearanceModesCV:
            return allAppModes.count
        case self.localesCV:
            return allAppLocales.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let reusableCell: TTASettingsListCell = collectionView.dequeueReusableCell(for: indexPath)
        switch collectionView {
        case translatorsCV:
            
            let translatorCell: TTASettingsListCell = collectionView.dequeueReusableCell(withReuseIdentifier: TTASettingsListCell.ReuseID.translatorsCVCell.description, for: indexPath) as! TTASettingsListCell
        
            let currentTranslator = allTranslators[indexPath.row]
            translatorCell.setupListCellLayout(for: .withIcon)

            translatorCell.cellIcon.image = currentTranslator.translatorIcon
            translatorCell.cellTitle.text = currentTranslator.name
            
//            let selectedTranslatorCell = UIView(frame: cell.bounds)
//            selectedTranslatorCell.backgroundColor = .systemYellow
//
//            cell.selectedBackgroundView = nil
            if currentTranslator.url == selectedTranslator.url {
                translatorCell.checkmark.isHidden = false
//                cell.isSelected = true
//                cell.selectedBackgroundView = selectedTranslatorCell
            }            
            return translatorCell
            
        case flagsCV:
            let flagCell = flagsCV.dequeueReusableCell(withReuseIdentifier: TTASettingsGridCell.ReuseID.flagsCVCell.description, for: indexPath) as! TTASettingsGridCell

            let currentLang = allLanguages[indexPath.row]
            flagCell.setupGridCellLayout(for: .squareCell)
            
            flagCell.cellIcon.image = currentLang.flagImg
            flagCell.cellTitle.text = currentLang.language
            
            let selectedCell = UIView(frame: flagCell.bounds)
            selectedCell.backgroundColor = .systemYellow
            
            flagCell.selectedBackgroundView = nil
            if currentLang.langCode == selectedLanguage.langCode {
                flagCell.isSelected = true
                flagCell.selectedBackgroundView = selectedCell
            }
            return flagCell
            
        case appearanceModesCV:
            
            let appearanceModeCell = appearanceModesCV.dequeueReusableCell(withReuseIdentifier: TTASettingsGridCell.ReuseID.appearanceModeCVCell.description, for: indexPath) as! TTASettingsGridCell

            appearanceModeCell.setupGridCellLayout(for: .roundCell)
            let currentAppearanceMode = allAppModes[indexPath.row]
            
            appearanceModeCell.cellIcon.image = currentAppearanceMode.modeImg
            
            let selectedCell = UIView(frame: appearanceModeCell.bounds)
            selectedCell.backgroundColor = .systemYellow
            
            appearanceModeCell.selectedBackgroundView = nil
            if selectedAppMode != nil {
                if currentAppearanceMode.mode == self.selectedAppMode.mode {
                    appearanceModeCell.isSelected = true
                    appearanceModeCell.selectedBackgroundView = selectedCell
                }
            }
            
            return appearanceModeCell
        case localesCV:
            let localeCell = localesCV.dequeueReusableCell(withReuseIdentifier: TTASettingsListCell.ReuseID.textAppearanceCVCell.description, for: indexPath) as! TTASettingsListCell
            
            let currentLocale = allAppLocales[indexPath.row]
            localeCell.setupListCellLayout(for: .noIcon)
            
            localeCell.cellTitle.text = currentLocale.name
            
//            let selectedCell = UIView(frame: localeCell.bounds)
//            selectedCell.backgroundColor = .systemPurple
//
//            localeCell.selectedBackgroundView = nil
            if currentLocale.code == selectedLocale.code {
                localeCell.checkmark.isHidden = false
//                localeCell.isSelected = true
//                localeCell.selectedBackgroundView = selectedCell
            }
            
            return localeCell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TTASettingsHeaderCollectionReusableView.reuseID, for: indexPath) as? TTASettingsHeaderCollectionReusableView {
    
                switch collectionView {
                case translatorsCV:
                    headerView.headerLabel.text = TTASettingsVCKeys.TTATranslatorsKeys.localizedString(type: .sectionHeader)
                    return headerView
                case flagsCV:
                    headerView.headerLabel.text = TTASettingsVCKeys.TTALanguagesKeys.localizedString(type: .sectionHeader)
                    return headerView
                case appearanceModesCV:
                    headerView.headerLabel.text = TTASettingsVCKeys.TTAAppearanceModesKeys.localizedString(type: .sectionHeader)
                    return headerView
                case localesCV:
                    headerView.headerLabel.text = TTASettingsVCKeys.TTALocalizationSettingsKeys.localizedString(type: .sectionHeader)
                    return headerView
                default:
                    return UICollectionReusableView()
                }

            }
        case UICollectionView.elementKindSectionFooter:
            if let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TTASettingsFooterCollectionReusableView.reuseID, for: indexPath) as? TTASettingsFooterCollectionReusableView {
                
                switch collectionView {
                case translatorsCV:
                    footerView.footerLabel.text = TTASettingsVCKeys.TTATranslatorsKeys.localizedString(type: .sectionFooter)
                    return footerView
                case flagsCV:
                    footerView.footerLabel.text = TTASettingsVCKeys.TTALanguagesKeys.localizedString(type: .sectionFooter)
                    return footerView
                case appearanceModesCV:
                    footerView.footerLabel.text = TTASettingsVCKeys.TTAAppearanceModesKeys.localizedString(type: .sectionFooter)
                    return footerView
                case localesCV:
                    footerView.footerLabel.text = TTASettingsVCKeys.TTALocalizationSettingsKeys.localizedString(type: .sectionFooter)
                    return footerView
                default:
                    return UICollectionReusableView()
                }
            }
            
        default:
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch collectionView {
        case translatorsCV, localesCV:
            return CGSize.init(width: self.scrollView.contentSize.width, height: 51)
        case flagsCV:
            return CGSize.init(width: 110, height: 90)
        case appearanceModesCV:
            return CGSize.init(width: 100 , height: 100)
        default:
            return CGSize.zero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
 
        switch collectionView {
        case flagsCV:
            return 8
        default:
            return 0
        }

    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        switch collectionView {
        case translatorsCV, localesCV:
            return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        case flagsCV:
            return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        case appearanceModesCV:
            return UIEdgeInsets.init(top: 8, left: 20, bottom: 8, right: 20)
        default:
            return UIEdgeInsets.zero
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        switch collectionView {
        case flagsCV:
            return CGFloat.init(10)
        case appearanceModesCV:
            return CGFloat.init(16)
        default:
            return CGFloat.zero
        }

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
        } else if collectionView == appearanceModesCV {
            self.selectedAppMode = self.allAppModes[indexPath.row]
            self.appearanceMode = selectedAppMode.appMode
            self.appearanceModesCV.reloadData()
        } else if collectionView == localesCV {
            self.selectedLocale = self.allAppLocales[indexPath.row]
            self.appLocale = selectedLocale.code
            NotificationCenter.default.post(name: .didChangeAppLang, object: nil)
        }
        


    }
    
    @objc func onDidChangeAppLanguage(_ notification: NSNotification) {
        
        navigationItem.title = TTASettingsVCKeys.localizedString(type: .title)
        
        self.translatorsCV.reloadData()
        self.flagsCV.reloadData()
        self.appearanceModesCV.reloadData()
        self.localesCV.reloadData()
        
        
    }
    
}

extension Notification.Name {
    static let didChangeAppLang = Notification.Name("appLanguageWillBeChanged")
}
