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

class QueueTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInt() {
        var q = Queue<Int>()

        q.enqueue(1)
        q.enqueue(2)
        q.enqueue(3)

        XCTAssert(q.count == 3, "Count incorrect, got \(q.count).")
        XCTAssert(q.peek == 1, "Peek incorrect, got \(String(describing: q.peek))")

        q.enqueue(5)
        q.enqueue(6)
        q.enqueue(7)

        XCTAssert(q.count == 6, "Count incorrect, got \(q.count).")
        XCTAssert(q.peek == 1, "Peek incorrect, got \(String(describing: q.peek))")

        XCTAssert(q.dequeue() == 1 && q.count == 5 && q.peek == 2, "Dequeue incorrect")
        XCTAssert(q.dequeue() == 2 && q.count == 4 && q.peek == 3, "Dequeue incorrect")
        XCTAssert(q.dequeue() == 3 && q.count == 3 && q.peek == 5, "Dequeue incorrect")
        XCTAssert(q.dequeue() == 5 && q.count == 2 && q.peek == 6, "Dequeue incorrect")
        XCTAssert(q.dequeue() == 6 && q.count == 1 && q.peek == 7, "Dequeue incorrect")
        XCTAssert(q.dequeue() == 7 && q.count == 0 && q.peek == nil, "Dequeue incorrect")

        q.enqueue(1)
        q.enqueue(2)
        q.enqueue(3)
        q.removeAll()

        XCTAssert(q.count == 0, "Count incorrect, got \(q.count).")

        q.enqueue(1)
        q.enqueue(2)
        q.enqueue(3)
    }

    func testConcat() {
        var q1 = Queue<Int>()
        q1.enqueue(1)
        q1.enqueue(2)
        q1.enqueue(3)

        var q2 = Queue<Int>()
        q2.enqueue(4)
        q2.enqueue(5)
        q2.enqueue(6)

        var q3 = q1 + q2

        for x in q1 {
            XCTAssert(x == q3.dequeue(), "Concat incorrect.")
        }

        for x in q2 {
            XCTAssert(x == q3.dequeue(), "Concat incorrect.")
        }

        q3.removeAll()
        var q4 = q1 + q2 + q3
        for x in q4 {
            XCTAssert(x == q4.dequeue(), "Concat incorrect.")
        }
    }

    func testPerformance() {
        measure {}
    }
}
