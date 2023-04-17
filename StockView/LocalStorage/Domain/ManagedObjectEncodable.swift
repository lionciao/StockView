//
//  ManagedObjectEncodable.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import CoreData

public protocol ManagedObjectEncodable {
    
    func encode(in context: NSManagedObjectContext) throws -> NSManagedObject
}
