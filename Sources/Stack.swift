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

public struct Stack<Element>: CustomStringConvertible, Sequence {
  public typealias Iterator = AnyIterator<Element>
  
  /// Underlying data structure.
  private var list: DoublyLinkedList<Element>
  
  /// Total number of items in the Stack.
  public var count: Int {
    return list.count
  }
  
  /// Get the latest element at the top of the Stack and do not remove it.
  public var top: Element? {
    return list.front
  }
  
  /// A boolean of whether the Stack is empty.
  public var isEmpty: Bool {
    return list.isEmpty
  }
  
  /// Conforms to the Printable Protocol.
  public var description: String {
    return list.description
  }
  
  /// Initializer.
  public init() {
    list = DoublyLinkedList<Element>()
  }
  
  /**
   Conforms to the SequenceType Protocol. Returns the next value in the
   sequence of nodes.
   - Returns:	Stack.Generator
   */
  public func makeIterator() -> Stack.Iterator {
    return list.makeIterator()
  }
  
  /**
   Insert a new element at the top of the Stack.
   - Parameter _ element: An Element type.
   */
  mutating public func push(_ element: Element) {
    list.insert(atFront: element)
  }
  
  /**
   Get the latest element at the top of the Stack and remove it from
   the Stack.
   - Returns:	Element?
   */
  mutating public func pop() -> Element? {
    return list.removeAtFront()
  }
  
  /// Remove all elements from the Stack.
  mutating public func removeAll() {
    list.removeAll()
  }
}

public func +<Element>(lhs: Stack<Element>, rhs: Stack<Element>) -> Stack<Element> {
  var s = Stack<Element>()
  for x in lhs {
    s.push(x)
  }
  for x in rhs {
    s.push(x)
  }
  return s
}

public func +=<Element>(lhs: inout Stack<Element>, rhs: Stack<Element>) {
  for x in rhs {
    lhs.push(x)
  }
}
