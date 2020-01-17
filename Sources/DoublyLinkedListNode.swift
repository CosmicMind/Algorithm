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

internal class DoublyLinkedListNode<Element>: CustomStringConvertible {
    /**
     :name:	next
     :description:	Points to the successor element in the DoublyLinkedList.
     - returns:	DoublyLinkedListNode<Element>?
     */
    internal var next: DoublyLinkedListNode<Element>?

    /**
     :name:	previous
     :description:	points to the predacessor element in the DoublyLinkedList.
     - returns:	DoublyLinkedListNode<Element>?
     */
    internal var previous: DoublyLinkedListNode<Element>?

    /**
     :name:	data
     :description:	Satellite data.
     - returns:	Element?
     */
    internal var element: Element?

    /**
     :name:	description
     :description:	Conforms to the Printable Protocol.
     - returns:	String
     */
    internal var description: String {
        return "\(String(describing: element))"
    }

    /**
     :name:	init
     :description:	Constructor.
     */
    internal init(next: DoublyLinkedListNode<Element>?, previous: DoublyLinkedListNode<Element>?, element: Element?) {
        self.next = next
        self.previous = previous
        self.element = element
    }
}
