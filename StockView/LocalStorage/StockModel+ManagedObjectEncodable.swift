//
//  StockModel+ManagedObjectEncodable.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import CoreData

extension StockModel: ManagedObjectEncodable {
    
    func encode(in context: NSManagedObjectContext) throws -> NSManagedObject {
        let object = StockManagedObject(context: context)
        object.symbol = symbol
        object.nickname = nickname
        return object
    }
}
