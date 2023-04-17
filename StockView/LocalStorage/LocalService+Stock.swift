//
//  LocalService+Stock.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import Foundation

protocol StockService {
    
    func saveStock(_ stock: StockModel) throws
    func fetchStocks(completion: @escaping ([CompanyModel]) -> Void) throws
    func removeStock(_ stock: StockModel) throws
}

extension LocalService: StockService {
    
    func saveStock(_ stock: StockModel) throws {
        try save(stock)
    }
    
    func fetchStocks(completion: @escaping ([CompanyModel]) -> Void) throws {
        try fetch(StockManagedObject.fetchRequest(), with: [], completion: { results in
            let models = results.compactMap {
                $0.decode()
            }
            completion(models)
        })
    }
    
    func removeStock(_ stock: StockModel) throws {
        let predicate = NSPredicate(format: "symbol == \(stock.symbol)")
        try fetch(
            StockManagedObject.fetchRequest(),
            predicate: predicate,
            completion: { results in
                if let object = results.first {
                    try self.delete(entity: object)
                }
            }
        )
    }
}
