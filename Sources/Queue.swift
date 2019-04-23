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

public struct Queue<Element>: CustomStringConvertible, Sequence {
  public typealias Iterator = AnyIterator<Element>
  
  /**
   :name:	list
   :description:	Underlying data structure.
   - returns:	DoublyLinkedList<Element>
   */
  private var list: DoublyLinkedList<Element>
  
  /**
   :name:	count
   :description:	Total number of items in the Queue.
   - returns:	Int
   */
  public var count: Int {
    return list.count
  }
  
  /**
   :name:	peek
   :description:	Get the element at the front of
   the Queue, and do not remove it.
   - returns:	Element?
   */
  public var peek: Element? {
    return list.front
  }
  
  /**
   :name:	isEmpty
   :description:	A boolean of whether the Queue is empty.
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
    list = DoublyLinkedList()
  }
  
  //
  //	:name:	generate
  //	:description:	Conforms to the SequenceType Protocol. Returns
  //	the next value in the sequence of nodes.
  //	:returns:	Queue.Generator
  //
  public func makeIterator() -> Iterator {
    return list.makeIterator()
  }
  
  /**
   :name:	enqueue
   :description:	Insert a new element at the back of the Queue.
   */
  mutating public func enqueue(_ element: Element) {
    list.insert(atBack: element)
  }
  
  /**
   :name:	dequeue
   :description:	Get and remove the element at the front
   of the Queue.
   - returns:	Element?
   */
  mutating public func dequeue() -> Element? {
    return list.removeAtFront()
  }
  
  /**
   :name:	removeAll
   :description:	Remove all elements from the Queue.
   */
  mutating public func removeAll() {
    list.removeAll()
  }
  
  public static func +(lhs: Queue, rhs: Queue) -> Queue<Element> {
    var q = Queue<Element>()
    for x in lhs {
      q.enqueue(x)
    }
    for x in rhs {
      q.enqueue(x)
    }
    return q
  }
  
  public static func +=(lhs: inout Queue, rhs: Queue) {
    for x in rhs {
      lhs.enqueue(x)
    }
  }
}
