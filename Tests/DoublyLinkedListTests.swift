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

class DoublyLinkedListTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testInt() {
    var l = DoublyLinkedList<Int>()
    
    l.insert(atFront: 1)
    l.insert(atFront: 2)
    l.insert(atFront: 3)
    
    XCTAssert(3 == l.count, "Count incorrect, got \(l.count).")
    
    XCTAssert(3 == l.front, "Front incorrect, got \(String(describing: l.front))")
    XCTAssert(1 == l.back, "Back incorrect, got \(String(describing: l.back))")
    
    l.insert(atBack: 5)
    l.insert(atBack: 6)
    l.insert(atBack: 7)
    
    l.cursorToFront()
    while !l.isCursorAtBack {
      l.next()
    }
    
    l.cursorToBack()
    while !l.isCursorAtFront {
      l.previous()
    }
    
    XCTAssert(6 == l.count, "Count incorrect, got \(l.count).")
    
    XCTAssert(3 == l.front, "Front incorrect, got \(String(describing: l.front))")
    XCTAssert(7 == l.back, "Back incorrect, got \(String(describing: l.back))")
    
    l.cursorToFront()
    XCTAssert(3 == l.front && l.front == l.cursor, "Current incorrect, got \(String(describing: l.cursor))")
    XCTAssert(2 == l.next(), "Test failed, got \(String(describing: l.cursor))")
    XCTAssert(1 == l.next(), "Test failed, got \(String(describing: l.cursor))")
    XCTAssert(5 == l.next(), "Test failed, got \(String(describing: l.cursor))")
    XCTAssert(6 == l.next(), "Test failed, got \(String(describing: l.cursor))")
    XCTAssert(7 == l.next(), "Test failed, got \(String(describing: l.cursor))")
    
    l.cursorToBack()
    XCTAssert(7 == l.back && l.back == l.cursor, "Current incorrect, got \(String(describing: l.cursor))")
    XCTAssert(6 == l.previous(), "Test failed, got \(String(describing: l.cursor))")
    XCTAssert(5 == l.previous(), "Test failed, got \(String(describing: l.cursor))")
    XCTAssert(1 == l.previous(), "Test failed, got \(String(describing: l.cursor))")
    XCTAssert(2 == l.previous(), "Test failed, got \(String(describing: l.cursor))")
    XCTAssert(3 == l.previous(), "Test failed, got \(String(describing: l.cursor))")
    
    l.cursorToFront()
    XCTAssert(3 == l.removeAtFront() && 5 == l.count, "Test failed.")
    XCTAssert(2 == l.removeAtFront() && 4 == l.count, "Test failed.")
    XCTAssert(1 == l.removeAtFront() && 3 == l.count, "Test failed.")
    
    l.cursorToBack()
    XCTAssert(7 == l.removeAtBack() && 2 == l.count, "Test failed.")
    XCTAssert(6 == l.removeAtBack() && 1 == l.count, "Test failed.")
    XCTAssert(5 == l.removeAtBack() && 0 == l.count, "Test failed.")
    
    l.removeAll()
    l.cursorToFront()
    XCTAssert(nil == l.cursor && 0 == l.count, "Test failed, got \(String(describing: l.cursor))")
    l.insert(beforeCursor: 1)
    XCTAssert(1 == l.cursor && 1 == l.count, "Test failed, got \(String(describing: l.cursor))")
    
    l.removeAll()
    l.cursorToBack()
    XCTAssert(nil == l.cursor && 0 == l.count, "Test failed, got \(String(describing: l.cursor))")
    l.insert(afterCursor: 1)
    XCTAssert(1 == l.cursor && 1 == l.count, "Test failed, got \(String(describing: l.cursor))")
    
    l.removeAll()
    l.insert(atBack: 1)
    XCTAssert(1 == l.cursor && 1 == l.count, "Test failed, got \(String(describing: l.cursor))")
    l.insert(afterCursor: 2)
    l.insert(afterCursor: 6)
    l.next()
    XCTAssert(6 == l.cursor && 3 == l.count, "Test failed, got \(String(describing: l.cursor))")
    l.insert(beforeCursor: 3)
    l.insert(beforeCursor: 5)
    l.previous()
    XCTAssert(5 == l.cursor && 5 == l.count, "Test failed, got \(String(describing: l.cursor))")
    l.insert(atBack: 4)
    l.previous()
    l.removeAtCursor()
    XCTAssert(5 == l.cursor && 5 == l.count, "Test failed, got \(String(describing: l.cursor))")
    l.removeAtCursor()
    XCTAssert(6 == l.cursor && 4 == l.count, "Test failed, got \(String(describing: l.cursor))")
    l.removeAtCursor()
    XCTAssert(2 == l.cursor && 3 == l.count, "Test failed, got \(String(describing: l.cursor))")
    l.removeAtCursor()
    XCTAssert(1 == l.previous() && 2 == l.count, "Test failed, got \(String(describing: l.cursor))")
    l.removeAtCursor()
    XCTAssert(l.front == l.cursor && l.back == l.cursor && 1 == l.count, "Test failed, got \(String(describing: l.cursor))")
    l.removeAtCursor()
    XCTAssert(nil == l.cursor && 0 == l.count, "Test failed, got \(String(describing: l.cursor))")
    
    l.insert(atFront: 1)
    l.insert(atBack: 2)
    l.insert(atFront: 3)
  }
  
  func testConcat() {
    var l1 = DoublyLinkedList<Int>()
    l1.insert(atFront: 3)
    l1.insert(atFront: 2)
    l1.insert(atFront: 1)
    
    var l2 = DoublyLinkedList<Int>()
    l2.insert(atBack: 4)
    l2.insert(atBack: 5)
    l2.insert(atBack: 6)
    
    var l3 = l1 + l2
    
    for x in l1 {
      XCTAssert(x == l3.removeAtFront(), "Concat incorrect.")
    }
    
    for x in l2 {
      XCTAssert(x == l3.removeAtFront(), "Concat incorrect.")
    }
  }
  
  func testPerformance() {
    self.measure() {}
  }
}
