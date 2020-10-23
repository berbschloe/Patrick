//
//  Compounds.swift
//  Patrick
//
//  Created by Brandon Erbschloe on 10/5/20.
//

import Foundation

public func and<Object>(_ predicates: [Predicate<Object>]) -> Predicate<Object> {
    return Predicate<Object>(NSCompoundPredicate(andPredicateWithSubpredicates: predicates.map(\.raw)))
}

public func and<Object>(_ p1: Predicate<Object>, _ p2: Predicate<Object>, _ otherPredicates: Predicate<Object>...) -> Predicate<Object> {
    return and([p1, p2] + otherPredicates)
}

public func && <Object>(lhs: Predicate<Object>, rhs: Predicate<Object>) -> Predicate<Object> {
    return and([lhs, rhs])
}

public func or<Object>(_ predicates: [Predicate<Object>]) -> Predicate<Object> {
    return Predicate<Object>(NSCompoundPredicate(orPredicateWithSubpredicates: predicates.map(\.raw)))
}

public func or<Object>(_ p1: Predicate<Object>, _ p2: Predicate<Object>, _ otherPredicates: Predicate<Object>...) -> Predicate<Object> {
    return or([p1, p2] + otherPredicates)
}

public func || <Object>(lhs: Predicate<Object>, rhs: Predicate<Object>) -> Predicate<Object> {
    return or([lhs, rhs])
}

public func not<Object>(_ predicate: Predicate<Object>) -> Predicate<Object> {
    return Predicate<Object>(NSCompoundPredicate(notPredicateWithSubpredicate: predicate.raw))
}

prefix public func ! <Object>(rhs: Predicate<Object>) -> Predicate<Object> {
    return not(rhs)
}
