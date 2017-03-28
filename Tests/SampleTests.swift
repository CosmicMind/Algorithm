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

class SampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInt() {
//        let die = [Int](arrayLiteral: 1, 2, 3, 4, 5, 6)
//        
//        if 0.1 < die.probability(of: 3) {
//            // Do something ...
//        }
        
//        let die = [Int](arrayLiteral: 1, 2, 3, 4, 5, 6)
//        
//        let pOfX = die.probability { (number) in
//            return 5 < number || 0 == number % 3
//        }
//        
//        if 0.33 < pOfX {
//            // Do something.
//        }
        
//        let die = [Int](arrayLiteral: 1, 2, 3, 4, 5, 6)
//        
//        if 20 < die.expectedValue(trials: 100, for: 3, 6) {
//            // Do something ...
//        }
        
//        var listA = DoublyLinkedList<Int>()
//        
//        listA.insert(atFront: 3)
//        listA.insert(atFront: 2)
//        listA.insert(atFront: 1)
//        
//        var listB = DoublyLinkedList<Int>()
//        
//        listB.insert(atBack: 4)
//        listB.insert(atBack: 5)
//        listB.insert(atBack: 6)
//        
//        var listC = listA + listB
//        
//        listC.cursorToFront()
//        
//        var value = listC.cursor
//        
//        while nil != value {
//            // Do something ...
//            
//            value = listC.next()
//        }
//        
//        var stack = Stack<Int>()
//        
//        stack.push(1)
//        stack.push(2)
//        stack.push(3)
//        
//        while !stack.isEmpty {
//            let value = stack.pop()
//            
//            // Do something ...
//        }
//        
//        var queue = Queue<Int>()
//        
//        queue.enqueue(1)
//        queue.enqueue(2)
//        queue.enqueue(3)
//        
//        while !queue.isEmpty {
//            let value = queue.dequeue()
//        
//            // Do something ...
//        }
//        
//        var dequeA = Deque<Int>()
//        dequeA.insert(atBack: 1)
//        dequeA.insert(atBack: 2)
//        dequeA.insert(atBack: 3)
//        
//        while !dequeA.isEmpty {
//            let value = dequeA.removeAtFront()
//            
//            // Do something ...
//        }
//        
//        var dequeB = Deque<Int>()
//        dequeB.insert(atBack: 4)
//        dequeB.insert(atBack: 5)
//        dequeB.insert(atBack: 6)
//        
//        while !dequeB.isEmpty {
//            let value = dequeB.removeAtFront()
//            
//            // Do something ...
//        }
        
//        var ages = RedBlackTree<String, Int>(uniqueKeys: true)
//        
//        ages.insert(value: 16, for: "Sarah")
//        ages.insert(value: 12, for: "Peter")
//        ages.insert(value: 23, for: "Alex")
//        
//        let node = ages[1]
//        
//        if "Peter" == node.key {
//            // Do something ...
//        }
        
//        let setA = SortedSet<Int>(elements: 1, 2, 3)
//        let setB = SortedSet<Int>(elements: 4, 3, 6)
//        let setC = SortedSet<Int>(elements: 7, 1, 2)
//        let setD = SortedSet<Int>(elements: 1, 7)
//        let setE = SortedSet<Int>(elements: 1, 6, 7)
//        
//        // Union.
//        setA + setB
//        setA.union(setB)
//        
//        // Intersection.
//        setC.intersection(setD)
//        
//        // Subset.
//        setD < setC
//        setD.isSubset(of: setC)
//        
//        // Superset.
//        setD > setC
//        setD.isSuperset(of: setC)
//        
//        // Contains.
//        setE.contains(setA.first!)
//        
//        // Probability.
//        setE.probability(of: setA.first!, setA.last!)
        
        struct Student {
            var name: String
        }
        
        let sarah = Student(name: "Sarah")
        let peter = Student(name: "Peter")
        let alex = Student(name: "Alex")
        
        var students = SortedMultiDictionary<String, Student>()
        
        students.insert(value: sarah, for: sarah.name)
        students.insert(value: peter, for: peter.name)
        students.insert(value: alex, for: alex.name)
        
        for _ in students {
            // Do something ...
        }
    }
}
