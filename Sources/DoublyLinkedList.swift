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

public struct DoublyLinkedList<Element>: CustomStringConvertible, Sequence {
    public typealias Iterator = AnyIterator<Element>

	/**
     First node in the list.
     - Returns: An optional DoublyLinkedListNode<Element>.
     */
	private var head: DoublyLinkedListNode<Element>?

	/**
     Last node in list.
     - Returns: An optional DoublyLinkedListNode<Element>.
     */
	private var tail: DoublyLinkedListNode<Element>?

	/**
     Current cursor position when iterating.
     - Returns: An optional DoublyLinkedListNode<Element>.
     */
	private var current: DoublyLinkedListNode<Element>?

	/**
     Number of nodes in DoublyLinkedList.
     - Returns:	An Int.
     */
	public private(set) var count: Int

	/**
     Conforms to Printable Protocol.
     - Returns: A String.
     */
	public var description: String {
        var output = "("
        var c = 0
        var x = head
        while nil !== x {
            output += "\(String(describing: x))"
            c += 1
            if c != count {
                output += ", "
            }
            x = x!.next
        }
        output += ")"
        return output
	}

	/**
     Retrieves the data at first node of the DoublyLinkedList.
     - Returns:	An optional Element.
     */
	public var front: Element? {
		return head?.element
	}

	/**
     Retrieves the element at the back node of teh DoublyLinkedList.
     - Returns: An optional Element.
	*/
	public var back: Element? {
		return tail?.element
	}

	/**
     Retrieves the element at the current iterator position
     in the DoublyLinkedList.
     - Returns:	An optional Element.
     */
	public var cursor: Element? {
		return current?.element
	}

	/**
     A boolean of whether the DoublyLinkedList is empty.
     - Returns: A boolean indicating if the DoubleLinkedList is
     empty or not, true if yes, false otherwise.
     */
	public var isEmpty: Bool {
		return 0 == count
	}

	/**
     A boolean of whether the cursor has reached the back of the 
     DoublyLinkedList.
     - Returns: A boolean indicating if the cursor is pointing at 
     the back Element, true if yes, false otherwise.
     */
	public var isCursorAtBack: Bool {
		return nil == cursor
	}

    /**
     A boolean of whether the cursor has reached the front of the
     DoublyLinkedList.
     - Returns: A boolean indicating if the cursor is pointing at
     the front Element, true if yes, false otherwise.
     */
    public var isCursorAtFront: Bool {
		return nil == cursor
	}

    /// An initializer.
	public init() {
		count = 0
		reset()
	}
    
    /**
     Retrieves the element at the poistion after the
     current cursor poistion. Also moves the cursor
     to that node.
     - Returns:	An optional Element.
     */
    @discardableResult
    mutating public func next() -> Element? {
        current = current?.next
        return current?.element
    }
    
    /**
     Retrieves the element at the poistion before the
     current cursor poistion. Also moves the cursor
     to that node.
     - Returns:	An optional Element.
     */
    @discardableResult
    mutating public func previous() -> Element? {
        current = current?.previous
        return current?.element
    }

    /**
     Conforms to the SequenceType Protocol. Returns the next value
     in the sequence of nodes.
     - Returns: A DoublyLinkedList.Iterator.
     */
    public func makeIterator() -> DoublyLinkedList.Iterator {
        var it = head
        return AnyIterator {
          defer {
            it = it?.next
          }
          return it?.element
		}
	}

    /// Removes all nodes from the DoublyLinkedList.
    mutating public func removeAll() {
		while !isEmpty {
			_ = removeAtFront()
		}
	}

	/**
     Inserts a new Element at the front of the DoublyLinkedList.
     - Parameter atFront: An Element.
     */
	mutating public func insert(atFront element: Element) {
		var z: DoublyLinkedListNode<Element>
		if 0 == count {
			z = DoublyLinkedListNode<Element>(next: nil, previous: nil,  element: element)
			tail = z
		} else {
			z = DoublyLinkedListNode<Element>(next: head, previous: nil, element: element)
			head!.previous = z
		}
		head = z
		count += 1
		if 1 == count {
			current = head
		} else if head === current {
			current = head!.next
		}
	}

