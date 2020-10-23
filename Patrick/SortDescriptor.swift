//
//  SortDescriptor.swift
//  Patrick
//
//  Created by Brandon Erbschloe on 10/5/20.
//

import Foundation

public struct SortDescriptor<Object: NSObjectProtocol>: CustomStringConvertible {

    public let sortDescriptor: NSSortDescriptor
    
    var format: String {
        return "\(sortDescriptor.key!) \(sortDescriptor.ascending ? "ASC" : "DESC")"
    }
    
    public init(_ sortDescriptor: NSSortDescriptor) {
        self.sortDescriptor = sortDescriptor
    }
    
    public init<Value>(_ keyPath: KeyPath<Object, Value>, ascending: Bool) {
        self.sortDescriptor = NSSortDescriptor(keyPath: keyPath, ascending: ascending)
    }
    
    public init(_ key: String, ascending: Bool) {
        self.sortDescriptor = NSSortDescriptor(key: key, ascending: ascending)
    }
    
    public var description: String {
        return format
    }
}

func sortedBy<Root, Value>(_ keyPath: KeyPath<Root, Value>, ascending: Bool) -> SortDescriptor<Root> {
    return SortDescriptor(keyPath, ascending: ascending)
}

func sortedBy<Root>(_ key: String, ascending: Bool) -> SortDescriptor<Root> {
    return SortDescriptor(key, ascending: ascending)
}
