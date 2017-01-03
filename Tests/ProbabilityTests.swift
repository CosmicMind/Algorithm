/*
 * Copyright (C) 2015 - 2017, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.com>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *	*	Redistributions of source code must retain the above copyright notice, this
 *		list of conditions and the following disclaimer.
 *
 *	*	Redistributions in binary form must reproduce the above copyright notice,
 *		this list of conditions and the following disclaimer in the documentation
 *		and/or other materials provided with the distribution.
 *
 *	*	Neither the name of CosmicMind nor the names of its
 *		contributors may be used to endorse or promote products derived from
 *		this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import XCTest
@testable import Algorithm

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
		XCTAssertEqual(0, s.probability { _ -> Bool in return true})

		s.insert(1, 2, 3, 3)

        let ev1: Double = 16 * s.probability(of: 2, 3)

        XCTAssertEqual(ev1, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

		let ev2: Double = 16 * s.probability { (element: Int) -> Bool in
			return 2 == element || 3 == element
		}

        XCTAssertEqual(ev2, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

		s.removeAll()
		XCTAssert(0 == s.count, "Test failed.")
	}

	func testSortedMultiSet() {
		var s = SortedSet<Int>()
		XCTAssertEqual(0, s.probability { _ -> Bool in return true})

		s.insert(1, 2, 3, 3)

        let ev1: Double = 16 * s.probability(of: 2, 3)

        XCTAssertEqual(ev1, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

		let ev2: Double = 16 * s.probability { (element: Int) -> Bool in
			return 2 == element || 3 == element
		}

        XCTAssertEqual(ev2, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

		s.removeAll()
		XCTAssert(0 == s.count, "Test failed.")
	}

	func testSortedDictionary() {
		var s = SortedDictionary<Int, Int>()
		XCTAssertEqual(0, s.probability { _ -> Bool in return true})

		s.insert((1, 1))
		s.insert((2, 2))
		s.insert((3, 3))
		s.insert((3, 3))

        let ev1: Double = 16 * s.probability(of: 2, 3)

        XCTAssertEqual(ev1, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

		let ev2: Double = 16 * s.probability { (key: Int, value: Int?) -> Bool in
			return 2 == value || 3 == value
		}

        XCTAssertEqual(ev2, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

		s.removeAll()
		XCTAssert(0 == s.count, "Test failed.")
	}

	func testSortedMultiDictionary() {
		var s = SortedMultiDictionary<Int, Int>()
		XCTAssertEqual(0, s.probability { _ -> Bool in return true})

		s.insert((1, 1))
		s.insert((2, 2))
		s.insert((3, 3))
		s.insert((3, 3))

        let ev1: Double = 16 * s.probability(of: 2, 3)

        XCTAssertEqual(ev1, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

		let ev2: Double = 16 * s.probability { (key: Int, value: Int?) -> Bool in
			return 2 == value || 3 == value
		}

        XCTAssertEqual(ev2, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

		s.removeAll()
		XCTAssert(0 == s.count, "Test failed.")
	}

	func testArray() {
		var s: Array<Int> = Array<Int>()
		XCTAssertEqual(0, s.probability { _ -> Bool in return true})

		s.append(1)
		s.append(2)
		s.append(3)
		s.append(4)

        let ev1: Double = 16 * s.probability(of: 2, 3)

        XCTAssertEqual(ev1, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

		let ev2: Double = 16 * s.probability { (element: Int) -> Bool in
			return 2 == element || 3 == element
		}

        XCTAssertEqual(ev2, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

		s.removeAll()
		XCTAssert(0 == s.count, "Test failed.")
	}

	func testSet() {
		var s: Set<Int> = Set<Int>()
		XCTAssertEqual(0, s.probability { _ -> Bool in return true})

		s.insert(1)
		s.insert(2)
		s.insert(3)
		s.insert(4)

        let ev1: Double = 16 * s.probability(of: 2, 3)

        XCTAssertEqual(ev1, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

		let ev2: Double = 16 * s.probability { (element: Int) -> Bool in
			return 2 == element || 3 == element
		}

        XCTAssertEqual(ev2, s.expectedValue(trials: 16, for: 2, 3), "Test failed.")

		s.removeAll()
		XCTAssertEqual(0, s.count)
	}

	func testBlock() {
		let die: Array<Int> = Array<Int>(arrayLiteral: 1, 2, 3, 4, 5, 6)

		let probabilityOfX: Double = die.probability { (number: Int) in
			if 5 < number || 0 == number % 3 {
				// Do more.
				return true
			}
			return false
		}
		
		XCTAssertTrue(0.33 < probabilityOfX, "Test failed.")
	}

	func testPerformance() {
		self.measure() {}
	}
}