	/**
     Removes the element at the front position.
     - Returns: An optional Element.
     */
    @discardableResult
	mutating public func removeAtFront() -> Element? {
		if 0 == count {
			return nil
		}
		let element: Element? = head!.element
		count -= 1
		if 0 == count {
			reset()
		} else {
			head = head!.next
		}
		return element
	}

    /**
     Inserts a new Element at the back of the DoublyLinkedList.
     - Parameter atBack: An Element.
     */
    mutating public func insert(atBack element: Element) {
		var z: DoublyLinkedListNode<Element>
		if 0 == count {
			z = DoublyLinkedListNode<Element>(next: nil, previous: nil,  element: element)
			head = z
		} else {
			z = DoublyLinkedListNode<Element>(next: nil, previous: tail, element: element)
			tail!.next = z
		}
		tail = z
		count += 1
		if 1 == count {
			current = tail
		} else if tail === current {
			current = tail!.previous
		}
	}

    /**
     Removes the element at the back position.
     - Returns: An optional Element.
     */
    @discardableResult
	mutating public func removeAtBack() -> Element? {
		if 0 == count {
			return nil
		}
		let element = tail?.element
		count -= 1
		if 0 == count {
			reset()
		} else {
			tail = tail?.previous
		}
		return element
	}

	/// Move the cursor to the front of the DoublyLinkedList.
	mutating public func cursorToFront() {
		current = head
	}

	/// Move the cursor to the back of the DoublyLinkedList.
	mutating public func cursorToBack() {
		current = tail
	}

	/**
     Inserts a new Element before the cursor position.
     - Parameter beforeCursor element: An Element.
     */
	mutating public func insert(beforeCursor element: Element) {
		if nil == current || head === current {
            insert(atFront: element)
		} else {
			let z = DoublyLinkedListNode<Element>(next: current, previous: current!.previous,  element: element)
			current!.previous?.next = z
			current!.previous = z
			count += 1
		}
	}

    /**
     Inserts a new Element after the cursor position.
     - Parameter afterCursor element: An Element.
     */
    mutating public func insert(afterCursor element: Element) {
		if nil == current || tail === current {
            insert(atBack: element)
		} else {
			let z = DoublyLinkedListNode<Element>(next: current!.next, previous: current,  element: element)
			current!.next?.previous = z
			current!.next = z
			count += 1
		}
	}

	/**
     Removes the element at the cursor position.
     - Returns: An optional Element.
     */
    @discardableResult
	mutating public func removeAtCursor() -> Element? {
		if 1 >= count {
			return removeAtFront()
		} else {
			let element = current?.element
			current?.previous?.next = current?.next
			current?.next?.previous = current?.previous
			if tail === current {
				current = tail?.previous
				tail = current
			} else if head === current {
				current = head?.next
				head = current
			} else {
				current = current?.next
			}
			count -= 1
			return element
		}
	}

	/**
     Removes all elements and resets the head, tail, and cursor 
     to the sentinel value.
     */
	mutating private func reset() {
		head = nil
		tail = nil
		current = nil
	}
}

public func +<Element>(lhs: DoublyLinkedList<Element>, rhs: DoublyLinkedList<Element>) -> DoublyLinkedList<Element> {
	var l = DoublyLinkedList<Element>()
	for x in lhs {
        l.insert(atBack: x)
	}
	for x in rhs {
        l.insert(atBack: x)
	}
	return l
}

public func +=<Element>(lhs: inout DoublyLinkedList<Element>, rhs: DoublyLinkedList<Element>) {
	for x in rhs {
        lhs.insert(atBack: x)
	}
}
