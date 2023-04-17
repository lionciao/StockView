//
//  PersistenceDelegate.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import CoreData

public protocol PersistenceDelegate: AnyObject {
    
    @discardableResult
    func performTask<Result>(
        in queue: PersistenceQueue,
        execution task: @escaping (_ context: NSManagedObjectContext) throws -> Result) throws -> Result
}
