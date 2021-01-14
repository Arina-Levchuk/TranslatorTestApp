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
    
//    func newLanguageSelected(language: TTATranslatorLanguage)
}

class TTASettingsListVC: UIViewController {

    var allTranslators: [TTATranslator] = []
    var selectedTranslator: TTATranslator!
    
    weak var delegate: TTASettingsListDelegate? = nil
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Settings"
        
        setupViewLayout()
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: (translatorsCV.frame.height))
        
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        translatorsCV.collectionViewLayout.invalidateLayout()
    }
    
    func setupViewLayout() {
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollView.addSubview(translatorsCV)
        translatorsCV.translatesAutoresizingMaskIntoConstraints = false
        translatorsCV.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        translatorsCV.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        translatorsCV.heightAnchor.constraint(equalToConstant: CGFloat((51 * allTranslators.count))).isActive = true

    }
    

}

extension TTASettingsListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allTranslators.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TTASettingsListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TTASettingsListCell", for: indexPath) as! TTASettingsListCell
        
        let currentTranslator = allTranslators[indexPath.row]
        
        cell.cellIcon.image = currentTranslator.translatorIcon
        cell.cellTitle.text = currentTranslator.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.scrollView.contentSize.width, height: 51)
        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            return 0
//        }
//
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            return 0
//        }
    }
    
    
}


//extension UICollectionView {
//    func dequeueReusableCell<T: TTASettingsListCell>(for indexPath: IndexPath) -> T {
//        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else { fatalError("Unable to Dequeue Reusable Table View Cell")}
//
//        return cell
//    }
//}
