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

class RedBlackTreeTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testInt() {
    var s = RedBlackTree<Int, Int>(uniqueKeys: true)
    
    XCTAssert(0 == s.count, "Test failed, got \(s.count).")
    
    for _ in 0..<1000 {
      s.insert(value: 1, for: 1)
      s.insert(value: 2, for: 2)
      s.insert(value: 3, for: 3)
    }
    
    XCTAssert(3 == s.count, "Test failed.\(s)")
    XCTAssert(1 == s[0].value, "Test failed.")
    XCTAssert(2 == s[1].value, "Test failed.")
    XCTAssert(3 == s[2].value, "Test failed.")
    
    for _ in 0..<500 {
      s.removeValue(for: 1)
      s.removeValue(for: 3)
    }
    
    XCTAssert(1 == s.count, "Test failed.")
    s.removeValue(for: 2)
    
    XCTAssert(true == s.insert(value: 10, for: 2), "Test failed.")
    XCTAssertEqual(1, s.count, "Test failed.")
    XCTAssertEqual(10, s.findValue(for: 2), "Test failed.")
    XCTAssertEqual(10, s[0].value, "Test failed.")
    
    s.removeValue(for: 2)
    XCTAssertEqual(0, s.count, "Test failed.")
    
    s.insert(value: 1, for: 1)
    s.insert(value: 2, for: 2)
    s.insert(value: 3, for: 3)
    
    for i in s.startIndex..<s.endIndex {
      s[i] = (s[i].key, 100)
      XCTAssert(100 == s[i].value, "Test failed.")
    }
    
    s.removeAll()
    XCTAssert(0 == s.count, "Test failed.")
  }
  
  func testPropertyKey() {
    var s = RedBlackTree<String, Array<Int>>(uniqueKeys: false)
    s.insert(value: [1, 2, 3], for: "friends")
    s["menu"] = [11, 22, 33]
    
    XCTAssert(s["friends"]! == s[0].value!, "Test failed.")
    XCTAssert(s["menu"]! == s[1].value!, "Test failed.")
    XCTAssert(s["empty"] == nil, "Test failed.")
    s["menu"] = [22, 33, 44]
    XCTAssert(s["menu"]! == [22, 33, 44], "Test failed.")
    s["menu"] = nil
    XCTAssert(2 == s.count, "Test failed.")
  }
  
  func testValue() {
    var t1 = RedBlackTree<Int, Int>()
    t1.insert(value: 1, for: 1)
    t1.insert(value: 2, for: 2)
    t1.insert(value: 3, for: 3)
    
    var t2 = RedBlackTree<Int, Int>()
    t2.insert(value: 4, for: 4)
    t2.insert(value: 5, for: 5)
    t2.insert(value: 6, for: 6)
    
    let t3 = t1 + t2
    
    for i in 0..<t1.count {
      XCTAssert(t1[i].value == t3.findValue(for: t1[i].value!), "Test failed.")
    }
    
    for i in 0..<t2.count {
      XCTAssert(t2[i].value == t3.findValue(for: t2[i].value!), "Test failed.")
    }
  }
  
  func testIndexOfUniqueKeys() {
    var t1 = RedBlackTree<Int, Int>(uniqueKeys: true)
    t1.insert(value: 1, for: 1)
    t1.insert(value: 2, for: 2)
    t1.insert(value: 3, for: 3)
    t1.insert(value: 4, for: 4)
    t1.insert(value: 5, for: 5)
    t1.insert(value: 5, for: 5)
    t1.insert(value: 6, for: 6)
    
    XCTAssert(0 == t1.index(of: 1), "Test failed.")
    XCTAssert(5 == t1.index(of: 6), "Test failed.")
    XCTAssert(-1 == t1.index(of: 100), "Test failed.")
  }
  
  func testIndexOfNonUniqueKeys() {
    var t1 = RedBlackTree<Int, Int>()
    t1.insert(value: 1, for: 1)
    t1.insert(value: 2, for: 2)
    t1.insert(value: 3, for: 3)
    t1.insert(value: 4, for: 4)
    t1.insert(value: 5, for: 5)
    t1.insert(value: 5, for: 5)
    t1.insert(value: 6, for: 6)
    
    XCTAssert(0 == t1.index(of: 1), "Test failed.")
    XCTAssert(6 == t1.index(of: 6), "Test failed.")
    XCTAssert(-1 == t1.index(of: 100), "Test failed.")
  }
  
  func testOperands() {
    var t1 = RedBlackTree<Int, Int>(uniqueKeys: true)
    t1.insert((1, 1), (2, 2), (3, 3), (4, 4))
    XCTAssertEqual(4, t1.count, "Test failed.")
    
    var t2 = RedBlackTree<Int, Int>(uniqueKeys: true)
    t2.insert((5, 5), (6, 6), (7, 7), (8, 8))
    XCTAssertEqual(4, t2.count, "Test failed.")
    
    let t3 = t1 + t2
    XCTAssertEqual(8, t3.count, "Test failed.")
    
    XCTAssert(t1 != t2, "Test failed.")
    XCTAssert(t3 != t2, "Test failed.")
    
    XCTAssert(t3 == (t1 + t2), "Test failed.")
  }
  
  func testPerformance() {
    self.measure() {}
  }
}
