//
//  TTASettingsList.swift
//  Translator
//
//  Created by admin on 11/26/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol TTASettingsListDelegate: class {
    func newTranslatorIsSelected(translator: TTATranslator)
    
    func newLanguageSelected(language: TTATranslatorLanguage)
}

class TTASettingsList: UIViewController {
    
    var defaults = UserDefaults.standard
    private var appearanceMode: AppearanceMode {
        get {
            return defaults.appearanceMode
        } set {
            defaults.appearanceMode = newValue
            setAppearanceMode(for: newValue)
        }
    }

//    Section ID type
//    enum TTASettingsSection {
//        case translators
//        case appModes
//        case flagModes
//        case textDirectionMode
//    }
    
    weak var delegate: TTASettingsListDelegate? = nil
    var allTranslators: [TTATranslator] = []
    var selectedTranslator: TTATranslator!
    
    var allLanguages: [TTATranslatorLanguage] = []
    var selectedLanguage: TTATranslatorLanguage!
    
    var allModes: [TTAAppearanceMode] = [
        TTAAppearanceMode(mode: "Light", modeImg: UIImage(named: "light")),
        TTAAppearanceMode(mode: "Dark", modeImg: UIImage(named: "dark"))
    ]
    
    var languages: [TTATranslatorLanguage] = [
        TTATranslatorLanguage(language: "Russian", flagImg: UIImage(named: "ru"), languageCode: "ru"),
        TTATranslatorLanguage(language: "Hebrew", flagImg: UIImage(named: "he"), languageCode: "he"),
        TTATranslatorLanguage(language: "Polish", flagImg: UIImage(named: "pl"), languageCode: "pl"),
        TTATranslatorLanguage(language: "Chinese", flagImg: UIImage(named: "zh"), languageCode: "zh"),
        TTATranslatorLanguage(language: "Spanish", flagImg: UIImage(named: "es"), languageCode: "es"),
        TTATranslatorLanguage(language: "Ukrainian", flagImg: UIImage(named: "uk"), languageCode: "uk")
    ]
    
    var textDirections: [String] = ["L->R", "R->L"]
    
    init(selectedTranslator: TTATranslator, allTranslators: [TTATranslator], delegate: TTASettingsListDelegate?) {
        self.selectedTranslator = selectedTranslator
        self.allTranslators = allTranslators
//        self.selectedLanguage = selectedLanguage
//        self.allLanguages = allLanguages
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
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .systemPink
        return cv
    }()
 
    lazy var flagsCV: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.register(TTASettingsListCell.self, forCellWithReuseIdentifier: TTASettingsListCell.reuseIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .systemGray
        return cv
    }()
    
    lazy var appearanceModesCV: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.register(TTASettingsListCell.self, forCellWithReuseIdentifier: TTASettingsListCell.reuseIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .systemPurple
        return cv
    }()
    
    lazy var textDirectionCV: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.register(TTASettingsListCell.self, forCellWithReuseIdentifier: TTASettingsListCell.reuseIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .systemGreen
        return cv
    }()
    
//  MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
        
