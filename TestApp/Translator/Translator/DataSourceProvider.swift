//
//  DataSourceProvider.swift
//  Translator
//
//  Created by admin on 4/22/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

protocol DataSourceProviderDelegate {
    func updateTable(insertItem: [IndexPath])
}

protocol DataSourceProvider {
    associatedtype T
//  что за прием с двойными [[]]?? но у меня после него убралась ошибка с resultItems[section].count
    var items: [[T]] { get set }
    var delegate: DataSourceProviderDelegate? { get set }
    
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> T?
    
    func updateCell(at indexPath: IndexPath, with value: T)
//    ???
//    func update(completion:@escaping (() -> Void))
        
}

extension DataSourceProvider {
    func numberOfSections() -> Int {
        return items.count
    }
    
//  Не оч понимаю, зачем эти условия с секциями - судя по предыд функции - количество секций соответствует количеству айтемов -> отдельная секция для каждого айтема ??
//  Тогда зачем нам рассчитывать количество айтемов??
// Я так понимаю - каждая секция = айтем коллекшн вью (а не tableView)
    func numberOfItems(in section: Int) -> Int {
        guard section >= 0 && section < items.count else {
            return 0
        }
        return items[section].count
    }
    
    func item(at indexPath: IndexPath) -> T? {
        guard indexPath.section >= 0 && indexPath.section < items.count && indexPath.row >= 0 && indexPath.row < items[indexPath.section].count else {
                return nil
        }
        return items[indexPath.section][indexPath.row]
    }
    
    mutating func updateCell(at indexPath: IndexPath, with value: T) {
        guard indexPath.section >= 0 && indexPath.section < items.count && indexPath.row >= 0 && indexPath.row < items[indexPath.section].count else {
                return
        }
        items[indexPath.section][indexPath.row] = value
    }
    
    
}
