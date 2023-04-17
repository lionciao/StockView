//
//  LocalService.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import CoreData

public final class LocalService {
    
    private let persistence: PersistenceDelegate
    
    init(persistence: PersistenceDelegate) {
        self.persistence = persistence
    }
    
    func save(_ object: ManagedObjectEncodable) throws {
        try persistence.performTask(in: .main, execution: { context in
            _ = try object.encode(in: context)
            try context.save()
        })
    }
    
    func fetch<T: NSManagedObject>(_ request: NSFetchRequest<T>, with sortDescriptors: [NSSortDescriptor] = [], predicate: NSPredicate? = nil, completion: @escaping (([T]) throws -> Void)) throws {
        if !sortDescriptors.isEmpty {
            request.sortDescriptors = sortDescriptors
        }

        request.predicate = predicate
        try persistence.performTask(in: .main, execution: { context in
            let managedObjects = try context.fetch(request)
            try completion(managedObjects)
        })
    }
    
    func delete<T: NSManagedObject>(entity: T) throws {
        try persistence.performTask(in: .main, execution: { context in
            context.delete(entity)
            try context.save()
        })
    }
}
