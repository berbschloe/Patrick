//
//  Predicate.swift
//  Patrick
//
//  Created by Brandon Erbschloe on 10/5/20.
//

import Foundation

public struct Predicate<Object: NSObjectProtocol>: CustomStringConvertible {
    
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
        
        internal var `operator`: NSComparisonPredicate.Operator {
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
    
    public let predicate: NSPredicate
    
    init(_ predicate: NSPredicate) {
        self.predicate = predicate
    }
    
    var format: String {
        return predicate.predicateFormat
    }
    
    public var description: String {
        return format
    }
}

public func predicate<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ type: Predicate<Root>.Operator,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return Predicate(NSComparisonPredicate(
        leftExpression: NSExpression(forKeyPath: keyPath),
        rightExpression: NSExpression(forConstantValue: value),
        modifier: modifier,
        type: type.operator,
        options: options
    ))
}

func equalTo<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return predicate(keyPath, .equalTo, value)
}

func == <Root, Value>(lhs: KeyPath<Root, Value>, rhs: Value) -> Predicate<Root> {
    return equalTo(lhs, rhs)
}

func notEqualTo<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return predicate(keyPath, .notEqualTo, value)
}

func != <Root, Value>(lhs: KeyPath<Root, Value>, rhs: Value) -> Predicate<Root> {
    return notEqualTo(lhs, rhs)
}

func lessThan<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return predicate(keyPath, .lessThan, value)
}

func < <Root, Value>(lhs: KeyPath<Root, Value>, rhs: Value) -> Predicate<Root> {
    return lessThan(lhs, rhs)
}

func lessThanOrEqualTo<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return predicate(keyPath, .lessThanOrEqualTo, value)
}

func <= <Root, Value>(lhs: KeyPath<Root, Value>, rhs: Value) -> Predicate<Root> {
    return lessThanOrEqualTo(lhs, rhs)
}

func greaterThan<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return predicate(keyPath, .greaterThan, value)
}

func > <Root, Value>(lhs: KeyPath<Root, Value>, rhs: Value) -> Predicate<Root> {
    return greaterThan(lhs, rhs)
}

func greaterThanOrEqualTo<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return predicate(keyPath, .greaterThanOrEqualTo, value)
}

func >= <Root, Value>(lhs: KeyPath<Root, Value>, rhs: Value) -> Predicate<Root> {
    return greaterThanOrEqualTo(lhs, rhs)
}

func beginsWith<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return predicate(keyPath, .beginsWith, value)
}

func endsWith<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return predicate(keyPath, .endsWith, value)
}

func isLike<Root, Value>(
    _ keyPath: KeyPath<Root, Value>,
    _ value: Value,
    modifier: NSComparisonPredicate.Modifier = .direct,
    options: NSComparisonPredicate.Options = []
) -> Predicate<Root> {
    return predicate(keyPath, .like, value)
}

func ~= <Root, Value>(lhs: KeyPath<Root, Value>, rhs: Value) -> Predicate<Root> {
    return isLike(lhs, rhs)
}

func contains<Root, Value>(
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

func insideOf<Root, Value>(
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

func << <Root, Value>(lhs: KeyPath<Root, Value.Element>, rhs: Value) -> Predicate<Root> where Value: Sequence {
    return insideOf(lhs, rhs)
}

func between<Root, Value>(
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
