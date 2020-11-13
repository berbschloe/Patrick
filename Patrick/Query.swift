//
//  Query.swift
//  Patrick
//
//  Created by Brandon Erbschloe on 10/12/20.
//

import Foundation

/// A type safe representation of both a NSPredicate and array of NSSortDescriptors.
public struct Query<Object: NSObjectProtocol>: CustomStringConvertible {
    
    /// The predicate of the query.
    public let predicate: Predicate<Object>?
    
    /// The sort descriptors of the query.
    public let sortDescriptors: [SortDescriptor<Object>]
    
    public init(predicate: Predicate<Object>?, sortDescriptors: [SortDescriptor<Object>] = []) {
        self.predicate = predicate
        self.sortDescriptors = sortDescriptors
    }
    
    // A Sudo SQL format of the predicate and sort descriptors.
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
