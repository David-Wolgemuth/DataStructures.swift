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
    public func upsertKey(key: String, withValue value: Element)
    {
        let letters: [Character] = Array(key.characters)
        if letters.count == 0 {
            return
        }
        let node = root.findChildAtKey(letters, index: -1, upsert: true)!
        node.value = value
    }
    public func valueAtKey(key: String) -> Element?
    {
        let letters: [Character] = Array(key.characters)
        if letters.count == 0 {
            return nil
        }
        if let node = root.findChildAtKey(letters, index: -1, upsert: false) {
            return node.value
        }
        return nil
    }
}

private class Node<Element>
{
    let letter: Character
    var value: Element?
    var children = [Node<Element>]()
    
    init(letter: Character, value: Element?=nil)
    {
        self.letter = letter
        self.value = value
    }
    func findChildAtKey(key: [Character], index: Int, upsert: Bool) -> Node<Element>?
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
            children.append(child)
            return child.findChildAtKey(key, index: index, upsert: upsert)
        }
        return nil
    }
}
