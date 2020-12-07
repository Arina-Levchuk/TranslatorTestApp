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

//    Section ID type
    enum TTASettingsSection {
        case translators
        case appModes
        case languageModes
    }
    
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
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(TTASettingsListCell.self, forCellWithReuseIdentifier: TTASettingsListCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .yellow
        return collectionView
    }()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        setUpCollectionView()

    }
    
    func setUpCollectionView() {
        
        collectionView.backgroundColor = .systemYellow
        
//        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        view.addSubview(collectionView)

    }
    
//    func setUpCollectionViewLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewFlowLayout()
//        
//        let cellWidthHeightConstant: CGFloat = UIScreen.main.bounds.width * 0.2
//        
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        
//        layout.itemSize = CGSize(width: cellWidthHeightConstant, height: cellWidthHeightConstant)
//        
//        return layout
//    }


}

extension TTASettingsList: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allTranslators.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TTASettingsListCell.reuseID, for: indexPath) as! TTASettingsListCell
        
        let currentTranslator = allTranslators[indexPath.row]
        cell.cellTitle.text = currentTranslator.name
        cell.cellIcon.image = currentTranslator.translatorIcon

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedTranslator = allTranslators[indexPath.row]
        self.collectionView.reloadData()
        
        self.delegate?.newTranslatorIsSelected(translator: self.selectedTranslator)
    }
        
}

extension TTASettingsList: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 76)
    }
}


// Supplementary View for headers and footers
