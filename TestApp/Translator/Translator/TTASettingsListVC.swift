//
//  TTASettingsListVC.swift
//  Translator
//
//  Created by admin on 1/14/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

protocol TTASettingsListDelegate: AnyObject {
    func newTranslatorIsSelected(translator: TTATranslator)
    func newLanguageSelected(language: TTATranslatorLanguage)
}

class TTASettingsListVC: UIViewController {
    
//  MARK: - Properties
    
//    Translators
    static var allTranslators: [TTATranslator] = [
        TTATranslator(name: TTASettingsVCKeys.TTATranslatorsKeys.TTATranslatorName.localizedString(type: .yoda), url: URL(string: "https://api.funtranslations.com/translate/yoda.json"), translatorIcon: UIImage(named: "Yoda")),
        TTATranslator(name: TTASettingsVCKeys.TTATranslatorsKeys.TTATranslatorName.localizedString(type: .klingon), url: URL(string: "https://api.funtranslations.com/translate/klingon.json"), translatorIcon: UIImage(named: "Klingon")),
        TTATranslator(name: TTASettingsVCKeys.TTATranslatorsKeys.TTATranslatorName.localizedString(type: .shakespeare), url: URL(string: "https://api.funtranslations.com/translate/shakespeare.json"), translatorIcon: UIImage(named: "Shakespeare")),
        TTATranslator(name: TTASettingsVCKeys.TTATranslatorsKeys.TTATranslatorName.localizedString(type: .yandex), url: URL(string: "https://translate.yandex.net/api/v1.5/tr.json/translate"), translatorIcon: UIImage(named: "Yandex"), queryDict: ["key": "trnsl.1.1.20200504T182931Z.03785aecf85306af.7922af70293ac75cde1e43526b6b4c4cd682cf8e"]),
        TTATranslator(name: TTASettingsVCKeys.TTATranslatorsKeys.TTATranslatorName.localizedString(type: .valyrian), url: URL(string: "https://api.funtranslations.com/translate/valyrian.json"), translatorIcon: UIImage(named: "GoT"))
    ]
    var selectedTranslator: TTATranslator!
    
//   Flags
    static var allLanguages: [TTATranslatorLanguage] = [
        TTATranslatorLanguage(language: TTASettingsVCKeys.TTALanguagesKeys.TTALanguageName.localizedString(type: .rus), flagImg: UIImage(named: "ru"), langCode: "ru"),
        TTATranslatorLanguage(language: TTASettingsVCKeys.TTALanguagesKeys.TTALanguageName.localizedString(type: .hebrew), flagImg: UIImage(named: "he"), langCode: "he"),
        TTATranslatorLanguage(language: TTASettingsVCKeys.TTALanguagesKeys.TTALanguageName.localizedString(type: .polish), flagImg: UIImage(named: "pl"), langCode: "pl"),
        TTATranslatorLanguage(language: TTASettingsVCKeys.TTALanguagesKeys.TTALanguageName.localizedString(type: .chinese), flagImg: UIImage(named: "zh"), langCode: "zh"),
        TTATranslatorLanguage(language: TTASettingsVCKeys.TTALanguagesKeys.TTALanguageName.localizedString(type: .spanish), flagImg: UIImage(named: "es"), langCode: "es"),
        TTATranslatorLanguage(language: TTASettingsVCKeys.TTALanguagesKeys.TTALanguageName.localizedString(type: .ukr), flagImg: UIImage(named: "uk"), langCode: "uk")
    ]
    var selectedLanguage: TTATranslatorLanguage!
    
//  Appearance Modes
    var allAppModes: [TTAAppearanceMode] = [
        TTAAppearanceMode(mode: "Device's Mode", modeImg: UIImage(named: "device"), appMode: .device),
        TTAAppearanceMode(mode: "Light", modeImg: UIImage(named: "light"), appMode: .light),
        TTAAppearanceMode(mode: "Dark", modeImg: UIImage(named: "dark"), appMode: .dark)
    ]
    var selectedAppMode: TTAAppearanceMode!
    
//  App Languages
    static var allAppLocales: [TTAAppLocale] = [
        TTAAppLocale(name: TTASettingsVCKeys.TTALocalizationSettingsKeys.TTALocaleName.localizedString(type: .english), code: .english, isRTL: false),
        TTAAppLocale(name: TTASettingsVCKeys.TTALocalizationSettingsKeys.TTALocaleName.localizedString(type: .arabic), code: .arabic, isRTL: true)
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
    
    init(selectedTranslator: TTATranslator, selectedLanguage: TTATranslatorLanguage, delegate: TTASettingsListDelegate?) {        
        self.selectedTranslator = selectedTranslator
        self.selectedLanguage = selectedLanguage
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var scrollView: UIScrollView = {
        var sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
//        sv.backgroundColor = .systemYellow
        sv.backgroundColor = .systemBackground
        return sv
    }()
    
    lazy var translatorCV: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.register(TTASettingsListCell.self, forCellWithReuseIdentifier: TTASettingsListCell.ReuseID.translatorsCVCell.description)
        cv.register(TTASettingsHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TTASettingsHeaderCollectionReusableView.reuseID)
        cv.register(TTASettingsFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: TTASettingsFooterCollectionReusableView.reuseID)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .systemBackground
        return cv
    }()
    
    lazy var flagCV: UICollectionView = {
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
    
    lazy var appearanceModeCV: UICollectionView = {
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
    
    lazy var localeCV: UICollectionView = {
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
        navigationController?.navigationBar.barTintColor = .systemGray6
        navigationItem.title = TTASettingsVCKeys.localizedString(type: .title)
        
        setupViewLayout()
        updateNavBar()
        
        self.navigationController?.navigationBar.semanticContentAttribute = TTALocalizationManager.shared.getSelectedLocale().isRTL ? .forceRightToLeft : .forceLeftToRight
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: (translatorCV.frame.height) + (flagCV.frame.height) + (localeCV.frame.height))
      
        self.selectedTranslator = TTASettingsListVC.allTranslators.first
        self.selectedLanguage = TTASettingsListVC.allLanguages.first
        
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
            for locale in TTASettingsListVC.allAppLocales {
                if locale.code == appLocale {
                    initialLocale = locale
                }
            }
            return initialLocale
        }()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidChangeAppLanguage(_:)), name: .didChangeAppLang, object: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        translatorCV.collectionViewLayout.invalidateLayout()
        flagCV.collectionViewLayout.invalidateLayout()
        appearanceModeCV.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//      makes scrollView with multiple CVs scrollable
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: (translatorCV.frame.height) + (flagCV.frame.height) + (appearanceModeCV.frame.height) + (localeCV.frame.height))
    }
    
