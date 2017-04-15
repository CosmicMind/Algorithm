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
