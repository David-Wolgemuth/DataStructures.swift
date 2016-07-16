//
//  Pair.swift
//  DataStructures
//
//  Created by David Wolgemuth on 7/16/16.
//  Copyright © 2016 David. All rights reserved.
//

import Foundation

public struct KVP<Element>
{
    public let key: String
    public let value: Element
    public init(key: String, value: Element)
    {
        self.key = key
        self.value = value
    }
}