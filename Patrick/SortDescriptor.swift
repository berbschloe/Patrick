//
//  SortDescriptor.swift
//  Patrick
//
//  Created by Brandon Erbschloe on 10/5/20.
//

import Foundation

/// A typesafe representation of a NSSortDescriptor.
public struct SortDescriptor<Object: NSObjectProtocol>: CustomStringConvertible {

    /// The raw sort descriptor.
    public let raw: NSSortDescriptor
    
    /// The sort descriptor's format string.
    public var format: String {
        return "\(raw.key!) \(raw.ascending ? "ASC" : "DESC")"
    }
    
    public init(_ sortDescriptor: NSSortDescriptor) {
        self.raw = sortDescriptor
    }
    
    public init<Value>(_ keyPath: KeyPath<Object, Value>, ascending: Bool) {
        self.raw = NSSortDescriptor(keyPath: keyPath, ascending: ascending)
    }
    
    public init(_ key: String, ascending: Bool) {
        self.raw = NSSortDescriptor(key: key, ascending: ascending)
    }
    
    public var description: String {
        return format
    }
}

public func sortedBy<Root, Value>(_ keyPath: KeyPath<Root, Value>, ascending: Bool) -> SortDescriptor<Root> {
    return SortDescriptor(keyPath, ascending: ascending)
}

public func sortedBy<Root>(_ key: String, ascending: Bool) -> SortDescriptor<Root> {
    return SortDescriptor(key, ascending: ascending)
}
