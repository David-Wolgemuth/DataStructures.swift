//
//  RandomTests.swift
//  DataStructures
//
//  Created by David Wolgemuth on 7/15/16.
//  Copyright © 2016 David. All rights reserved.
//

import XCTest
import Foundation
import DataStructures

class RandomTests: XCTestCase
{
    func testRange(from: Int, to: Int, times: Int)
    {
        var marked = [Int:Bool]()
        for _ in 0..<times {
            let int = Random.int(from: from, to: to)
            XCTAssertLessThanOrEqual(from, int)
            XCTAssertGreaterThan(to, int)
            marked[int] = true
        }
        for int in from..<to {
            XCTAssertNotNil(marked[int])
        }
    }
    func testRandomIntWithinRange()
    {
        testRange(0, to: 4, times: 64)
        testRange(-2, to: 2, times: 64)
        testRange(-8, to: -4, times: 64)
    }
    func testRandomCharacter()
    {
        var alphabet = Set<String>()
        var infinity = 10000
        while alphabet.count < 26 && infinity >= 0 {
            alphabet.insert(Random.letter())
            infinity -= 1
        }
        XCTAssertTrue(alphabet.contains("a"))
        XCTAssertTrue(alphabet.contains("m"))
        XCTAssertTrue(alphabet.contains("z"))
        XCTAssertGreaterThan(infinity, 0)
    }
    func testRandomString()
    {
        for _ in 0..<64 {
            let length = Random.int(from: 0, to: 128)
            let str = Random.string(length)
            XCTAssertEqual(str.characters.count, length)
        }
    }
}
