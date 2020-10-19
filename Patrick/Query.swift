//
//  Query.swift
//  Patrick
//
//  Created by Brandon Erbschloe on 10/12/20.
//

import Foundation

public struct Query<Object: NSObjectProtocol>: CustomStringConvertible {
    
    public var predicate: Predicate<Object>?
    public var sortDescriptors: [SortDescriptor<Object>]
    
    init(predicate: Predicate<Object>?, sortDescriptors: [SortDescriptor<Object>] = []) {
        self.predicate = predicate
        self.sortDescriptors = sortDescriptors
    }
    
    public var format: String {
        var string = "FROM \(String(describing: Object.self))"
        if let predicate = predicate {
            string += " WHERE \(predicate.format)"
        }
        if !sortDescriptors.isEmpty {
            string += " ORDER BY \(sortDescriptors.map(\.format).joined(separator: ", "))"
        }
        return string
    }
    
    public var description: String {
        return format
    }
}
