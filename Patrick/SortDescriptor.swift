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
    
    init(_ sortDescriptor: NSSortDescriptor) {
        self.sortDescriptor = sortDescriptor
    }
    
    public var description: String {
        return format
    }
}

func sortedBy<Root, Value>(_ keyPath: KeyPath<Root, Value>, ascending: Bool) -> SortDescriptor<Root> {
    return SortDescriptor(NSSortDescriptor(keyPath: keyPath, ascending: ascending))
}
