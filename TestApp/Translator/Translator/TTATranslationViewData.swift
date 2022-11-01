//
//  TTATranslationViewData.swift
//  Translator
//
//  Created by Arina Levchuk on 25.10.22.
//  Copyright © 2022 admin. All rights reserved.
//

import UIKit

class TTATranslationViewData: NSObject {
    
    let view: TTATranslationTableVC
    let table: UITableView
    
    init(view: TTATranslationTableVC) {
        self.view = view
        self.table = self.view.tableView
        super.init()
        self.setupTable()
    }
    
    func setupTable() {
        self.table.dataSource = self
        self.table.delegate = self
        self.table.register(TTATranslationCell.self, forCellReuseIdentifier: TTATranslationCell.reuseIdentifier)
    }
}

extension TTATranslationViewData: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.view.fetchedResultsController.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = self.view.fetchedResultsController.sections?[section] else { return 0 }
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellWidth = UIScreen.main.bounds.width
        let item = self.view.fetchedResultsController.object(at: indexPath)
        return TTATranslationCell.calculateCellHeight(item: item, width: cellWidth)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TTATranslationCell.reuseIdentifier, for: indexPath) as! TTATranslationCell
        
        let result = self.view.fetchedResultsController.object(at: indexPath)

        cell.cellTitle.text = result.textToTranslate
        cell.retryButton.addTarget(self, action: #selector(self.view.didTapRetryButton), for: .touchUpInside)
                
        switch result.responseStatus {
        case TTATranslatorResult.ResponseStatus.success.description:
            cell.showSpinner(animate: false)
            cell.cellSubtitle.text = result.translation
            cell.cellSubtitle.textColor = .label
        case TTATranslatorResult.ResponseStatus.failure.description:
            cell.showSpinner(animate: false)
            cell.cellSubtitle.text = TTAResultTableVCKeys.localizedString(type: .cellErrorMessage)
            cell.cellSubtitle.textColor = .systemRed
            cell.retryButton.isHidden = false
        default:
            cell.showSpinner(animate: true)
//            cell.cellSubtitle.text = nil
        }
        return cell
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: TTATranslationCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let result = self.view.fetchedResultsController.object(at: indexPath)
        
        self.view.coreDataStack.managedContext.delete(result)
        self.view.coreDataStack.saveContext()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = self.view.fetchedResultsController.object(at: indexPath)
        self.view.navigationController?.pushViewController(TTAUserLocationVC(latitude: result.latitude, longitude: result.longitude), animated: true)
    }
}
