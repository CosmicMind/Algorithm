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
