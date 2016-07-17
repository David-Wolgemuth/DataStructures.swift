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
            trie.upsert(key: pair.key, withValue: pair.value)
            if pair.key.characters.count > 0 {
                XCTAssertEqual(trie.valueAtKey(pair.key), pair.value)
            } else {
                XCTAssertEqual(trie.valueAtKey(pair.key), nil)
            }
        }
    }
    func testUpdatesIfExistingKey()
    {
        for pair in pairs {
            trie.upsert(key: pair.key, withValue: pair.value)
        }
        for pair in pairs {
            if pair.key.characters.count == 0 {
                continue
            }
            trie.upsert(key: pair.key, withValue: pair.value * -1)
            XCTAssertEqual(trie.valueAtKey(pair.key), pair.value * -1)
        }
    }
    func testAlphaCompareStrings()
    {
        // First Should Be Less Than Or Equal To Second
        let words: [(String, String)] = [
            ("a", "b"), ("ardvark", "arevark"), ("ar", "art"), ("aaa", "bbb"),
            ("apple", "apple"), ("crown", "crowo"), ("fries", "gries"), ("apple", "apples")
        ]
        for word in words {
            let T = Trie<Int>.alphaCompareString(word.0, LessThanOrEqualToString: word.1)
            XCTAssertTrue(T, "\(word.0) < \(word.1)")
            if word.0 == word.1 {
                continue
            }
            let F = Trie<Int>.alphaCompareString(word.1, LessThanOrEqualToString: word.0)
            XCTAssertFalse(F, "\(word.1) < \(word.1) (should be false)")
        }
    }
    func testGetKeysInOrder()
    {
        for pair in pairs {
            trie.upsert(key: pair.key, withValue: pair.value)
        }
        let keys = trie.getKeys()
        for i in 0..<keys.count-1 {
            let lessThan = Trie<Int>.alphaCompareString(keys[i], LessThanOrEqualToString: keys[i+1])
            XCTAssertTrue(lessThan, "\"\(keys[i])\" < \"\(keys[i+1])\"")
        }
    }
    func testGetFirstElement()
    {
        for pair in pairs {
            trie.upsert(key: pair.key, withValue: pair.value)
        }
        let keys = trie.getKeys()
        for i in 0..<keys.count {
            let firstKey = keys[i]
            if let value = trie.valueAtKey(firstKey) {
                XCTAssertEqual(firstKey, trie.first()?.key)
                XCTAssertEqual(value, trie.first()?.value)
                return
            }
        }
    }
    func testKeyExistsBeginningWithString()
    {
        var set = Set<String>()
        for pair in pairs {
            if !set.contains(pair.key) {
                set.insert(pair.key)
                trie.upsert(key: pair.key, withValue: pair.value)
            }
        }
        for pair in pairs {
            let characters: [Character] = Array(pair.key.characters)
            if characters.count != 0 {
                trie.upsert(key: String(characters[0]), withValue: 24)
                let val = trie.valueAtKey(String(characters[0]))
                XCTAssertEqual(val, 24)
            }
            var str = ""
            for char in characters {
                str += String(char)
                XCTAssertTrue(trie.keyExistsBeginningWithString(str))
                let kvps = trie.allKVPsBeginningWithString(str)
                var contains = false
                for kvp in kvps {
                    if kvp.key == pair.key {
                        contains = true; break
                    }
                }
                XCTAssertTrue(contains)
            }
            var infinity = 10000
            var willReject = false
            while !willReject || infinity == 0 {
                str = Random.string(3)
                if !trie.keyExistsBeginningWithString(str) && trie.allKVPsBeginningWithString(str).count == 0 {
                    willReject = true
                }
                infinity -= 1
            }
            XCTAssertTrue(willReject)
        }
    }
}