//  MARK: - Methods
    func setupViewLayout() {
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollView.addSubview(translatorCV)
        translatorCV.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        translatorCV.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        translatorCV.heightAnchor.constraint(equalToConstant: CGFloat((51 * TTASettingsListVC.allTranslators.count) + (50 * 2))).isActive = true
        
        scrollView.addSubview(flagCV)
        flagCV.leadingAnchor.constraint(equalTo: translatorCV.leadingAnchor).isActive = true
        flagCV.trailingAnchor.constraint(equalTo: translatorCV.trailingAnchor).isActive = true
        flagCV.topAnchor.constraint(equalTo: translatorCV.bottomAnchor).isActive = true
//        flagsCV.heightAnchor.constraint(equalToConstant: CGFloat((90 * allLanguages.count/3) + (8 * 3) + (50 * 2))).isActive = true
//        TODO: (8 * n) should be calculated as if n = 2 or any other value
        flagCV.heightAnchor.constraint(equalToConstant: CGFloat((TTASettingsListVC.allLanguages.count > 3 ? (90 * TTASettingsListVC.allLanguages.count/3) : 90) + (8 * 2) + (50 * 2))).isActive = true
        
        scrollView.addSubview(appearanceModeCV)
        appearanceModeCV.leadingAnchor.constraint(equalTo: translatorCV.leadingAnchor).isActive = true
        appearanceModeCV.trailingAnchor.constraint(equalTo: translatorCV.trailingAnchor).isActive = true
        appearanceModeCV.topAnchor.constraint(equalTo: flagCV.bottomAnchor).isActive = true
        
        let modeItemHeight: CGFloat = 100
        let verticalInset: CGFloat = 8
        let headerFooterHeight: CGFloat = 50
        appearanceModeCV.heightAnchor.constraint(equalToConstant: CGFloat(modeItemHeight + (verticalInset * 2) + (headerFooterHeight * 2))).isActive = true
//        print(appearanceModesCV.bounds.height)
        
        scrollView.addSubview(localeCV)
        localeCV.leadingAnchor.constraint(equalTo: translatorCV.leadingAnchor).isActive = true
        localeCV.trailingAnchor.constraint(equalTo: translatorCV.trailingAnchor).isActive = true
        localeCV.topAnchor.constraint(equalTo: appearanceModeCV.bottomAnchor).isActive = true
        localeCV.heightAnchor.constraint(equalToConstant: CGFloat((headerFooterHeight * 2) + (51 * 2))).isActive = true
    }
    
    private func setAppearanceMode(for theme: AppearanceMode) {
        view.window?.overrideUserInterfaceStyle = theme.userInterfaceStyle
    }
}

