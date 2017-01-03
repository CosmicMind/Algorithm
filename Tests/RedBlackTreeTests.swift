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

class RedBlackTreeTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func testInt() {
		var s = RedBlackTree<Int, Int>(uniqueKeys: true)
		
		XCTAssert(0 == s.count, "Test failed, got \(s.count).")
		
		for _ in 0..<1000 {
            s.insert(value: 1, for: 1)
            s.insert(value: 2, for: 2)
            s.insert(value: 3, for: 3)
		}
		
		XCTAssert(3 == s.count, "Test failed.\(s)")
		XCTAssert(1 == s[0].value, "Test failed.")
		XCTAssert(2 == s[1].value, "Test failed.")
		XCTAssert(3 == s[2].value, "Test failed.")
		
		for _ in 0..<500 {
            s.removeValue(for: 1)
            s.removeValue(for: 3)
		}
		
		XCTAssert(1 == s.count, "Test failed.")
        s.removeValue(for: 2)
		
        XCTAssert(true == s.insert(value: 10, for: 2), "Test failed.")
		XCTAssertEqual(1, s.count, "Test failed.")
        XCTAssertEqual(10, s.findValue(for: 2), "Test failed.")
		XCTAssertEqual(10, s[0].value, "Test failed.")
		
        s.removeValue(for: 2)
		XCTAssertEqual(0, s.count, "Test failed.")
		
        s.insert(value: 1, for: 1)
        s.insert(value: 2, for: 2)
        s.insert(value: 3, for: 3)
		
		for i in s.startIndex..<s.endIndex {
			s[i] = (s[i].key, 100)
			XCTAssert(100 == s[i].value, "Test failed.")
		}
		
		s.removeAll()
		XCTAssert(0 == s.count, "Test failed.")
	}
	
	func testPropertyKey() {
		var s = RedBlackTree<String, Array<Int>>(uniqueKeys: false)
        s.insert(value: [1, 2, 3], for: "friends")
		s["menu"] = [11, 22, 33]
		
		XCTAssert(s["friends"]! == s[0].value!, "Test failed.")
		XCTAssert(s["menu"]! == s[1].value!, "Test failed.")
		XCTAssert(s["empty"] == nil, "Test failed.")
		s["menu"] = [22, 33, 44]
		XCTAssert(s["menu"]! == [22, 33, 44], "Test failed.")
		s["menu"] = nil
		XCTAssert(2 == s.count, "Test failed.")
	}
	
	func testValue() {
		var t1 = RedBlackTree<Int, Int>()
        t1.insert(value: 1, for: 1)
		t1.insert(value: 2, for: 2)
		t1.insert(value: 3, for: 3)
		
		var t2 = RedBlackTree<Int, Int>()
        t2.insert(value: 4, for: 4)
		t2.insert(value: 5, for: 5)
		t2.insert(value: 6, for: 6)
		
		let t3 = t1 + t2
		
		for i in 0..<t1.count {
            XCTAssert(t1[i].value == t3.findValue(for: t1[i].value!), "Test failed.")
		}
		
		for i in 0..<t2.count {
            XCTAssert(t2[i].value == t3.findValue(for: t2[i].value!), "Test failed.")
		}
	}
	
	func testIndexOfUniqueKeys() {
		var t1 = RedBlackTree<Int, Int>(uniqueKeys: true)
        t1.insert(value: 1, for: 1)
		t1.insert(value: 2, for: 2)
		t1.insert(value: 3, for: 3)
		t1.insert(value: 4, for: 4)
		t1.insert(value: 5, for: 5)
		t1.insert(value: 5, for: 5)
		t1.insert(value: 6, for: 6)
		
		XCTAssert(0 == t1.index(of: 1), "Test failed.")
		XCTAssert(5 == t1.index(of: 6), "Test failed.")
		XCTAssert(-1 == t1.index(of: 100), "Test failed.")
	}

	func testIndexOfNonUniqueKeys() {
		var t1 = RedBlackTree<Int, Int>()
        t1.insert(value: 1, for: 1)
        t1.insert(value: 2, for: 2)
        t1.insert(value: 3, for: 3)
        t1.insert(value: 4, for: 4)
        t1.insert(value: 5, for: 5)
        t1.insert(value: 5, for: 5)
        t1.insert(value: 6, for: 6)
        
		XCTAssert(0 == t1.index(of: 1), "Test failed.")
		XCTAssert(6 == t1.index(of: 6), "Test failed.")
		XCTAssert(-1 == t1.index(of: 100), "Test failed.")
	}
	
	func testOperands() {
		var t1 = RedBlackTree<Int, Int>(uniqueKeys: true)
		t1.insert((1, 1), (2, 2), (3, 3), (4, 4))
		XCTAssertEqual(4, t1.count, "Test failed.")
		
		var t2 = RedBlackTree<Int, Int>(uniqueKeys: true)
		t2.insert((5, 5), (6, 6), (7, 7), (8, 8))
		XCTAssertEqual(4, t2.count, "Test failed.")
        
        let t3 = t1 + t2
		XCTAssertEqual(8, t3.count, "Test failed.")
		
		XCTAssert(t1 != t2, "Test failed.")
		XCTAssert(t3 != t2, "Test failed.")
        
		XCTAssert(t3 == (t1 + t2), "Test failed.")
	}

	func testPerformance() {
		self.measure() {}
	}
}
