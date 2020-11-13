//
//  CoreData+Patrick.swift
//  Patrick
//
//  Created by Brandon Erbschloe on 10/23/20.
//

import Foundation

#if canImport(CoreData)
import CoreData

extension Query where Object: NSManagedObject {
    
    /// Returns a NSFetchRequest representation of the currenty query.
    public func fetchRequest() -> NSFetchRequest<Object> {
        let request = NSFetchRequest<Object>()
        request.entity = Object.entity()
        request.predicate = predicate?.raw
        request.sortDescriptors = sortDescriptors.map(\.raw)
        return request
    }
}

extension NSManagedObjectContext {
    
    /// Returns an array of objects that meet the criteria specified by a given query.
    public func query<Object: NSManagedObject>(_ query: Query<Object>) throws -> [Object] {
        return try fetch(query.fetchRequest())
    }
    
    /// Returns a NSFetchedResultsController for the given query, section, and cache.
    public func fetchedResultsController<Object: NSManagedObject, Value>(
        query: Query<Object>,
        sectionNameKeyPath: KeyPath<Object, Value>? = nil,
        cacheName: String? = nil)
    throws -> NSFetchedResultsController<Object> {
        return NSFetchedResultsController(
            fetchRequest: query.fetchRequest(),
            managedObjectContext: self,
            sectionNameKeyPath: sectionNameKeyPath.map { NSExpression(forKeyPath: $0) }?.keyPath,
            cacheName: cacheName
        )
    }
}

#endif
