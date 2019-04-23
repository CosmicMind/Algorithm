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

class StackTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testInt() {
    var s = Stack<Int>()
    
    s.push(1)
    s.push(2)
    s.push(3)
    
    XCTAssert(3 == s.count, "Count incorrect, got \(s.count).")
    XCTAssert(3 == s.top, "Top incorrect, got \(String(describing: s.top))")
    
    s.push(5)
    s.push(6)
    s.push(7)
    
    XCTAssert(6 == s.count, "Count incorrect, got \(s.count).")
    XCTAssert(7 == s.top, "Top incorrect, got \(String(describing: s.top))")
    
    XCTAssert(7 == s.pop() && 5 == s.count && 6 == s.top, "Pop incorrect")
    XCTAssert(6 == s.pop() && 4 == s.count && 5 == s.top, "Pop incorrect")
    XCTAssert(5 == s.pop() && 3 == s.count && 3 == s.top, "Pop incorrect")
    XCTAssert(3 == s.pop() && 2 == s.count && 2 == s.top, "Pop incorrect")
    XCTAssert(2 == s.pop() && 1 == s.count && 1 == s.top, "Pop incorrect")
    XCTAssert(1 == s.pop() && 0 == s.count && nil == s.top, "Pop incorrect")
    
    s.push(1)
    s.push(2)
    s.push(3)
    s.removeAll()
    
    XCTAssert(0 == s.count, "Count incorrect, got \(s.count).")
  }
  
  func testConcat() {
    var s1 = Stack<Int>()
    s1.push(1)
    s1.push(2)
    s1.push(3)
    
    var s2 = Stack<Int>()
    s2.push(4)
    s2.push(5)
    s2.push(6)
    
    let s3 = s1 + s2
    XCTAssert(6 == s3.count, "Concat incorrect.")
  }
  
  func testPerformance() {
    self.measure() {}
  }
}
