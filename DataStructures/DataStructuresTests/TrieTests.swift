//
//  TrieTests.swift
//  DataStructures
//
//  Created by David Wolgemuth on 7/16/16.
//  Copyright © 2016 David. All rights reserved.
//

import XCTest
import Foundation
import DataStructures

class TrieTests: XCTestCase
{
    var trie = Trie<Int>()
    var pairs = [KVP<Int>]()
    override func setUp()
    {
        super.setUp()
        trie = Trie()
        pairs = []
        for _ in 0..<512 {
            let len = Random.int(from: -4, to: 24)
            let key = Random.string(len)
            let value = Random.int(from: -128, to: 128)
            pairs.append(KVP<Int>(key: key, value: value))
        }
    }
    func testInsertionAndRetrieval()
    {
        for pair in pairs {
            trie.upsertKey(pair.key, withValue: pair.value)
            if pair.key.characters.count > 0 {
                XCTAssertEqual(trie.valueAtKey(pair.key), pair.value)
            } else {
                XCTAssertEqual(trie.valueAtKey(pair.key), nil)
            }
        }
    }
}
