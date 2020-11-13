//
//  PatrickTests.swift
//  PatrickTests
//
//  Created by Brandon Erbschloe on 10/5/20.
//

import XCTest
import Patrick

class PatrickTests: XCTestCase {

    class Person: NSObject {
        @objc var id: Int
        @objc var name: String?
        @objc var age: Int
        @objc var tags: [String] = []
        
        @objc var pet: Pet?
        
        init(id: Int = 0, name: String? = nil, age: Int = 0) {
            self.id = id
            self.name = name
            self.age = age
        }
    }
    
    class Pet: NSObject {
        @objc var name: String
        
        init(name: String) {
            self.name = name
        }
    }
    
    func testConstructors() {
        let predicate = Predicate<Person>(\.name, .equalTo, "Foo")
        XCTAssertEqual(predicate.format, "name == \"Foo\"")
        
        let sortDescriptor = SortDescriptor<Person>(\.name, ascending: true)
        XCTAssertEqual(sortDescriptor.format, "name ASC")
    }

    func testExample() {
        let predicate1: Predicate<Person> = not(or(equalTo(\.name, ""), lessThan(\.age, 10)))
        XCTAssertEqual(predicate1.format, "NOT (name == \"\" OR age < 10)")
        
        let predicate2: Predicate<Person> = !(\.name == "" || \.age < 10)
        XCTAssertEqual(predicate2.format, "NOT (name == \"\" OR age < 10)")
    }
    
    func testEqualTo() {
        let predicate1: Predicate<Person> = equalTo(\.id, 0)
        XCTAssertEqual(predicate1.format, "id == 0")
        
        let predicate2: Predicate<Person> = \.id == 0
        XCTAssertEqual(predicate2.format, "id == 0")
    }
    
    func testNotEqualTo() {
        let predicate1: Predicate<Person> = notEqualTo(\.id, 0)
        XCTAssertEqual(predicate1.format, "id != 0")
        
        let predicate2: Predicate<Person> = \.id != 0
        XCTAssertEqual(predicate2.format, "id != 0")
    }
    
    func testLessThan() {
        let predicate1: Predicate<Person> = lessThan(\.age, 10)
        XCTAssertEqual(predicate1.format, "age < 10")
        
        let predicate2: Predicate<Person> = \.age < 10
        XCTAssertEqual(predicate2.format, "age < 10")
    }
    
    func testLessThanOrEqualTo() {
        let predicate1: Predicate<Person> = lessThanOrEqualTo(\.age, 10)
        XCTAssertEqual(predicate1.format, "age <= 10")
        
        let predicate2: Predicate<Person> = \.age <= 10
        XCTAssertEqual(predicate2.format, "age <= 10")
    }
    
    func testGreaterThan() {
        let predicate1: Predicate<Person> = greaterThan(\.age, 10)
        XCTAssertEqual(predicate1.format, "age > 10")
        
        let predicate2: Predicate<Person> = \.age > 10
        XCTAssertEqual(predicate2.format, "age > 10")
    }
    
    func testGreaterThanOrEqualTo() {
        let predicate1: Predicate<Person> = greaterThanOrEqualTo(\.age, 10)
        XCTAssertEqual(predicate1.format, "age >= 10")
        
        let predicate2: Predicate<Person> = \.age >= 10
        XCTAssertEqual(predicate2.format, "age >= 10")
    }
    
    func testBeginsWith() {
        let predicate: Predicate<Person> = beginsWith(\.name, "Foo")
        XCTAssertEqual(predicate.format, "name BEGINSWITH \"Foo\"")
    }
    
    func testEndsWith() {
        let predicate: Predicate<Person> = endsWith(\.name, "Bar")
        XCTAssertEqual(predicate.format, "name ENDSWITH \"Bar\"")
    }
    
    func testIsLike() {
        let predicate1: Predicate<Person> = isLike(\.name, "F*")
        XCTAssertEqual(predicate1.format, "name LIKE \"F*\"")
        
        let predicate2: Predicate<Person> = \.name ~= "F*"
        XCTAssertEqual(predicate2.format, "name LIKE \"F*\"")
    }
    
    func testContains() {
        let predicate: Predicate<Person> = contains(\.tags, "yellow")
        XCTAssertEqual(predicate.format, "tags CONTAINS \"yellow\"")
    }
    
    func testInsideOf() {
        let predicate1: Predicate<Person> = insideOf(\.name, ["Foo", "Bar"])
        XCTAssertEqual(predicate1.format, "name IN {\"Foo\", \"Bar\"}")
        
        let predicate2: Predicate<Person> = \.name << ["Foo", "Bar"]
        XCTAssertEqual(predicate2.format, "name IN {\"Foo\", \"Bar\"}")
    }
    
    func testBetween() {
        let predicate: Predicate<Person> = between(\.age, 10...20)
        XCTAssertEqual(predicate.format, "age BETWEEN {10, 20}")
    }
    
    func testRelationship() {
        let predicate: Predicate<Person> = equalTo(\Person.pet?.name, "Fido")
        XCTAssertEqual(predicate.format, "pet.name == \"Fido\"")
    }
    
    func testStringPredicate() {
        let predicate: Predicate<Person> = Predicate("name", .equalTo, "Foo")
        XCTAssertEqual(predicate.format, "name == \"Foo\"")
    }
    
    func testNot() {
        let notPredicate1: Predicate<Person> = not(equalTo(\.name, ""))
        XCTAssertEqual(notPredicate1.format, "NOT name == \"\"")
        let notPredicate2: Predicate<Person> = !equalTo(\.name, "")
        XCTAssertEqual(notPredicate2.format, "NOT name == \"\"")
    }
    
    func testOr() {
        let orPredicate1: Predicate<Person> = or(equalTo(\.name, ""), equalTo(\.age, 0))
        XCTAssertEqual(orPredicate1.format, "name == \"\" OR age == 0")
        
        let orPredicate2: Predicate<Person> = equalTo(\.name, "") || greaterThan(\.age, 0)
        XCTAssertEqual(orPredicate2.format, "name == \"\" OR age > 0")
    }
    
    func testAnd() {
        let andPredicate1: Predicate<Person> = and(equalTo(\.name, ""), equalTo(\.age, 0))
        XCTAssertEqual(andPredicate1.format, "name == \"\" AND age == 0")
        
        let andPredicate2: Predicate<Person> = equalTo(\.name, "") && greaterThan(\.age, 0)
        XCTAssertEqual(andPredicate2.format, "name == \"\" AND age > 0")
    }
    
    func testSortedBy() {
        let sortDescriptor1: SortDescriptor<Person> = sortedBy(\.name, ascending: true)
        XCTAssertEqual(sortDescriptor1.format, "name ASC")
        
        let sortDescriptor2: SortDescriptor<Person> = sortedBy(\.age, ascending: false)
        XCTAssertEqual(sortDescriptor2.format, "age DESC")
    }
    
    func testStringSortedBy() {
        let sortDescriptor: SortDescriptor<Person> = sortedBy("name", ascending: true)
        XCTAssertEqual(sortDescriptor.format, "name ASC")
    }
}
