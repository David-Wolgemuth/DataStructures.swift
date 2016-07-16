//
//  HashTable.swift
//  DataStructures
//
//  Created by David Wolgemuth on 7/14/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

public class HashTable<Element>
{
    private var table: [SLListKeyedSet<Element>?]
    private let loadFactor: Double
    private var capacity: Int
    private var _count: Int = 0
    
    public var count: Int { get { return _count } }
    public var tableSize: Int { get { return table.count }}
    
    public init(initialCapacity: Int = 64, loadFactor: Double = 0.75)
    {
        self.loadFactor = loadFactor
        self.capacity = initialCapacity
        table = [SLListKeyedSet<Element>?](count: initialCapacity, repeatedValue: nil)
    }
    public func setValueAtKey(key: String, to value: Element)
    {
        let idx = toHash(key)
        let list: SLListKeyedSet<Element>
        if table[idx] != nil {
            list = table[idx]!
        } else {
            list = SLListKeyedSet()
            table[idx] = list
        }
        if list.upsert(key, withValue: value) {
            _count += 1
            if shouldResize() {
                resize()
            }
        }
    }
    public func valueAtKey(key: String) -> Element?
    {
        let idx = toHash(key)
        if let list = table[idx] {
            return list.value(atKey: key)
        }
        return nil
    }
    public func removeValueAtKey(key: String)
    {
        let idx = toHash(key)
        if let list = table[idx] {
            if list.removeValue(atKey: key) {
                _count -= 1
            }
        }
    }
    public func keyValuePairs() -> [KVP<Element>]
    {
        var keys = [KVP<Element>]()
        for list in table {
            if list == nil {
                continue
            }
            for pair in list!.toArray() {
                keys.append(pair)
            }
        }
        return keys
    }
    private func shouldResize() -> Bool
    {
        if Double(count) >= loadFactor * Double(capacity) {
            print("")
        }
        return Double(count) >= loadFactor * Double(capacity)
    }
    private func resize()
    {
        capacity *= 3
        capacity /= 2
        let pairs = keyValuePairs()
        _count = 0
        table = [SLListKeyedSet<Element>?](count: capacity, repeatedValue: nil)
        for pair in pairs {
            setValueAtKey(pair.key, to: pair.value)
        }
    }
    private func toHash(string: String) -> Int
    {
        return abs(string.hashValue) % table.count
    }
}
