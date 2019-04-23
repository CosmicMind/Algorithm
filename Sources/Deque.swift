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

public struct Deque<Element>: CustomStringConvertible, Sequence {
  public typealias Iterator = AnyIterator<Element>
  
  /**
   :name:	list
   :description:	Underlying element structure.
   - returns:	DoublyLinkedList<Element>
   */
  private var list: DoublyLinkedList<Element>
  
  /**
   :name:	count
   :description:	Total number of items in the Deque.
   - returns:	Int
   */
  public var count: Int {
    return list.count
  }
  
  /**
   :name:	front
   :description:	Get the element at the front of the Deque
   and do not remove it.
   - returns:	Element?
   */
  public var front: Element? {
    return list.front
  }
  
  /**
   :name:	back
   :description:	Get the element at the back of the Deque
   and do not remove it.
   - returns:	Element?
   */
  public var back: Element? {
    return list.back
  }
  
  /**
   :name:	isEmpty
   :description:	A boolean of whether the Deque is empty.
   - returns:	Bool
   */
  public var isEmpty: Bool {
    return list.isEmpty
  }
  
  /**
   :name:	description
   :description:	Conforms to the Printable Protocol.
   - returns:	String
   */
  public var description: String {
    return list.description
  }
  
  /**
   :name:	init
   :description:	Constructor.
   */
  public init() {
    list = DoublyLinkedList<Element>()
  }
  
  /**
   Conforms to the SequenceType Protocol. Returns the next value 
   in the sequence of nodes.
   - Returns: A Deque.Iterator.
   */
  public func makeIterator() -> Deque.Iterator {
    return list.makeIterator()
  }
  
  /**
   :name:	insertAtFront
   :description:	Insert a new element at the front of the Deque.
   */
  mutating public func insert(atFront element: Element) {
    list.insert(atFront: element)
  }
  
  /**
   :name:	removeAtFront
   :description:	Get the element at the front of the Deque
   and remove it.
   - returns:	Element?
   */
  mutating public func removeAtFront() -> Element? {
    return list.removeAtFront()
  }
  
  /**
   :name:	insertAtBack
   :description:	Insert a new element at the back of the Deque.
   */
  mutating public func insert(atBack element: Element) {
    list.insert(atBack: element)
  }
  
  /**
   :name:	removeAtBack
   :description:	Get the element at the back of the Deque
   and remove it.
   - returns:	Element?
   */
  mutating public func removeAtBack() -> Element? {
    return list.removeAtBack()
  }
  
  /**
   :name:	removeAll
   :description:	Remove all elements from the Deque.
   */
  mutating public func removeAll() {
    list.removeAll()
  }
}

public func +<Element>(lhs: Deque<Element>, rhs: Deque<Element>) -> Deque<Element> {
  var d = Deque<Element>()
  for x in lhs {
    d.insert(atBack: x)
  }
  for x in rhs {
    d.insert(atBack: x)
  }
  return d
}

public func +=<Element>(lhs: inout Deque<Element>, rhs: Deque<Element>) {
  for x in rhs {
    lhs.insert(atBack: x)
  }
}
