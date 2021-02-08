//
//  TTATranslatorsListVC.swift
//  Translator
//
//  Created by admin on 3/28/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

//protocol RequestProtocolDelegate: class {
//    func passURLOfTranslator(selectedItem: String) -> URL
//}

protocol TranslatorsListVCDelegate: class {
    func newTranslatorSelected(translator: TTATranslator)
}

class TTATranslatorsListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedTranslator: TTATranslator!
    var allTranslators: [TTATranslator] = [TTATranslator]()
    weak var delegate: TranslatorsListVCDelegate? = nil

    init(selectedTranslator: TTATranslator, allTranslators: [TTATranslator], delegate: TranslatorsListVCDelegate?) {
        
        self.selectedTranslator = selectedTranslator
        self.delegate = delegate
        self.allTranslators = allTranslators
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let tableView = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
    let cellId = "cellId"

    
//    MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
   
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
//  MARK: - TableView Set Up
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "TRANSLATION SERVICE"
        }
        
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Select the service that will provide you with the translation."
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allTranslators.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let currentTranslator = self.allTranslators[indexPath.row]
        cell.textLabel?.text = currentTranslator.name
        
        cell.imageView?.image = currentTranslator.translatorIcon
        
        cell.accessoryType = .none
        if currentTranslator.url == self.selectedTranslator.url {
            cell.accessoryType = .checkmark
        }
        
        print("ContentSize: \(tableView.contentSize.height)")
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedTranslator = self.allTranslators[indexPath.row]
        self.tableView.reloadData()
        self.delegate?.newTranslatorSelected(translator: self.selectedTranslator)
    }
}