//  MARK: - Extensions

extension TTASettingsListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.translatorCV:
            return TTASettingsListVC.allTranslators.count
        case self.flagCV:
            return TTASettingsListVC.allLanguages.count
        case self.appearanceModeCV:
            return allAppModes.count
        case self.localeCV:
            return TTASettingsListVC.allAppLocales.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case translatorCV:
            let translatorCell: TTASettingsListCell = collectionView.dequeueReusableCell(withReuseIdentifier: TTASettingsListCell.ReuseID.translatorsCVCell.description, for: indexPath) as! TTASettingsListCell
        
            let currentTranslator = TTASettingsListVC.allTranslators[indexPath.row]
            translatorCell.setupListCellLayout(for: .withIcon)

            translatorCell.cellIcon.image = currentTranslator.translatorIcon
            translatorCell.cellTitle.text = currentTranslator.name

            if currentTranslator.url == selectedTranslator.url {
                translatorCell.checkmark.isHidden = false
            }            
            return translatorCell
            
        case flagCV:
            let flagCell = flagCV.dequeueReusableCell(withReuseIdentifier: TTASettingsGridCell.ReuseID.flagsCVCell.description, for: indexPath) as! TTASettingsGridCell

            let currentLang = TTASettingsListVC.allLanguages[indexPath.row]
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
            
        case appearanceModeCV:
            let appearanceModeCell = appearanceModeCV.dequeueReusableCell(withReuseIdentifier: TTASettingsGridCell.ReuseID.appearanceModeCVCell.description, for: indexPath) as! TTASettingsGridCell

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
            
        case localeCV:
            let localeCell = localeCV.dequeueReusableCell(withReuseIdentifier: TTASettingsListCell.ReuseID.textAppearanceCVCell.description, for: indexPath) as! TTASettingsListCell
            
            let currentLocale = TTASettingsListVC.allAppLocales[indexPath.row]
            localeCell.setupListCellLayout(for: .noIcon)
            
            localeCell.cellTitle.text = currentLocale.name

            if currentLocale.code == selectedLocale.code {
                localeCell.checkmark.isHidden = false
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
                case translatorCV:
                    headerView.headerLabel.text = TTASettingsVCKeys.TTATranslatorsKeys.localizedString(type: .sectionHeader)
                    return headerView
                case flagCV:
                    headerView.headerLabel.text = TTASettingsVCKeys.TTALanguagesKeys.localizedString(type: .sectionHeader)
                    return headerView
                case appearanceModeCV:
                    headerView.headerLabel.text = TTASettingsVCKeys.TTAAppearanceModesKeys.localizedString(type: .sectionHeader)
                    return headerView
                case localeCV:
                    headerView.headerLabel.text = TTASettingsVCKeys.TTALocalizationSettingsKeys.localizedString(type: .sectionHeader)
                    return headerView
                default:
                    return UICollectionReusableView()
                }
            }
            
        case UICollectionView.elementKindSectionFooter:
            if let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TTASettingsFooterCollectionReusableView.reuseID, for: indexPath) as? TTASettingsFooterCollectionReusableView {
                
                switch collectionView {
                case translatorCV:
                    footerView.footerLabel.text = TTASettingsVCKeys.TTATranslatorsKeys.localizedString(type: .sectionFooter)
                    return footerView
                case flagCV:
                    footerView.footerLabel.text = TTASettingsVCKeys.TTALanguagesKeys.localizedString(type: .sectionFooter)
                    return footerView
                case appearanceModeCV:
                    footerView.footerLabel.text = TTASettingsVCKeys.TTAAppearanceModesKeys.localizedString(type: .sectionFooter)
                    return footerView
                case localeCV:
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
        case translatorCV, localeCV:
            return CGSize.init(width: self.scrollView.contentSize.width, height: 51)
        case flagCV:
            return CGSize.init(width: 110, height: 90)
        case appearanceModeCV:
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
        case flagCV:
            return 8
        default:
            return 0
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case translatorCV, localeCV:
            return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        case flagCV:
            return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        case appearanceModeCV:
            return UIEdgeInsets.init(top: 8, left: 20, bottom: 8, right: 20)
        default:
            return UIEdgeInsets.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case flagCV:
            return CGFloat.init(10)
        case appearanceModeCV:
            return CGFloat.init(16)
        default:
            return CGFloat.zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == translatorCV {
            self.selectedTranslator = TTASettingsListVC.allTranslators[indexPath.row]
            self.translatorCV.reloadData()
            self.delegate?.newTranslatorIsSelected(translator: self.selectedTranslator)
        } else if collectionView == flagCV {
            self.selectedLanguage = TTASettingsListVC.allLanguages[indexPath.row]
            self.flagCV.reloadData()
            self.delegate?.newLanguageSelected(language: self.selectedLanguage)
        } else if collectionView == appearanceModeCV {
            self.selectedAppMode = self.allAppModes[indexPath.row]
            self.appearanceMode = selectedAppMode.appMode
            self.appearanceModeCV.reloadData()
        } else if collectionView == localeCV {
            self.selectedLocale = TTASettingsListVC.allAppLocales[indexPath.row]
            self.appLocale = selectedLocale.code
            NotificationCenter.default.post(name: .didChangeAppLang, object: nil)
        }
    }
    
    func updateNavBar() {
        navigationItem.title = TTASettingsVCKeys.localizedString(type: .title)
        navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.semanticContentAttribute = TTALocalizationManager.shared.getSelectedLocale().isRTL ? .forceRightToLeft : .forceLeftToRight
        navigationItem.hidesBackButton = false
        
//        to change the Swipe Direction
        self.navigationController?.view.semanticContentAttribute = TTALocalizationManager.shared.getSelectedLocale().isRTL ? .forceRightToLeft : .forceLeftToRight
        
        self.navigationController?.navigationBar.setNeedsLayout()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.setNeedsDisplay()
    }
    
    @objc func onDidChangeAppLanguage(_ notification: NSNotification) {
        TTASettingsListVC.allTranslators = [
            TTATranslator(name: TTASettingsVCKeys.TTATranslatorsKeys.TTATranslatorName.localizedString(type: .yoda), url: URL(string: "https://api.funtranslations.com/translate/yoda.json"), translatorIcon: UIImage(named: "Yoda")),
            TTATranslator(name: TTASettingsVCKeys.TTATranslatorsKeys.TTATranslatorName.localizedString(type: .klingon), url: URL(string: "https://api.funtranslations.com/translate/klingon.json"), translatorIcon: UIImage(named: "Klingon")),
            TTATranslator(name: TTASettingsVCKeys.TTATranslatorsKeys.TTATranslatorName.localizedString(type: .shakespeare), url: URL(string: "https://api.funtranslations.com/translate/shakespeare.json"), translatorIcon: UIImage(named: "Shakespeare")),
            TTATranslator(name: TTASettingsVCKeys.TTATranslatorsKeys.TTATranslatorName.localizedString(type: .yandex), url: URL(string: "https://translate.yandex.net/api/v1.5/tr.json/translate"), translatorIcon: UIImage(named: "Yandex"), queryDict: ["key": "trnsl.1.1.20200504T182931Z.03785aecf85306af.7922af70293ac75cde1e43526b6b4c4cd682cf8e"]),
            TTATranslator(name: TTASettingsVCKeys.TTATranslatorsKeys.TTATranslatorName.localizedString(type: .valyrian), url: URL(string: "https://api.funtranslations.com/translate/valyrian.json"), translatorIcon: UIImage(named: "GoT"))
        ]
        
        TTASettingsListVC.allLanguages = [
            TTATranslatorLanguage(language: TTASettingsVCKeys.TTALanguagesKeys.TTALanguageName.localizedString(type: .rus), flagImg: UIImage(named: "ru"), langCode: "ru"),
            TTATranslatorLanguage(language: TTASettingsVCKeys.TTALanguagesKeys.TTALanguageName.localizedString(type: .hebrew), flagImg: UIImage(named: "he"), langCode: "he"),
            TTATranslatorLanguage(language: TTASettingsVCKeys.TTALanguagesKeys.TTALanguageName.localizedString(type: .polish), flagImg: UIImage(named: "pl"), langCode: "pl"),
            TTATranslatorLanguage(language: TTASettingsVCKeys.TTALanguagesKeys.TTALanguageName.localizedString(type: .chinese), flagImg: UIImage(named: "zh"), langCode: "zh"),
            TTATranslatorLanguage(language: TTASettingsVCKeys.TTALanguagesKeys.TTALanguageName.localizedString(type: .spanish), flagImg: UIImage(named: "es"), langCode: "es"),
            TTATranslatorLanguage(language: TTASettingsVCKeys.TTALanguagesKeys.TTALanguageName.localizedString(type: .ukr), flagImg: UIImage(named: "uk"), langCode: "uk")
        ]
        
        TTASettingsListVC.allAppLocales = [
            TTAAppLocale(name: TTASettingsVCKeys.TTALocalizationSettingsKeys.TTALocaleName.localizedString(type: .english), code: .english, isRTL: false),
            TTAAppLocale(name: TTASettingsVCKeys.TTALocalizationSettingsKeys.TTALocaleName.localizedString(type: .arabic), code: .arabic, isRTL: true)
        ]
        
        if TTALocalizationManager.shared.getSelectedLocale().isRTL {
            scrollView.semanticContentAttribute = .forceRightToLeft
            
            translatorCV.semanticContentAttribute = .forceRightToLeft
            flagCV.semanticContentAttribute = .forceRightToLeft
            appearanceModeCV.semanticContentAttribute = .forceRightToLeft
            localeCV.semanticContentAttribute = .forceRightToLeft
        } else {
            scrollView.semanticContentAttribute = .forceLeftToRight
            
            translatorCV.semanticContentAttribute = .forceLeftToRight
            flagCV.semanticContentAttribute = .forceLeftToRight
            appearanceModeCV.semanticContentAttribute = .forceLeftToRight
            localeCV.semanticContentAttribute = .forceLeftToRight
        }
        
        self.translatorCV.reloadData()
        self.flagCV.reloadData()
        self.appearanceModeCV.reloadData()
        self.localeCV.reloadData()

        updateNavBar()
    }
}

extension Notification.Name {
    static let didChangeAppLang = Notification.Name("appLanguageWillBeChanged")
}
