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

class DequeTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInt() {
        var d = Deque<Int>()

        d.insert(atFront: 1)
        d.insert(atFront: 2)
        d.insert(atFront: 3)

        XCTAssert(d.count == 3, "Count incorrect, got \(d.count).")

        XCTAssert(d.front == 3, "Front incorrect, got \(String(describing: d.front))")
        XCTAssert(d.back == 1, "Back incorrect, got \(String(describing: d.back))")

        d.insert(atBack: 5)
        d.insert(atBack: 6)
        d.insert(atBack: 7)

        XCTAssert(d.count == 6, "Count incorrect, got \(d.count).")

        XCTAssert(d.front == 3, "Front incorrect, got \(String(describing: d.front))")
        XCTAssert(d.back == 7, "Back incorrect, got \(String(describing: d.back))")

        XCTAssert(d.removeAtFront() == 3 && d.count == 5 && d.front == 2, "RemoveAtFront incorrect")
        XCTAssert(d.removeAtFront() == 2 && d.count == 4 && d.front == 1, "RemoveAtFront incorrect")
        XCTAssert(d.removeAtFront() == 1 && d.count == 3 && d.front == 5, "RemoveAtFront incorrect")

        XCTAssert(d.removeAtBack() == 7 && d.count == 2 && d.back == 6, "RemoveAtBack incorrect")
        XCTAssert(d.removeAtBack() == 6 && d.count == 1 && d.back == 5, "RemoveAtBack incorrect")
        XCTAssert(d.removeAtBack() == 5 && d.count == 0 && d.back == nil, "RemoveAtBack incorrect")

        d.insert(atFront: 1)
        d.insert(atFront: 2)
        d.insert(atFront: 3)
        d.removeAll()

        XCTAssert(d.count == 0, "Count incorrect, got \(d.count).")
    }

    func testConcat() {
        var d1 = Deque<Int>()
        d1.insert(atBack: 1)
        d1.insert(atBack: 2)
        d1.insert(atBack: 3)

        var d2 = Deque<Int>()
        d2.insert(atBack: 5)
        d2.insert(atBack: 6)
        d2.insert(atBack: 7)

        var d3 = d1 + d2

        for x in d1 {
            XCTAssertEqual(x, d3.removeAtFront(), "Concat incorrect.")
        }

        for x in d2 {
            XCTAssertEqual(x, d3.removeAtFront(), "Concat incorrect.")
        }
    }
}
