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

class SortedSetTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testInt() {
    var s = SortedSet<Int>()
    
    XCTAssert(0 == s.count, "Test failed, got \(s.count).")
    
    for _ in 0..<1000 {
      s.insert(1)
      s.insert(2)
      s.insert(3)
    }
    
    XCTAssert(3 == s.count, "Test failed.\(s)")
    XCTAssert(1 == s[0], "Test failed.")
    XCTAssert(2 == s[1], "Test failed.")
    XCTAssert(3 == s[2], "Test failed.")
    
    for _ in 0..<500 {
      s.remove(1)
      s.remove(3)
    }
    
    XCTAssert(1 == s.count, "Test failed.")
    
    s.remove(2)
    s.insert(10)
    XCTAssert(1 == s.count, "Test failed.")
    
    s.remove(10)
    XCTAssert(0 == s.count, "Test failed.")
    
    s.insert(1)
    s.insert(2)
    s.insert(3)
    s.remove(1, 2)
    XCTAssert(1 == s.count, "Test failed.")
    
    s.removeAll()
    XCTAssert(0 == s.count, "Test failed.")
  }
  
  func testRemove() {
    var s1 = SortedSet<Int>(elements: 22, 23, 1, 2, 3, 4, 5)
    s1.remove(1, 2, 3)
    XCTAssert(4 == s1.count, "Test failed.")
  }
  
  func testIntersect() {
    let s1 = SortedSet<Int>(elements: 22, 23, 1, 2, 3, 4, 5)
    let s2 = SortedSet<Int>(elements: 22, 23, 5, 6, 7, 8, 9, 10)
    
    XCTAssert(SortedSet<Int>(elements: 22, 23, 5) == s1.intersection(s2), "Test failed. \(s1.intersection(s2))")
    
    XCTAssert(SortedSet<Int>() == s1.intersection(SortedSet<Int>()), "Test failed. \(s1)")
    
    let s3 = SortedSet<Int>(elements: 1, 2, 3, 4, 5, 6, 7, 8, 9, 9, 9, 9, 9)
    let s4 = SortedSet<Int>(elements: 11, 9, 7, 3, 8, 100, 99, 88, 77)
    XCTAssert(SortedSet<Int>(elements: 9, 3, 7, 8) == s3.intersection(s4), "Test failed.")
  }
  
  func testIntersectInPlace() {
    var s1 = SortedSet<Int>(elements: 22, 23, 1, 2, 3, 4, 5)
    let s2 = SortedSet<Int>(elements: 22, 23, 5, 6, 7, 8, 9, 10)
    
    s1.formIntersection(s2)
    XCTAssert(SortedSet<Int>(elements: 22, 23, 5) == s1, "Test failed. \(s1)")
    
    s1.formIntersection(SortedSet<Int>())
    XCTAssert(SortedSet<Int>() == s1, "Test failed. \(s1)")
    
    var s3 = SortedSet<Int>(elements: 1, 2, 3, 4, 5, 6, 7, 8, 9, 9, 9, 9, 9)
    let s4 = SortedSet<Int>(elements: 11, 9, 7, 3, 8, 100, 99, 88, 77)
    s3.formIntersection(s4)
    XCTAssert(SortedSet<Int>(elements: 9, 3, 7, 8) == s3, "Test failed.")
  }
  
  func testSubtract() {
    let s1 = SortedSet<Int>(elements: 1, 2, 3, 4, 5, 7, 8, 9, 10)
    let s2 = SortedSet<Int>(elements: 4, 5, 6, 7)
    
    XCTAssert(SortedSet<Int>(elements: 1, 2, 3, 8, 9, 10) == s1.subtracting(s2), "Test failed. \(s1.subtracting(s2))")
    
    let s3 = SortedSet<Int>(elements: 0, -1, -2, -7, 99, 100)
    let s4 = SortedSet<Int>(elements: -3, -5, -7, 99)
    XCTAssert(SortedSet<Int>(elements: 0, -1, -2, 100) == s3.subtracting(s4), "Test failed. \(s3.subtracting(s4))")
  }
  
  func testSubtractInPlace() {
    var s1 = SortedSet<Int>(elements: 1, 2, 3, 4, 5, 7, 8, 9, 10)
    let s2 = SortedSet<Int>(elements: 4, 5, 6, 7)
    
    s1.subtract(s2)
    XCTAssert(SortedSet<Int>(elements: 1, 2, 3, 8, 9, 10) == s1, "Test failed. \(s1)")
    
    var s3 = SortedSet<Int>(elements: 0, -1, -2, -7, 99, 100)
    let s4 = SortedSet<Int>(elements: -3, -5, -7, 99)
    s3.subtract(s4)
    XCTAssert(SortedSet<Int>(elements: 0, -1, -2, 100) == s3, "Test failed. \(s3)")
  }
  
  func testUnion() {
    let s1 = SortedSet<Int>(elements: 1, 2, 3, 4, 5)
    let s2 = SortedSet<Int>(elements: 5, 6, 7, 8, 9)
    let s3 = SortedSet<Int>(elements: 1, 2, 3, 4, 5, 6, 7, 8, 9)
    
    XCTAssert(s3 == s1.union(s2), "Test failed.")
  }
  
  func testUnionInPlace() {
    var s1 = SortedSet<Int>(elements: 1, 2, 3, 4, 5)
    let s2 = SortedSet<Int>(elements: 5, 6, 7, 8, 9)
    let s3 = SortedSet<Int>(elements: 1, 2, 3, 4, 5, 6, 7, 8, 9)
    
    s1.formUnion(s2)
    XCTAssert(s3 == s1, "Test failed.")
  }
  
  func testExclusiveOr() {
    let s1 = SortedSet<Int>(elements: 1, 2, 3, 4, 5, 6, 7)
    let s2 = SortedSet<Int>(elements: 1, 2, 3, 4, 5)
    let s3 = SortedSet<Int>(elements: 5, 6, 7, 8)
    
    XCTAssert(SortedSet<Int>(elements: 6, 7) == s1.symmetricDifference(s2), "Test failed. \(s1.symmetricDifference(s2))")
    XCTAssert(SortedSet<Int>(elements: 1, 2, 3, 4, 8) == s1.symmetricDifference(s3), "Test failed.")
    XCTAssert(SortedSet<Int>(elements: 1, 2, 3, 4, 6, 7, 8) == s2.symmetricDifference(s3), "Test failed.")
  }
  
  func testExclusiveOrInPlace() {
    var s1 = SortedSet<Int>(elements: 1, 2, 3, 4, 5, 6, 7)
    var s2 = SortedSet<Int>(elements: 1, 2, 3, 4, 5)
    let s3 = SortedSet<Int>(elements: 5, 6, 7, 8)
    
    s1.formSymmetricDifference(s2)
    XCTAssert(SortedSet<Int>(elements: 6, 7) == s1, "Test failed. \(s1)")
    
    s1 = SortedSet<Int>(elements: 1, 2, 3, 4, 5, 6, 7)
    s1.formSymmetricDifference(s3)
    XCTAssert(SortedSet<Int>(elements: 1, 2, 3, 4, 8) == s1, "Test failed. \(s1)")
    
    s2.formSymmetricDifference(s3)
    XCTAssert(SortedSet<Int>(elements: 1, 2, 3, 4, 6, 7, 8) == s2, "Test failed. \(s2)")
  }
  
  func testIsDisjointWith() {
    let s1 = SortedSet<Int>(elements: 1, 2, 3)
    let s2 = SortedSet<Int>(elements: 3, 4, 5)
    let s3 = SortedSet<Int>(elements: 5, 6, 7)
    
    XCTAssertFalse(s1.isDisjoint(with: s2), "Test failed. \(s1.isDisjoint(with: s2))")
    XCTAssert(s1.isDisjoint(with: s3), "Test failed.")
    XCTAssertFalse(s2.isDisjoint(with: s3), "Test failed.")
  }
  
  func testIsSubsetOf() {
    let s1 = SortedSet<Int>(elements: 1, 2, 3)
    let s2 = SortedSet<Int>(elements: 1, 2, 3, 4, 5)
    let s3 = SortedSet<Int>(elements: 2, 3, 4, 5)
    
    XCTAssert(s1 <= s1, "Test failed.")
    XCTAssert(s1 <= s2, "Test failed.")
    XCTAssertFalse(s1 <= s3, "Test failed.")
  }
  
  func testIsSupersetOf() {
    let s1 = SortedSet<Int>(elements: 1, 2, 3, 4, 5, 6, 7)
    let s2 = SortedSet<Int>(elements: 1, 2, 3, 4, 5)
    let s3 = SortedSet<Int>(elements: 5, 6, 7, 8)
    
    XCTAssert(s1 >= s1, "Test failed.")
    XCTAssert(s1 >= s2, "Test failed.")
    XCTAssertFalse(s1 >= s3, "Test failed.")
  }
  
  func testIsStrictSubsetOf() {
    let s1 = SortedSet<Int>(elements: 1, 2, 3)
    let s2 = SortedSet<Int>(elements: 1, 2, 3, 4, 5)
    let s3 = SortedSet<Int>(elements: 2, 3, 4, 5)
    
    XCTAssert(s1 < s2, "Test failed.")
    XCTAssertFalse(s1 < s3, "Test failed.")
  }
  
  func testIsStrictSupersetOf() {
    let s1 = SortedSet<Int>(elements: 1, 2, 3, 4, 5, 6, 7)
    let s2 = SortedSet<Int>(elements: 1, 2, 3, 4, 5)
    let s3 = SortedSet<Int>(elements: 5, 6, 7, 8)
    
    XCTAssert(s1 > s2, "Test failed.")
    XCTAssertFalse(s1 > s3, "Test failed.")
  }
  
  func testContains() {
    let s1 = SortedSet<Int>(elements: 1, 2, 3, 4, 5, 6, 7)
    XCTAssert(s1.contains(1, 2, 3), "Test failed.")
    XCTAssertFalse(s1.contains(1, 2, 3, 10), "Test failed.")
  }
  
  func testIndexOf() {
    var s1 = SortedSet<Int>()
    s1.insert(1, 2, 3, 4, 5, 6, 7)
    
    XCTAssert(0 == s1.index(of: 1), "Test failed.")
    XCTAssert(5 == s1.index(of: 6), "Test failed.")
    XCTAssert(-1 == s1.index(of: 100), "Test failed.")
  }
  
  func testExample() {
    let setA = SortedSet<Int>(elements: 1, 2, 3) // Sorted: [1, 2, 3]
    let setB = SortedSet<Int>(elements: 4, 3, 6) // Sorted: [3, 4, 6]
    
    let setC = SortedSet<Int>(elements: 7, 1, 2) // Sorted: [1, 2, 7]
    let setD = SortedSet<Int>(elements: 1, 7) // Sorted: [1, 7]
    
    let setE = SortedSet<Int>(elements: 1, 6, 7) // Sorted: [1, 6, 7]
    
    // Union.
    print((setA + setB).count) // Output: 5
    print(setA.union(setB).count) // Output: 5
    
    // Intersect.
    print(setC.intersection(setD).count) // Output: 2
    
    // Subset.
    print(setD < setC) // true
    print(setD.isSubset(of: setC)) // true
    
    // Superset.
    print(setD > setC) // false
    print(setD.isSuperset(of: setC)) // false
    
    // Contains.
    print(setE.contains(setA.first!)) // true
    
    // Probability.
    print(setE.probability(of: setA.first!, setA.last!)) // 0.333333333333333
  }
  
  func testPerformance() {
    self.measure() {}
  }
}