        setupViewLayout()
        setupLayout(with: view.bounds.size)
        
//        setUpCollectionView()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: (translatorsCV.frame.height + flagsCV.frame.height + appearanceModesCV.frame.height + textDirectionCV.frame.height))
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupLayout(with: size)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupLayout(with: view.bounds.size)
    }
    
    func setupViewLayout() {
        
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
        scrollView.addSubview(translatorsCV)
        translatorsCV.translatesAutoresizingMaskIntoConstraints = false
        translatorsCV.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        translatorsCV.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        translatorsCV.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
//        TODO: SET THE CORRECT HEIGHT CONSTRAINT
        translatorsCV.heightAnchor.constraint(equalToConstant: 400).isActive = true
//        translatorsCV.heightAnchor.constraint(equalToConstant: CGFloat((51 * allTranslators.count))).isActive = true
        translatorsCV.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true

        scrollView.addSubview(flagsCV)
        flagsCV.leadingAnchor.constraint(equalTo: translatorsCV.leadingAnchor).isActive = true
        flagsCV.trailingAnchor.constraint(equalTo: translatorsCV.trailingAnchor).isActive = true
        flagsCV.topAnchor.constraint(equalTo: translatorsCV.bottomAnchor).isActive = true
//        TODO: SET THE CORRECT HEIGHT CONSTRAINT
        flagsCV.heightAnchor.constraint(equalToConstant: 100).isActive = true

        scrollView.addSubview(textDirectionCV)
        textDirectionCV.leadingAnchor.constraint(equalTo: flagsCV.leadingAnchor).isActive = true
        textDirectionCV.trailingAnchor.constraint(equalTo: flagsCV.trailingAnchor).isActive = true
        textDirectionCV.topAnchor.constraint(equalTo: flagsCV.bottomAnchor).isActive = true
//        TODO: SET THE CORRECT HEIGHT CONSTRAINT
        textDirectionCV.heightAnchor.constraint(equalToConstant: 100).isActive = true

        scrollView.addSubview(appearanceModesCV)
        appearanceModesCV.leadingAnchor.constraint(equalTo: textDirectionCV.leadingAnchor).isActive = true
        appearanceModesCV.trailingAnchor.constraint(equalTo: textDirectionCV.trailingAnchor).isActive = true
        appearanceModesCV.topAnchor.constraint(equalTo: textDirectionCV.bottomAnchor).isActive = true
//        TODO: SET THE CORRECT HEIGHT CONSTRAINT
        appearanceModesCV.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        appearanceModesCV.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

    }
        
    private func setupLayout(with containerSize: CGSize) {
        guard let flowLayout = translatorsCV.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
//        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        if traitCollection.horizontalSizeClass == .regular {
            let minItemWidth: CGFloat = 300
            let numberOfCell = containerSize.width / minItemWidth
            let width = floor((numberOfCell / floor(numberOfCell)) * minItemWidth)
            flowLayout.itemSize = CGSize(width: width, height: 51)
        } else {
            flowLayout.itemSize = CGSize(width: containerSize.width, height: 51)
        }
        
        translatorsCV.reloadData()
    }
        
    private func setAppearanceMode(for theme: AppearanceMode) {
        view.window?.overrideUserInterfaceStyle = theme.userInterfaceStyle
    }


}

extension TTASettingsList: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfItems: Int = 0
        
        if collectionView == self.translatorsCV {
            numberOfItems = allTranslators.count
        } else if collectionView == self.flagsCV {
            numberOfItems = languages.count
        } else if collectionView == self.appearanceModesCV {
            numberOfItems = allModes.count
        } else if collectionView == self.textDirectionCV {
            numberOfItems = textDirections.count
        }
        
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TTASettingsListCell = collectionView.dequeueReusableCell(for: indexPath)
        
        if collectionView == self.translatorsCV {
            let currentTranslator = allTranslators[indexPath.row]
            cell.cellTitle.text = currentTranslator.name
            cell.cellIcon.image = currentTranslator.translatorIcon
        } else if collectionView == self.appearanceModesCV {
            let selectedMode = allModes[indexPath.row]
            cell.cellTitle.text = selectedMode.mode
            cell.cellIcon.image = selectedMode.modeImg
        } else if collectionView == self.flagsCV {
            let selectedLanguage = languages[indexPath.row]
            cell.cellTitle.text = selectedLanguage.language
            cell.cellIcon.image = selectedLanguage.flagImg
        } else if collectionView == self.textDirectionCV {
            let selectedDirection = textDirections[indexPath.row]
            cell.cellTitle.text = selectedDirection
        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if collectionView == self.translatorsCV {
//            if kind == UICollectionView.elementKindSectionHeader {
//                let header = collectionView.dequeueReusableSupplementaryView(ofKind: "TRANSLATORS", withReuseIdentifier: "translatorsCVHeader", for: indexPath)
//                return header
//            } else if kind == UICollectionView.elementKindSectionFooter {
//                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: "Select translator", withReuseIdentifier: "translatorsCVFooter", for: indexPath)
//                return footer
//            }
//        }
//        fatalError()
//    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.selectedTranslator = allTranslators[indexPath.row]
//        self.translatorsCollectionView.reloadData()
//
//        self.delegate?.newTranslatorIsSelected(translator: self.selectedTranslator)
//        self.delegate?.newLanguageSelected(language: self.selectedLanguage)
//    }
        
}

extension UICollectionView {
    func dequeueReusableCell<T: TTASettingsListCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else { fatalError("Unable to Dequeue Reusable Table View Cell")}
        
        return cell
    }
    
}

//extension TTASettingsList: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        var cvCellSize: CGSize?
//        if collectionView == self.translatorsCV {
//            cvCellSize = CGSize(width: view.frame.width, height: 51)
//        } else {
//            cvCellSize = CGSize.zero
//        }
//        return cvCellSize!
//    }
//}


// Supplementary View for headers and footers
