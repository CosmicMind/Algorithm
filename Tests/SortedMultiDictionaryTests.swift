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

class SortedMultiDictionaryTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testInt() {
        var s = SortedMultiDictionary<Int, Int>()

        XCTAssert(s.count == 0, "Test failed, got \(s.count).")

        for _ in 0 ..< 1000 {
            s.insert((1, 1))
            s.insert((2, 2))
            s.insert((3, 3))
        }

        XCTAssert(s.count == 3000, "Test failed.")
        XCTAssert(s[0].value == 1, "Test failed.")
        XCTAssert(s[1].value == 1, "Test failed.")
        XCTAssert(s[2].value == 1, "Test failed.")

        for _ in 0 ..< 500 {
            s.removeValue(for: 1)
            s.removeValue(for: 3)
        }

        XCTAssert(s.count == 1000, "Test failed.")
        s.removeValue(for: 2)

        s.insert((2, 10))
        XCTAssert(s.count == 1, "Test failed.")
        XCTAssert(s.findValue(for: 2) == 10, "Test failed.")
        XCTAssert(s[0].value! == 10, "Test failed.")

        s.removeValue(for: 2)
        XCTAssert(s.count == 0, "Test failed.")

        s.insert((1, 1))
        s.insert((2, 2))
        s.insert((3, 3))
        s.insert((3, 3))
        s.update(value: 5, for: 3)

        let subs = s.search(for: 3)
        XCTAssert(subs.count == 2, "Test failed.")

        let generator = subs.makeIterator()
        while let x = generator.next() {
            XCTAssert(x.value == 5, "Test failed.")
        }

        for i in 0 ..< s.endIndex {
            s[i] = (s[i].key, 100)
            XCTAssert(s[i].value == 100, "Test failed.")
        }

        s.removeAll()
        XCTAssert(s.count == 0, "Test failed.")
    }

    func testIndexOf() {
        var d1 = SortedMultiDictionary<Int, Int>()
        d1.insert(value: 1, for: 1)
        d1.insert(value: 2, for: 2)
        d1.insert(value: 3, for: 3)
        d1.insert(value: 4, for: 4)
        d1.insert(value: 5, for: 5)
        d1.insert(value: 5, for: 5)
        d1.insert(value: 6, for: 6)

        XCTAssert(d1.index(of: 1) == 0, "Test failed.")
        XCTAssert(d1.index(of: 6) == 6, "Test failed.")
        XCTAssert(d1.index(of: 100) == -1, "Test failed.")
    }

    func testKeys() {
        let s = SortedMultiDictionary<String, Int>(elements: ("adam", 1), ("daniel", 2), ("mike", 3), ("natalie", 4))
        let keys = SortedMultiSet<String>(elements: "adam", "daniel", "mike", "natalie")
        XCTAssert(keys.asArray == s.keys, "Test failed.")
    }

    func testValues() {
        let s = SortedMultiDictionary<String, Int>(elements: ("adam", 1), ("daniel", 2), ("mike", 3), ("natalie", 4))
        let values = [1, 2, 3, 4]
        XCTAssert(values == s.values, "Test failed.")
    }

    func testPerformance() {
        measure {}
    }
}
