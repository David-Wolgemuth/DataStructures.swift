//
//  SLListKeyedSetTests.swift
//  DataStructures
//
//  Created by David Wolgemuth on 7/15/16.
//  Copyright © 2016 David. All rights reserved.
//

import XCTest
import DataStructures

class SLListKeyedSetTests: XCTestCase {
    var list: SLListKeyedSet<Int>!
    override func setUp() {
        super.setUp()
        list = SLListKeyedSet<Int>()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testUpsertValueAffectsCount()
    {
        XCTAssertEqual(list.count(), 0)
        list.upsert("one", withValue: 1)
        list.upsert("two", withValue: 2)
        list.upsert("three", withValue: 3)
        XCTAssertEqual(list.count(), 3)
    }
    func testUpsertInsertsOrUpdatesIfAlreadyExistsAndReturnsPosition()
    {
        var x = 24, y = 36, z = 48
        for _ in 0..<24 {
            if x == 24 {
                XCTAssertTrue(list.upsert("x", withValue: x))
                XCTAssertTrue(list.upsert("y", withValue: y))
                XCTAssertTrue(list.upsert("z", withValue: z))
            } else {
                XCTAssertFalse(list.upsert("x", withValue: x))
                XCTAssertFalse(list.upsert("y", withValue: y))
                XCTAssertFalse(list.upsert("z", withValue: z))
            }
            XCTAssertEqual(x, list.value(atKey: "x"))
            XCTAssertEqual(y, list.value(atKey: "y"))
            XCTAssertEqual(z, list.value(atKey: "z"))
            XCTAssertEqual(list.count(), 3)
            x += 1; y += 1; z += 1
        }
    }
    func testRemoveValueAtKey()
    {
        for value in 0..<360 {
            let key = String(value)
            list.upsert(key, withValue: value)
        }
        for value in 0..<360 {
            let key = String(value)
            XCTAssertEqual(value, list.value(atKey: key))
            list.removeValue(atKey: key)
            XCTAssertNil(list.value(atKey: key))
        }
    }
    func testLengthIncrementsAppropriately()
    {
        for value in 0..<360 {  // Good Insertions
            let key = String(value)
            XCTAssertEqual(value, list.length)
            list.upsert(key, withValue: value)
        }
        for value in 0..<360 {  // Duplicates
            let key = String(value)
            XCTAssertEqual(360, list.length)
            list.upsert(key, withValue: value)
        }
        for value in 0..<360 {  // Removals
            let key = String(value)
            XCTAssertEqual(360 - value, list.length)
            list.removeValue(atKey: key)
        }
    }
    
    
    
    
    
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
