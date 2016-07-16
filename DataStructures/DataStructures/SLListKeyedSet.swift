//
//  SinglyLinkedList.swift
//  DataStructures
//
//  Created by David Wolgemuth on 7/15/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

public class SLListKeyedSet<Element>
{
    private var head: Node<Element>? = nil
    private var _length: Int = 0
    public var length: Int { get { return _length } }
    public init()
    {
    
    }
    public func upsert(key: String, withValue value: Element) -> Bool
    {
        if head == nil {
            head = Node(key: key, value: value)
            _length += 1
            return true
        }
        var node = head
        while let next = node!.next {
            if node!.key == key {
                node!.value = value
                return false
            }
            node = next
        }
        if node?.key == key {
            node?.value = value
            return false
        }
        node!.next = Node(key: key, value: value)
        _length += 1
        return true
    }
    public func value(atKey key: String) -> Element?
    {
        var node = head
        while node != nil {
            if node?.key == key {
                return node?.value
            }
            node = node?.next
        }
        return nil
    }
    public func removeValue(atKey key: String) -> Bool
    {
        if isEmpty() {
            return false
        }
        if head?.key == key {
            head = head?.next
            _length -= 1
            return true
        }
        var node = head
        while let next = node?.next {
            if next.key == key {
                node!.next = next.next
                _length -= 1
                return true
            }
            node = next
        }
        return false
    }
    public func toArray() -> [KVP<Element>]
    {
        var pairs = [KVP<Element>]()
        var node = head
        while node != nil {
            pairs.append(KVP(key: node!.key, value: node!.value))
            node = node?.next
        }
        return pairs
    }
    public func count() -> Int
    {
        var node = head
        var count = 0
        while node != nil {
            count += 1
            node = node?.next
        }
        return count
    }
    private func isEmpty() -> Bool
    {
        return head == nil
    }
}
private class Node<Element>
{
    let key: String
    var value: Element
    var next: Node<Element>?
    init(key: String, value: Element)
    {
        self.key = key
        self.value = value
    }
}