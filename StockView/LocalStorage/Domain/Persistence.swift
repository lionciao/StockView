//
//  Persistence.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import CoreData

public final class Persistence: PersistenceDelegate {

    let container: NSPersistentContainer

    init(container: NSPersistentContainer = NSPersistentContainer(name: "StockPersistentContainer")) {
        self.container = container
        container.loadPersistentStores { _, error in
            if let error = error {
                // TODO: Error handling
                print("error: \(String(describing: error))")
            }
        }
    }

    @discardableResult
    public func performTask<Result>(in queue: PersistenceQueue, execution task: @escaping (_ context: NSManagedObjectContext) throws -> Result) throws -> Result {
        switch queue {
        case .main:
            let context = container.viewContext
            return try task(context)
        case .background:
            let context = container.newBackgroundContext()
            return try task(context)
        }
    }
}
