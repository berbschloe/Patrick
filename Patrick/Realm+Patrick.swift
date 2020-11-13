//
//  Realm+Patrick.swift
//  Patrick
//
//  Created by Brandon Erbschloe on 10/12/20.
//

import Foundation

#if canImport(RealmSwift)
import RealmSwift

extension Realm {
    
    /// Returns all objects of the given type matching and sorted by the given query.
    public func query<O: Object>(_ query: Query<O>) -> Results<O> {
        var results = objects(O.self)
        if let predicate = query.predicate {
            results = results.filter(predicate)
        }
        if !query.sortDescriptors.isEmpty {
            results = results.sorted(by: query.sortDescriptors)
        }
        return results
    }
}

extension Results where Element: NSObjectProtocol {
    
    /// Returns a Results containing all objects matching the given predicate in the collection.
    public func filter(_ predicate: Predicate<Element>) -> Results<Element> {
        return filter(predicate.raw)
    }
    
    /// Returns a Results containing the objects represented by the results, but sorted.
    public func sorted<Value>(byKeyPath keyPath: KeyPath<Element, Value>, ascending: Bool = true) -> Results<Element> {
        return sorted(byKeyPath: NSExpression(forKeyPath: keyPath).keyPath, ascending: ascending)
    }
    
    /// Returns a Results containing the objects represented by the results, but sorted.
    public func sorted<S: Sequence>(by sortDescriptors: S) -> Results<Element> where S.Iterator.Element == SortDescriptor<Element> {
        return sorted(by: sortDescriptors.map {
            RealmSwift.SortDescriptor($0)
        })
    }
}

extension List where Element: NSObjectProtocol {
    
    /// Returns a Results containing all objects matching the given predicate in the list.
    public func filter(_ predicate: Predicate<Element>) -> Results<Element> {
        return filter(predicate.raw)
    }
    
    /// Returns a Results containing the objects in the list, but sorted.
    public func sorted<Value>(byKeyPath keyPath: KeyPath<Element, Value>, ascending: Bool = true) -> Results<Element> {
        return sorted(byKeyPath: NSExpression(forKeyPath: keyPath).keyPath, ascending: ascending)
    }
    
    /// Returns a Results containing the objects in the list, but sorted.
    public func sorted<S: Sequence>(by sortDescriptors: S) -> Results<Element> where S.Iterator.Element == SortDescriptor<Element> {
        return sorted(by: sortDescriptors.map {
            RealmSwift.SortDescriptor($0)
        })
    }
}

extension RealmSwift.SortDescriptor {
    
    internal init<Object>(_ sortDescriptor: SortDescriptor<Object>) {
        self.init(keyPath: sortDescriptor.raw.key!, ascending: sortDescriptor.raw.ascending)
    }
}

#endif
