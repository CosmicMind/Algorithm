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

@testable import Algorithm
import XCTest

class ProbabilityTests: XCTestCase {
    var saveExpectation: XCTestExpectation?

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSortedSet() {
        var s = SortedSet<Int>()
        XCTAssertEqual(0, s.probability { _ -> Bool in true })

        s.insert(1, 2, 3, 3)

        let ev1: Double = 16 * s.probability(of: 2, 3)

        XCTAssertEqual(ev1, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

        let ev2: Double = 16 * s.probability { (element: Int) -> Bool in
            element == 2 || element == 3
        }

        XCTAssertEqual(ev2, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

        s.removeAll()
        XCTAssert(s.count == 0, "Test failed.")
    }

    func testSortedMultiSet() {
        var s = SortedSet<Int>()
        XCTAssertEqual(0, s.probability { _ -> Bool in true })

        s.insert(1, 2, 3, 3)

        let ev1: Double = 16 * s.probability(of: 2, 3)

        XCTAssertEqual(ev1, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

        let ev2: Double = 16 * s.probability { (element: Int) -> Bool in
            element == 2 || element == 3
        }

        XCTAssertEqual(ev2, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

        s.removeAll()
        XCTAssert(s.count == 0, "Test failed.")
    }

    func testSortedDictionary() {
        var s = SortedDictionary<Int, Int>()
        XCTAssertEqual(0, s.probability { _, _ -> Bool in true })

        s.insert((1, 1))
        s.insert((2, 2))
        s.insert((3, 3))
        s.insert((3, 3))

        let ev1: Double = 16 * s.probability(of: 2, 3)

        XCTAssertEqual(ev1, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

        let ev2: Double = 16 * s.probability { (_: Int, value: Int?) -> Bool in
            value == 2 || value == 3
        }

        XCTAssertEqual(ev2, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

        s.removeAll()
        XCTAssert(s.count == 0, "Test failed.")
    }

    func testSortedMultiDictionary() {
        var s = SortedMultiDictionary<Int, Int>()
        XCTAssertEqual(0, s.probability { _, _ -> Bool in true })

        s.insert((1, 1))
        s.insert((2, 2))
        s.insert((3, 3))
        s.insert((3, 3))

        let ev1: Double = 16 * s.probability(of: 2, 3)

        XCTAssertEqual(ev1, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

        let ev2: Double = 16 * s.probability { (_: Int, value: Int?) -> Bool in
            value == 2 || value == 3
        }

        XCTAssertEqual(ev2, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

        s.removeAll()
        XCTAssert(s.count == 0, "Test failed.")
    }

    func testArray() {
        var s: [Int] = [Int]()
        XCTAssertEqual(0, s.probability { _ -> Bool in true })

        s.append(1)
        s.append(2)
        s.append(3)
        s.append(4)

        let ev1: Double = 16 * s.probability(of: 2, 3)

        XCTAssertEqual(ev1, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

        let ev2: Double = 16 * s.probability { (element: Int) -> Bool in
            element == 2 || element == 3
        }

        XCTAssertEqual(ev2, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

        s.removeAll()
        XCTAssert(s.count == 0, "Test failed.")
    }

    func testSet() {
        var s: Set<Int> = Set<Int>()
        XCTAssertEqual(0, s.probability { _ -> Bool in true })

        s.insert(1)
        s.insert(2)
        s.insert(3)
        s.insert(4)

        let ev1: Double = 16 * s.probability(of: 2, 3)

        XCTAssertEqual(ev1, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

        let ev2: Double = 16 * s.probability { (element: Int) -> Bool in
            element == 2 || element == 3
        }

        XCTAssertEqual(ev2, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

        s.removeAll()
        XCTAssertEqual(0, s.count)
    }

    func testBlock() {
        let die: [Int] = [Int](arrayLiteral: 1, 2, 3, 4, 5, 6)

        let probabilityOfX: Double = die.probability { (number: Int) in
            if number > 5 || number % 3 == 0 {
                // Do more.
                return true
            }
            return false
        }

        XCTAssertTrue(probabilityOfX > 0.33, "Test failed.")
    }

    func testPerformance() {
        measure {}
    }
}
