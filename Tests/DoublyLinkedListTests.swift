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

        XCTAssert(l.count == 3, "Count incorrect, got \(l.count).")

        XCTAssert(l.front == 3, "Front incorrect, got \(String(describing: l.front))")
        XCTAssert(l.back == 1, "Back incorrect, got \(String(describing: l.back))")

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

        XCTAssert(l.count == 6, "Count incorrect, got \(l.count).")

        XCTAssert(l.front == 3, "Front incorrect, got \(String(describing: l.front))")
        XCTAssert(l.back == 7, "Back incorrect, got \(String(describing: l.back))")

        l.cursorToFront()
        XCTAssert(l.front == 3 && l.front == l.cursor, "Current incorrect, got \(String(describing: l.cursor))")
        XCTAssert(l.next() == 2, "Test failed, got \(String(describing: l.cursor))")
        XCTAssert(l.next() == 1, "Test failed, got \(String(describing: l.cursor))")
        XCTAssert(l.next() == 5, "Test failed, got \(String(describing: l.cursor))")
        XCTAssert(l.next() == 6, "Test failed, got \(String(describing: l.cursor))")
        XCTAssert(l.next() == 7, "Test failed, got \(String(describing: l.cursor))")

        l.cursorToBack()
        XCTAssert(l.back == 7 && l.back == l.cursor, "Current incorrect, got \(String(describing: l.cursor))")
        XCTAssert(l.previous() == 6, "Test failed, got \(String(describing: l.cursor))")
        XCTAssert(l.previous() == 5, "Test failed, got \(String(describing: l.cursor))")
        XCTAssert(l.previous() == 1, "Test failed, got \(String(describing: l.cursor))")
        XCTAssert(l.previous() == 2, "Test failed, got \(String(describing: l.cursor))")
        XCTAssert(l.previous() == 3, "Test failed, got \(String(describing: l.cursor))")

        l.cursorToFront()
        XCTAssert(l.removeAtFront() == 3 && l.count == 5, "Test failed.")
        XCTAssert(l.removeAtFront() == 2 && l.count == 4, "Test failed.")
        XCTAssert(l.removeAtFront() == 1 && l.count == 3, "Test failed.")

        l.cursorToBack()
        XCTAssert(l.removeAtBack() == 7 && l.count == 2, "Test failed.")
        XCTAssert(l.removeAtBack() == 6 && l.count == 1, "Test failed.")
        XCTAssert(l.removeAtBack() == 5 && l.count == 0, "Test failed.")

        l.removeAll()
        l.cursorToFront()
        XCTAssert(l.cursor == nil && l.count == 0, "Test failed, got \(String(describing: l.cursor))")
        l.insert(beforeCursor: 1)
        XCTAssert(l.cursor == 1 && l.count == 1, "Test failed, got \(String(describing: l.cursor))")

        l.removeAll()
        l.cursorToBack()
        XCTAssert(l.cursor == nil && l.count == 0, "Test failed, got \(String(describing: l.cursor))")
        l.insert(afterCursor: 1)
        XCTAssert(l.cursor == 1 && l.count == 1, "Test failed, got \(String(describing: l.cursor))")

        l.removeAll()
        l.insert(atBack: 1)
        XCTAssert(l.cursor == 1 && l.count == 1, "Test failed, got \(String(describing: l.cursor))")
        l.insert(afterCursor: 2)
        l.insert(afterCursor: 6)
        l.next()
        XCTAssert(l.cursor == 6 && l.count == 3, "Test failed, got \(String(describing: l.cursor))")
        l.insert(beforeCursor: 3)
        l.insert(beforeCursor: 5)
        l.previous()
        XCTAssert(l.cursor == 5 && l.count == 5, "Test failed, got \(String(describing: l.cursor))")
        l.insert(atBack: 4)
        l.previous()
        l.removeAtCursor()
        XCTAssert(l.cursor == 5 && l.count == 5, "Test failed, got \(String(describing: l.cursor))")
        l.removeAtCursor()
        XCTAssert(l.cursor == 6 && l.count == 4, "Test failed, got \(String(describing: l.cursor))")
        l.removeAtCursor()
        XCTAssert(l.cursor == 2 && l.count == 3, "Test failed, got \(String(describing: l.cursor))")
        l.removeAtCursor()
        XCTAssert(l.previous() == 1 && l.count == 2, "Test failed, got \(String(describing: l.cursor))")
        l.removeAtCursor()
        XCTAssert(l.front == l.cursor && l.back == l.cursor && l.count == 1, "Test failed, got \(String(describing: l.cursor))")
        l.removeAtCursor()
        XCTAssert(l.cursor == nil && l.count == 0, "Test failed, got \(String(describing: l.cursor))")

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
        measure {}
    }
}
