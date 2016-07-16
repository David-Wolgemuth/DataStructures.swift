//
//  HashTable Tests.swift
//  DataStructures
//
//  Created by David Wolgemuth on 7/14/16.
//  Copyright © 2016 David. All rights reserved.
//

import XCTest
import Foundation
import DataStructures

class HashTableTests: XCTestCase
{
    var ht = HashTable<Int>()
    override func setUp()
    {
        super.setUp()
        ht = HashTable<Int>()
    }
    func testSetAndRetrieveValues()
    {
        var x = 24, y = 36, z = 48
        for _ in 0..<24 {
            x += 1; y += 1; z += 1
            ht.setValueAtKey("x", to: x)
            ht.setValueAtKey("y", to: y)
            ht.setValueAtKey("z", to: z)
            XCTAssertEqual(x, ht.valueAtKey("x"))
            XCTAssertEqual(y, ht.valueAtKey("y"))
            XCTAssertEqual(z, ht.valueAtKey("z"))
        }
    }
    func testTableHandlesCollisions()
    {
        for value in 0..<2400 {
            let key = String(value)
            ht.setValueAtKey(key, to: value)
        }
        for value in 0..<2400 {
            let key = String(value)
            XCTAssertEqual(value, ht.valueAtKey(key))
        }
    }
    func testRemoveValueAtKey()
    {
        for value in 0..<640 {
            let key = String(value)
            ht.setValueAtKey(key, to: value)
        }
        for value in 0..<640 {
            let key = String(value)
            XCTAssertEqual(value, ht.valueAtKey(key))
            ht.removeValueAtKey(key)
            XCTAssertNil(ht.valueAtKey(key))
        }
    }
    func testGetAllKeys()
    {
        var pairs = [(key: String, value: Int)]()
        for value in 0..<240 {
            let key = String(value)
            ht.setValueAtKey(key, to: value)
            pairs.append((key: key, value: value))
        }
        let pairs2 = ht.keyValuePairs()
        XCTAssertEqual(pairs.count, pairs2.count)
        for pair in pairs2 {
            XCTAssertTrue(pairs.contains { $0.key == pair.key && $0.value == pair.value } )
        }
    }
    func testCountUpdatesUponInsertionAndDeletion()
    {
        for value in 0..<640 {  // Good Insertions
            let key = String(value)
            XCTAssertEqual(value, ht.count)
            ht.setValueAtKey(key, to: value)
        }
        for value in 0..<640 {  // Duplicates
            let key = String(value)
            XCTAssertEqual(640, ht.count)
            ht.setValueAtKey(key, to: value)
        }
        for value in 0..<640 {  // Removals
            let key = String(value)
            XCTAssertEqual(640 - value, ht.count)
            ht.removeValueAtKey(key)
        }
    }
    func testTableSizeIncreasesAccordingToLoadFactor()
    {
        let ic = 64
        let lf = 0.75
        ht = HashTable(initialCapacity: ic, loadFactor: lf)
        for value in 0..<ic {
            let key = String(value)
            ht.setValueAtKey(key, to: value)
            if value > Int(Double(ic) * lf) {
                XCTAssertEqual(ht.tableSize, Int(Double(ic) * 1.5))
            }
        }
    }
}
