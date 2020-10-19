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
    
    public func perform<O: Object>(query: Query<O>) -> Results<O> {
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
    
    public func filter(_ predicate: Predicate<Element>) -> Results<Element> {
        return filter(predicate.predicate)
    }
    
    public func sorted<Value>(byKeyPath keyPath: KeyPath<Element, Value>, ascending: Bool = true) -> Results<Element> {
        return sorted(byKeyPath: NSExpression(forKeyPath: keyPath).keyPath, ascending: ascending)
    }
    
    public func sorted<S: Sequence>(by sortDescriptors: S) -> Results<Element> where S.Iterator.Element == SortDescriptor<Element> {
        return sorted(by: sortDescriptors.map {
            RealmSwift.SortDescriptor($0.sortDescriptor)
        })
    }
}

extension List where Element: NSObjectProtocol {
    
    public func filter(_ predicate: Predicate<Element>) -> Results<Element> {
        return filter(predicate.predicate)
    }
    
    public func sorted<Value>(byKeyPath keyPath: KeyPath<Element, Value>, ascending: Bool = true) -> Results<Element> {
        return sorted(byKeyPath: NSExpression(forKeyPath: keyPath).keyPath, ascending: ascending)
    }
    
    public func sorted<S: Sequence>(by sortDescriptors: S) -> Results<Element> where S.Iterator.Element == SortDescriptor<Element> {
        return sorted(by: sortDescriptors.map {
            RealmSwift.SortDescriptor($0.sortDescriptor)
        })
    }
}

extension RealmSwift.SortDescriptor {
    
    internal init(_ sortDescriptor: NSSortDescriptor) {
        self.init(keyPath: sortDescriptor.key!, ascending: sortDescriptor.ascending)
    }
}

#endif
