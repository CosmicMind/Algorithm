/*
 * The MIT License (MIT)
 *
 * Copyright (C) 2019, CosmicMind, Inc. <http://cosmicmind.com>.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import XCTest
@testable import Algorithm

class SortedDictionaryTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testInt() {
    var s = SortedDictionary<Int, Int>()
    
    XCTAssert(0 == s.count, "Test failed, got \(s.count).")
    
    for _ in 0..<1000 {
      s.insert((1, 1))
      s.insert((2, 2))
      s.insert((3, 3))
    }
    
    XCTAssert(3 == s.count, "Test failed.")
    XCTAssert(1 == s[0].value, "Test failed.")
    XCTAssert(2 == s[1].value, "Test failed.")
    XCTAssert(3 == s[2].value, "Test failed.")
    
    for _ in 0..<500 {
      s.removeValue(for: 1)
      s.removeValue(for: 3)
    }
    
    XCTAssert(1 == s.count, "Test failed.")
    s.removeValue(for: 2)
    
    s.insert((2, 10))
    XCTAssert(1 == s.count, "Test failed.")
    XCTAssert(10 == s.findValue(for: 2), "Test failed.")
    XCTAssert(10 == s[0].value!, "Test failed.")
    
    s.removeValue(for: 2)
    XCTAssert(0 == s.count, "Test failed.")
    
    s.insert((1, 1))
    s.insert((2, 2))
    s.insert((3, 3))
    s.insert((3, 3))
    s.update(value: 5, for: 3)
    
    let subs: SortedDictionary<Int, Int> = s.search(for: 3)
    XCTAssert(1 == subs.count, "Test failed.")
    
    let generator = subs.makeIterator()
    while let x = generator.next() {
      XCTAssert(5 == x.value, "Test failed.")
    }
    
    for i in 0..<s.endIndex {
      s[i] = (s[i].key, 100)
      XCTAssert(100 == s[i].value, "Test failed.")
    }
    
    s.removeAll()
    XCTAssert(0 == s.count, "Test failed.")
  }
  
  func testIndexOf() {
    var d1 = SortedDictionary<Int, Int>()
    d1.insert(value: 1, for: 1)
    d1.insert(value: 2, for: 2)
    d1.insert(value: 3, for: 3)
    d1.insert(value: 4, for: 4)
    d1.insert(value: 5, for: 5)
    d1.insert(value: 5, for: 5)
    d1.insert(value: 6, for: 6)
    
    XCTAssert(0 == d1.index(of: 1), "Test failed.")
    XCTAssert(5 == d1.index(of: 6), "Test failed.")
    XCTAssert(-1 == d1.index(of: 100), "Test failed.")
  }
  
  func testKeys() {
    let s = SortedDictionary<String, Int>(elements: ("adam", 1), ("daniel", 2), ("mike", 3), ("natalie", 4))
    XCTAssert(["adam", "daniel", "mike", "natalie"] == s.keys, "Test failed.")
  }
  
  func testValues() {
    let s = SortedDictionary<String, Int>(elements: ("adam", 1), ("daniel", 2), ("mike", 3), ("natalie", 4))
    let values = [1, 2, 3, 4]
    XCTAssert(values == s.values, "Test failed.")
  }
  
  func testLowerEntry() {
    let s = SortedDictionary<Int, Int>(elements: (1, 1), (2, 2), (3, 3), (5, 5), (8, 8), (13, 13), (21, 21), (34, 34))
    
    XCTAssert(s.findLowerEntry(for: -15) == nil, "Test failed.")
    XCTAssert(s.findLowerEntry(for: 0) == nil, "Test failed.")
    XCTAssert(s.findLowerEntry(for: 1) == 1, "Test failed.")
    XCTAssert(s.findLowerEntry(for: 2) == 2, "Test failed.")
    XCTAssert(s.findLowerEntry(for: 3) == 3, "Test failed.")
    XCTAssert(s.findLowerEntry(for: 4) == 3, "Test failed.")
    XCTAssert(s.findLowerEntry(for: 5) == 5, "Test failed.")
    XCTAssert(s.findLowerEntry(for: 6) == 5, "Test failed.")
    XCTAssert(s.findLowerEntry(for: 7) == 5, "Test failed.")
    XCTAssert(s.findLowerEntry(for: 8) == 8, "Test failed.")
    XCTAssert(s.findLowerEntry(for: 9) == 8, "Test failed.")
    XCTAssert(s.findLowerEntry(for: 10) == 8, "Test failed.")
    XCTAssert(s.findLowerEntry(for: 40) == 34, "Test failed.")
    XCTAssert(s.findLowerEntry(for: 50) == 34, "Test failed.")
  }
  
  func testCeilingEntry() {
    let s = SortedDictionary<Int, Int>(elements: (1, 1), (2, 2), (3, 3), (5, 5), (8, 8), (13, 13), (21, 21), (34, 34))
    
    XCTAssert(s.findCeilingEntry(for: -15) == 1, "Test failed.")
    XCTAssert(s.findCeilingEntry(for: 0) == 1, "Test failed.")
    XCTAssert(s.findCeilingEntry(for: 1) == 1, "Test failed.")
    XCTAssert(s.findCeilingEntry(for: 2) == 2, "Test failed.")
    XCTAssert(s.findCeilingEntry(for: 3) == 3, "Test failed.")
    XCTAssert(s.findCeilingEntry(for: 4) == 5, "Test failed.")
    XCTAssert(s.findCeilingEntry(for: 5) == 5, "Test failed.")
    XCTAssert(s.findCeilingEntry(for: 6) == 8, "Test failed.")
    XCTAssert(s.findCeilingEntry(for: 7) == 8, "Test failed.")
    XCTAssert(s.findCeilingEntry(for: 8) == 8, "Test failed.")
    XCTAssert(s.findCeilingEntry(for: 9) == 13, "Test failed.")
    XCTAssert(s.findCeilingEntry(for: 10) == 13, "Test failed.")
    XCTAssert(s.findCeilingEntry(for: 40) == nil, "Test failed.")
    XCTAssert(s.findCeilingEntry(for: 50) == nil, "Test failed.")
  }
}
