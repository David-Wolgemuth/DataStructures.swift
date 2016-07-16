//
//  Random.swift
//  DataStructures
//
//  Created by David Wolgemuth on 7/15/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

public class Random
{
    static public func int(from from: Int, to: Int) -> Int
    {
        if to < from {
            return from
        }
        let range = UInt32(to - from)
        return Int(arc4random_uniform(range)) + from
    }
    static public func letter() -> String
    {
        let ascii = Random.int(from: 97, to: 123)
        return String(UnicodeScalar(ascii))
    }
    static public func string(length: Int) -> String
    {
        var str: String = ""
        while str.characters.count < length {
            str += String(Random.letter())
        }
        return str
    }
}