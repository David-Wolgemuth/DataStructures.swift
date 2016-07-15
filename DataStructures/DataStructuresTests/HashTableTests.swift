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
    func hashTableExists()
    {
        let ht = HashTable()
        XCTAssertNotNil(ht)
    }
}
