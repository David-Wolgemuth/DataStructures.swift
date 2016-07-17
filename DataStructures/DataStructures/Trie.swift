//
//  Trie.swift
//  DataStructures
//
//  Created by David Wolgemuth on 7/16/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

public class Trie<Element>
{
    private var root = Node<Element>(letter: Character(" "))
    
    public init()
    {
        
    }
    public static func alphaCompareString(strA: String, LessThanOrEqualToString strB: String) -> Bool
    {
        let charsA: [Character] = Array(strA.characters)
        let charsB: [Character] = Array(strB.characters)
        
        var i = 0
        while i < charsA.count && i < charsB.count {
            if charsA[i] < charsB[i] {
                return true
            }
            if charsA[i] > charsB[i] {
                return false
            }
            i += 1
        }
        return charsA.count <= charsB.count
    }
    public func upsert(key key: String, withValue value: Element)
    {
        let letters: [Character] = Array(key.characters)
        if letters.count == 0 {
            return
        }
        let node = root.findChildAtKey(letters, upsert: true)!
        node.keyValuePair = KVP(key: key, value: value)
    }
    public func valueAtKey(key: String) -> Element?
    {
        let letters: [Character] = Array(key.characters)
        if letters.count == 0 {
            return nil
        }
        if let node = root.findChildAtKey(letters) {
            return node.keyValuePair?.value
        }
        return nil
    }
    public func isEmpty() -> Bool
    {
        return root.children.count == 0
    }
    public func first() -> KVP<Element>?
    {
        if isEmpty() {
            return nil
        }
        var node = root
        while node.children.count > 0 && node.keyValuePair == nil {
            node = node.children[0]
        }
        return node.keyValuePair
    }
    public func getKeys() -> [String]
    {
        var keys = [String]()
        getKeys(fromNode: root, addToKeys: &keys)
        return keys
    }
    public func keyExistsBeginningWithString(string: String) -> Bool
    {
        let letters: [Character] = Array(string.characters)
        var found: [KVP<Element>] = []
        root.findAllChildrenStartingWithKey(letters, foundChildren: &found)
        return found.count > 0
    }
    public func allKVPsBeginningWithString(string: String) -> [KVP<Element>]
    {
        let letters: [Character] = Array(string.characters)
        var found: [KVP<Element>] = []
        root.findAllChildrenStartingWithKey(letters, foundChildren: &found)
        return found
    }
    private func getKeys(fromNode node: Node<Element>, existingKey key: String="", inout addToKeys keys: [String])
    {
        var key = key
        if key != "" || node.letter != " " {
            key = key + String(node.letter)
        }
        if node.keyValuePair != nil {
            keys.append(key)
        }
        for child in node.children {
            getKeys(fromNode: child, existingKey: key, addToKeys: &keys)
        }
    }
}

private class Node<Element>
{
    let letter: Character
    var keyValuePair: KVP<Element>?
    var children = [Node<Element>]()

    init(letter: Character, kvp: KVP<Element>?=nil)
    {
        self.letter = letter
        self.keyValuePair = kvp
    }
    func findChildAtKey(key: [Character], index: Int=(-1), upsert: Bool=false) -> Node<Element>?
    {
        if index >= key.count {
            return nil
        }
        if index == key.count-1 && index >= 0 {
            return key[index] == letter ? self : nil
        }
        let index = index + 1
        for child in children {
            if child.letter == key[index] {
                return child.findChildAtKey(key, index: index, upsert: upsert)
            }
        }
        if upsert {
            let child = Node<Element>(letter: key[index])
            addChildSorted(child)
            return child.findChildAtKey(key, index: index, upsert: upsert)
        }
        return nil
    }
    func findAllChildrenStartingWithKey(key: [Character], index: Int=(-1), inout foundChildren found: [KVP<Element>])
    {
        if index != -1 {
            if index < key.count-1 {
                if key[index] != letter {
                    return
                }
            } else if index >= key.count || key[index] == letter {
                if let kvp = keyValuePair {
                    found.append(kvp)
                }
            } else {
                return
            }
        }
        for child in children {
            child.findAllChildrenStartingWithKey(key, index: index + 1, foundChildren: &found)
        }
    }
    func addChildSorted(child: Node<Element>)
    {
        children.append(child)
        var i = children.count-2
        while i >= 0 && child.letter < children[i].letter {
            children[i+1] = children[i]
            i -= 1
        }
        children[i+1] = child
    }
}
