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

class SortedMultiDictionaryTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func testInt() {
		var s = SortedMultiDictionary<Int, Int>()
		
		XCTAssert(0 == s.count, "Test failed, got \(s.count).")
		
		for _ in 0..<1000 {
			s.insert((1, 1))
			s.insert((2, 2))
			s.insert((3, 3))
		}
		
		XCTAssert(3000 == s.count, "Test failed.")
		XCTAssert(1 == s[0].value, "Test failed.")
		XCTAssert(1 == s[1].value, "Test failed.")
		XCTAssert(1 == s[2].value, "Test failed.")
		
		for _ in 0..<500 {
			s.removeValue(for: 1)
			s.removeValue(for: 3)
		}
		
		XCTAssert(1000 == s.count, "Test failed.")
		s.removeValue(for: 2)
		
		s.insert((2, 10))
		XCTAssert(1 == s.count, "Test failed.")
        XCTAssert(10 == s.findValue(for: 2), "Test failed.")
		XCTAssert(10 == s[0].value!, "Test failed.")
		
		s.removeValue(for: 2)
		XCTAssert(0 == s.count, "Test failed.")
		
		s.insert((1, 1))
		s.insert((2, 2))
		s.insert((3, 3))
		s.insert((3, 3))
        s.update(value: 5, for: 3)
		
        let subs = s.search(for: 3)
		XCTAssert(2 == subs.count, "Test failed.")
		
		let generator = subs.makeIterator()
		while let x = generator.next() {
			XCTAssert(5 == x.value, "Test failed.")
		}
		
		for i in 0..<s.endIndex {
			s[i] = (s[i].key, 100)
			XCTAssert(100 == s[i].value, "Test failed.")
		}
		
		s.removeAll()
		XCTAssert(0 == s.count, "Test failed.")
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
		
		XCTAssert(0 == d1.index(of: 1), "Test failed.")
		XCTAssert(6 == d1.index(of: 6), "Test failed.")
		XCTAssert(-1 == d1.index(of: 100), "Test failed.")
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
		self.measure() {}
	}
}
