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
    
    init(selectedTranslator: TTATranslator, allTranslators: [TTATranslator], delegate: TTASettingsListDelegate?) {
        self.selectedTranslator = selectedTranslator
        self.allTranslators = allTranslators
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var scrollView = UIScrollView()
    
    lazy var translatorsCV: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: setUpCollectionViewLayout())
        cv.register(TTASettingsListCell.self, forCellWithReuseIdentifier: TTASettingsListCell.reuseID)
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .systemYellow
        return cv
    }()
 
    lazy var flagsCV: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
//      TODO: TO REGISTER CELL
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .systemGray
        return cv
    }()
    
    lazy var appearanceModesCV: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
//      TODO: TO REGISTER CELL
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .systemPurple
        return cv
    }()
    
    lazy var textDirectionCV: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
//      TODO: TO REGISTER CELL
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = false
        cv.backgroundColor = .systemGreen
        return cv
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
        
        setupViewLayout()
        
//        setUpCollectionView()

    }
    
    func setupViewLayout() {
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        scrollView.addSubview(translatorsCV)
        translatorsCV.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        translatorsCV.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        translatorsCV.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
//        translatorsCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollView.addSubview(flagsCV)
        flagsCV.leadingAnchor.constraint(equalTo: translatorsCV.leadingAnchor).isActive = true
        flagsCV.trailingAnchor.constraint(equalTo: translatorsCV.trailingAnchor).isActive = true
        flagsCV.topAnchor.constraint(equalTo: translatorsCV.bottomAnchor).isActive = true
        
        scrollView.addSubview(textDirectionCV)
        textDirectionCV.leadingAnchor.constraint(equalTo: flagsCV.leadingAnchor).isActive = true
        textDirectionCV.trailingAnchor.constraint(equalTo: flagsCV.trailingAnchor).isActive = true
        textDirectionCV.topAnchor.constraint(equalTo: flagsCV.bottomAnchor).isActive = true
        
        scrollView.addSubview(appearanceModesCV)
        appearanceModesCV.leadingAnchor.constraint(equalTo: textDirectionCV.leadingAnchor).isActive = true
        appearanceModesCV.trailingAnchor.constraint(equalTo: textDirectionCV.trailingAnchor).isActive = true
        appearanceModesCV.topAnchor.constraint(equalTo: textDirectionCV.bottomAnchor).isActive = true
        appearanceModesCV.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            
    }
    
    
    func setUpCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
//        let cellWidthHeightConstant: CGFloat = UIScreen.main.bounds.width * 0.2
        
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
//        layout.itemSize = CGSize(width: cellWidthHeightConstant, height: cellWidthHeightConstant)
        
        return layout
    }
    
    
    private func setAppearanceMode(for theme: AppearanceMode) {
        view.window?.overrideUserInterfaceStyle = theme.userInterfaceStyle
    }


}

extension TTASettingsList: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allTranslators.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = translatorsCV.dequeueReusableCell(withReuseIdentifier: TTASettingsListCell.reuseID, for: indexPath) as! TTASettingsListCell
        
        let currentTranslator = allTranslators[indexPath.row]
        cell.cellTitle.text = currentTranslator.name
        cell.cellIcon.image = currentTranslator.translatorIcon

        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.selectedTranslator = allTranslators[indexPath.row]
//        self.translatorsCollectionView.reloadData()
//
//        self.delegate?.newTranslatorIsSelected(translator: self.selectedTranslator)
//    }
        
}

extension TTASettingsList: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
}


// Supplementary View for headers and footers
