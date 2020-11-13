//
//  Predicate.swift
//  Patrick
//
//  Created by Brandon Erbschloe on 10/5/20.
//

import Foundation

/// A typesafe representation of a NSComparisonPredicate.
public struct Predicate<Object: NSObjectProtocol>: CustomStringConvertible {
    
    /// Defines the type of comparison
    public enum Operator {
        case equalTo
        case notEqualTo
        case lessThan
        case lessThanOrEqualTo
        case greaterThan
        case greaterThanOrEqualTo
        case beginsWith
        case endsWith
        case like
        case between
        
        /// The  raw operator.
        public var raw: NSComparisonPredicate.Operator {
            switch self {
            case .equalTo: return .equalTo
            case .notEqualTo: return .notEqualTo
            case .lessThan: return .lessThan
            case .lessThanOrEqualTo: return .lessThanOrEqualTo
            case .greaterThan: return .greaterThan
            case .greaterThanOrEqualTo: return .greaterThanOrEqualTo
            case .beginsWith: return .beginsWith
            case .endsWith: return .endsWith
            case .like: return .like
            case .between: return .between
            }
        }
    }
    
    // The raw predicate.
    public let raw: NSPredicate
    
    public init(_ predicate: NSPredicate) {
        self.raw = predicate
    }
    
    public init<Value>(
        _ keyPath: KeyPath<Object, Value>,
        _ type: Predicate<Object>.Operator,
        _ value: Value,
        modifier: NSComparisonPredicate.Modifier = .direct,
        options: NSComparisonPredicate.Options = []
    ) {
        self.raw = NSComparisonPredicate(
            leftExpression: NSExpression(forKeyPath: keyPath),
            rightExpression: NSExpression(forConstantValue: value),
            modifier: modifier,
            type: type.raw,
            options: options
        )
    }
    
    public init<Value>(
        _ keyPath: String,
        _ type: Predicate<Object>.Operator,
        _ value: Value,
        modifier: NSComparisonPredicate.Modifier = .direct,
        options: NSComparisonPredicate.Options = []
    ) {
        self.raw = NSComparisonPredicate(
            leftExpression: NSExpression(forKeyPath: keyPath),
            rightExpression: NSExpression(forConstantValue: value),
            modifier: modifier,
            type: type.raw,
            options: options
        )
    }
    
    /// The predicate's format string.
    public var format: String {
        return raw.predicateFormat
    }
    
    public var description: String {
        return format
    }
}

public func equalTo<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return Predicate(keyPath, .equalTo, value)
}

public func == <Root, Value>(lhs: KeyPath<Root, Value>, rhs: Value) -> Predicate<Root> {
    return equalTo(lhs, rhs)
}

public func notEqualTo<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return Predicate(keyPath, .notEqualTo, value)
}

public func != <Root, Value>(lhs: KeyPath<Root, Value>, rhs: Value) -> Predicate<Root> {
    return notEqualTo(lhs, rhs)
}

public func lessThan<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return Predicate(keyPath, .lessThan, value)
}

public func < <Root, Value>(lhs: KeyPath<Root, Value>, rhs: Value) -> Predicate<Root> {
    return lessThan(lhs, rhs)
}

public func lessThanOrEqualTo<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return Predicate(keyPath, .lessThanOrEqualTo, value)
}

public func <= <Root, Value>(lhs: KeyPath<Root, Value>, rhs: Value) -> Predicate<Root> {
    return lessThanOrEqualTo(lhs, rhs)
}

public func greaterThan<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return Predicate(keyPath, .greaterThan, value)
}

public func > <Root, Value>(lhs: KeyPath<Root, Value>, rhs: Value) -> Predicate<Root> {
    return greaterThan(lhs, rhs)
}

public func greaterThanOrEqualTo<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return Predicate(keyPath, .greaterThanOrEqualTo, value)
}

public func >= <Root, Value>(lhs: KeyPath<Root, Value>, rhs: Value) -> Predicate<Root> {
    return greaterThanOrEqualTo(lhs, rhs)
}

public func beginsWith<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return Predicate(keyPath, .beginsWith, value)
}

public func endsWith<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return Predicate(keyPath, .endsWith, value)
}

public func isLike<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return Predicate(keyPath, .like, value)
}

public func ~= <Root, Value>(lhs: KeyPath<Root, Value>, rhs: Value) -> Predicate<Root> {
    return isLike(lhs, rhs)
}

public func contains<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value.Element,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> where Value: Sequence {
    return Predicate(NSComparisonPredicate(
        leftExpression: NSExpression(forKeyPath: keyPath),
        rightExpression: NSExpression(forConstantValue: value),
        modifier: modifier,
        type: .contains,
        options: options
    ))
}

public func insideOf<Root, Value>(
    _ keyPath: KeyPath<Root, Value.Element>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> where Value: Sequence {
    return Predicate(NSComparisonPredicate(
        leftExpression: NSExpression(forKeyPath: keyPath),
        rightExpression: NSExpression(forConstantValue: value),
        modifier: modifier,
        type: .in,
        options: options
    ))
}

public func << <Root, Value>(lhs: KeyPath<Root, Value.Element>, rhs: Value) -> Predicate<Root> where Value: Sequence {
    return insideOf(lhs, rhs)
}

public func between<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: ClosedRange<Value>,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return Predicate(NSComparisonPredicate(
        leftExpression: NSExpression(forKeyPath: keyPath),
        rightExpression: NSExpression(forConstantValue: [value.lowerBound, value.upperBound]),
        modifier: modifier,
        type: .between,
        options: options
    ))
}
