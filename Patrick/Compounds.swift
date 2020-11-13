//
//  Compounds.swift
//  Patrick
//
//  Created by Brandon Erbschloe on 10/5/20.
//

import Foundation

/// Returns an AND predicate from the given predicates.
public func and<Object>(_ predicates: [Predicate<Object>]) -> Predicate<Object> {
    return Predicate<Object>(NSCompoundPredicate(andPredicateWithSubpredicates: predicates.map(\.raw)))
}

/// Returns an AND predicate from the given predicates.
public func and<Object>(_ p1: Predicate<Object>, _ p2: Predicate<Object>, _ otherPredicates: Predicate<Object>...) -> Predicate<Object> {
    return and([p1, p2] + otherPredicates)
}

/// Returns an AND predicate from the given predicates.
public func && <Object>(lhs: Predicate<Object>, rhs: Predicate<Object>) -> Predicate<Object> {
    return and([lhs, rhs])
}

/// Returns an OR predicate from the given predicates.
public func or<Object>(_ predicates: [Predicate<Object>]) -> Predicate<Object> {
    return Predicate<Object>(NSCompoundPredicate(orPredicateWithSubpredicates: predicates.map(\.raw)))
}

/// Returns an OR predicate from the given predicates.
public func or<Object>(_ p1: Predicate<Object>, _ p2: Predicate<Object>, _ otherPredicates: Predicate<Object>...) -> Predicate<Object> {
    return or([p1, p2] + otherPredicates)
}

/// Returns an OR predicate from the given predicates.
public func || <Object>(lhs: Predicate<Object>, rhs: Predicate<Object>) -> Predicate<Object> {
    return or([lhs, rhs])
}

/// Returns a negated predicate from the given predicate.
public func not<Object>(_ predicate: Predicate<Object>) -> Predicate<Object> {
    return Predicate<Object>(NSCompoundPredicate(notPredicateWithSubpredicate: predicate.raw))
}

/// Returns a negated predicate from the given predicate.
prefix public func ! <Object>(rhs: Predicate<Object>) -> Predicate<Object> {
    return not(rhs)
}
