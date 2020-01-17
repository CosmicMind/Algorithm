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

public struct SortedSet<T: Comparable>: Probable, Collection, Equatable, CustomStringConvertible where T: Hashable {
    public typealias Element = T

    /// Returns the position immediately after the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    public func index(after i: Int) -> Int {
        return i < endIndex ? i + 1 : 0
    }

    public typealias Iterator = AnyIterator<Element>

    /**
     Total number of elements within the RedBlackTree
     */
    public internal(set) var count = 0

    /**
     :name:	tree
     :description:	Internal storage of elements.
     - returns:	RedBlckTree<Element, Element>
     */
    internal var tree: RedBlackTree<Element, Element>

    /**
     :name:	asArray
     */
    public var asArray: [Element] {
        return map { $0 }
    }

    /**
     :name:	description
     :description:	Conforms to the Printable Protocol. Outputs the
     data in the SortedSet in a readable format.
     - returns:	String
     */
    public var description: String {
        return "[" + map { "\($0)" }.joined(separator: ",") + "]"
    }

    /**
     :name:	first
     :description:	Get the first node value in the tree, this is
     the first node based on the order of keys where
     k1 <= k2 <= K3 ... <= Kn
     - returns:	Element?
     */
    public var first: Element? {
        return tree.first?.value
    }

    /**
     :name:	last
     :description:	Get the last node value in the tree, this is
     the last node based on the order of keys where
     k1 <= k2 <= K3 ... <= Kn
     - returns:	Element?
     */
    public var last: Element? {
        return tree.last?.value
    }

    /**
     :name:	startIndex
     :description:	Conforms to the Collection Protocol.
     - returns:	Int
     */
    public var startIndex: Int {
        return 0
    }

    /**
     :name:	endIndex
     :description:	Conforms to the Collection Protocol.
     - returns:	Int
     */
    public var endIndex: Int {
        return count
    }

    /**
     :name:	init
     :description:	Constructor.
     */
    public init() {
        tree = RedBlackTree<Element, Element>(uniqueKeys: true)
    }

    /**
     :name:	init
     :description:	Constructor.
     */
    public init(elements: Element...) {
        self.init(elements: elements)
    }

    /**
     :name:	init
     :description:	Constructor.
     */
    public init(elements: [Element]) {
        self.init()
        insert(elements)
    }

    public func makeIterator() -> SortedSet.Iterator {
        var i = indices.makeIterator()
        return AnyIterator { i.next().map { self[$0] } }
    }

    /**
     Conforms to Probable protocol.
     */
    public func count(of elements: Element...) -> Int {
        return count(of: elements)
    }

    /**
     Conforms to Probable protocol.
     */
    public func count(of elements: [Element]) -> Int {
        return tree.count(of: elements)
    }

    /**
     The probability of elements.
     */
    public func probability(of elements: Element...) -> Double {
        return probability(of: elements)
    }

    /**
     The probability of elements.
     */
    public func probability(of elements: [Element]) -> Double {
        return tree.probability(of: elements)
    }

    /**
     The probability of elements.
     */
    public func probability(execute block: (Element) -> Bool) -> Double {
        return tree.probability { (k, _) -> Bool in
            block(k)
        }
    }

    /**
     The expected value of elements.
     */
    public func expectedValue(trials: Int, for elements: Element...) -> Double {
        return expectedValue(trials: trials, for: elements)
    }

    /**
     The expected value of elements.
     */
    public func expectedValue(trials: Int, for elements: [Element]) -> Double {
        return tree.expectedValue(trials: trials, for: elements)
    }

    /**
     :name:	operator [0...count - 1]
     :description:	Allows array like access of the index.
     Items are kept in order, so when iterating
     through the items, they are returned in their
     ordered form.
     - returns:	Element
     */
    public subscript(index: Int) -> Element {
        return tree[index].key
    }

    /**
     :name:	indexOf
     :description:	Returns the Index of a given member, or -1 if the member is not present in the set.
     - returns:	Int
     */
    public func index(of element: Element) -> Int {
        return tree.index(of: element)
    }

    /**
     :name:	contains
     :description:	A boolean check if values exists
     in the set.
     - returns:	Bool
     */
    public func contains(_ elements: Element...) -> Bool {
        return contains(elements)
    }

    /**
     :name:	contains
     :description:	A boolean check if an array of values exist
     in the set.
     - returns:	Bool
     */
    public func contains(_ elements: [Element]) -> Bool {
        if elements.count == 0 {
            return false
        }
        for x in elements {
            if tree.findValue(for: x) == nil {
                return false
            }
        }
        return true
    }

    /**
     :name:	insert
     :description:	Inserts new elements into the SortedSet.
     */
    public mutating func insert(_ elements: Element...) {
        insert(elements)
    }

    /**
     :name:	insert
     :description:	Inserts new elements into the SortedSet.
     */
    public mutating func insert(_ elements: [Element]) {
        for x in elements {
            tree.insert(value: x, for: x)
        }
        count = tree.count
    }

    /**
     :name:	remove
     :description:	Removes elements from the SortedSet.
     */
    public mutating func remove(_ elements: Element...) {
        remove(elements)
    }

    /**
     :name:	remove
     :description:	Removes elements from the SortedSet.
     */
    public mutating func remove(_ elements: [Element]) {
        tree.removeValue(for: elements)
        count = tree.count
    }

    /**
     :name:	removeAll
     :description:	Remove all nodes from the tree.
     */
    public mutating func removeAll() {
        tree.removeAll()
        count = tree.count
    }

    /**
     :name:	intersect
     :description:	Return a new set with elements common to this set and a finite sequence of Sets.
     - returns:	SortedSet<Element>
     */
    public func intersection(_ other: SortedSet<Element>) -> SortedSet<Element> {
        var s = SortedSet<Element>()
        var i = 0
        var j = 0
        let k = count
        let l = other.count
        while k > i, l > j {
            let x = self[i]
            let y = other[j]
            if x < y {
                i += 1
            } else if y < x {
                j += 1
            } else {
                s.insert(x)
                i += 1
                j += 1
            }
        }
        return s
    }

    /**
     :name:	formIntersection
     :description:	Insert elements of a finite sequence of Sets.
     */
    public mutating func formIntersection(_ other: SortedSet<Element>) {
        let l = other.count
        if l == 0 {
            removeAll()
        } else {
            var i = 0
            var j = 0
            while count > i, l > j {
                let x = self[i]
                let y = other[j]
                if x < y {
                    remove(x)
                } else if y < x {
                    j += 1
                } else {
                    i += 1
                    j += 1
                }
            }
        }
    }

    /**
     :name:	union
     :description:	Return a new Set with items in both this set and a finite sequence of Sets.
     - returns:	SortedSet<Element>
     */
    public func union(_ other: SortedSet<Element>) -> SortedSet<Element> {
        var s = SortedSet<Element>()
        var i = 0
        var j = 0
        let k = count
        let l = other.count
        while k > i, l > j {
            let x = self[i]
            let y = other[j]
            if x < y {
                s.insert(x)
                i += 1
            } else if y < x {
                s.insert(y)
                j += 1
            } else {
                s.insert(x)
                i += 1
                j += 1
            }
        }
        while k > i {
            s.insert(self[i])
            i += 1
        }
        while l > j {
            s.insert(other[j])
            j += 1
        }
        return s
    }

    /**
     :name:	unionInPlace
     :description:	Return a new Set with items in both this set and a finite sequence of Sets.
     */
    public mutating func formUnion(_ other: SortedSet<Element>) {
        var a = [Element]()
        other.forEach {
            a.append($0)
        }
        insert(a)
    }

    /**
     :name:	subtract
     :description:	Return a new set with elements in this set that do not occur in a finite sequence of Sets.
     - returns:	SortedSet<Element>
     */
    public func subtracting(_ other: SortedSet<Element>) -> SortedSet<Element> {
        var s = SortedSet<Element>()
        var i = 0
        var j = 0
        let k = count
        let l = other.count
        while k > i, l > j {
            let x = self[i]
            let y = other[j]
            if x < y {
                s.insert(x)
                i += 1
            } else if y < x {
                j += 1
            } else {
                i += 1
                j += 1
            }
        }
        while k > i {
            s.insert(self[i])
            i += 1
        }
        return s
    }

    /**
     :name:	subtract
     :description:	Remove all elements in the set that occur in a finite sequence of Sets.
     */
    public mutating func subtract(_ other: SortedSet<Element>) {
        var i = 0
        var j = 0
        let l = other.count
        while count > i, l > j {
            let x = self[i]
            let y = other[j]
            if x < y {
                i += 1
            } else if y < x {
                j += 1
            } else {
                remove(x)
                j += 1
            }
        }
    }

    /**
     :name:	exclusiveOr
     :description:	Return a new set with elements that are either in the set or a finite sequence but do not occur in both.
     - returns:	SortedSet<Element>
     */
    public func symmetricDifference(_ other: SortedSet<Element>) -> SortedSet<Element> {
        var s = SortedSet<Element>()
        var i = 0
        var j = 0
        let k = count
        let l = other.count
        while k > i, l > j {
            let x = self[i]
            let y = other[j]
            if x < y {
                s.insert(x)
                i += 1
            } else if y < x {
                s.insert(y)
                j += 1
            } else {
                i += 1
                j += 1
            }
        }
        while k > i {
            s.insert(self[i])
            i += 1
        }
        while l > j {
            s.insert(other[j])
            j += 1
        }
        return s
    }

    /**
     :name:	exclusiveOrInPlace
     :description:	For each element of a finite sequence, remove it from the set if it is a
     common element, otherwise add it to the set. Repeated elements of the sequence will be
     ignored.
     */
    public mutating func formSymmetricDifference(_ other: SortedSet<Element>) {
        var i = 0
        var j = 0
        let l = other.count
        while count > i, l > j {
            let x = self[i]
            let y = other[j]
            if x < y {
                i += 1
            } else if y < x {
                insert(y)
                j += 1
            } else {
                remove(x)
                j += 1
            }
        }
        while l > j {
            insert(other[j])
            j += 1
        }
    }

    /**
     :name:	isDisjointWith
     :description:	Returns true if no elements in the set are in a finite sequence of Sets.
     - returns:	Bool
     */
    public func isDisjoint(with other: SortedSet<Element>) -> Bool {
        var i = count - 1
        var j = other.count - 1
        while i >= 0, j >= 0 {
            let x = self[i]
            let y = other[j]
            if x < y {
                j -= 1
            } else if y < x {
                i -= 1
            } else {
                return false
            }
        }
        return true
    }

    /**
     :name:	isSubsetOf
     :description:	Returns true if the set is a subset of a finite sequence as a Set.
     - returns:	Bool
     */
    public func isSubset(of other: SortedSet<Element>) -> Bool {
        if count > other.count {
            return false
        }
        for x in self {
            if !other.contains(x) {
                return false
            }
        }
        return true
    }

    /**
     :name:	isStrictSubsetOf
     :description:	Returns true if the set is a subset of a finite sequence as a Set but not equal.
     - returns:	Bool
     */
    public func isStrictSubset(of other: SortedSet<Element>) -> Bool {
        return count < other.count && isSubset(of: other)
    }

    /**
     :name:	isSupersetOf
     :description:	Returns true if the set is a superset of a finite sequence as a Set.
     - returns:	Bool
     */
    public func isSuperset(of other: SortedSet<Element>) -> Bool {
        if count < other.count {
            return false
        }
        for x in other {
            if !contains(x) {
                return false
            }
        }
        return true
    }

    /**
     :name:	isStrictSupersetOf
     :description:	Returns true if the set is a superset of a finite sequence as a Set but not equal.
     - returns:	Bool
     */
    public func isStrictSuperset(of other: SortedSet<Element>) -> Bool {
        return count > other.count && isSuperset(of: other)
    }
}

public func == <Element>(lhs: SortedSet<Element>, rhs: SortedSet<Element>) -> Bool {
    if lhs.count != rhs.count {
        return false
    }
    for i in 0 ..< lhs.count {
        if lhs[i] != rhs[i] {
            return false
        }
    }
    return true
}

public func != <Element>(lhs: SortedSet<Element>, rhs: SortedSet<Element>) -> Bool {
    return !(lhs == rhs)
}

public func + <Element>(lhs: SortedSet<Element>, rhs: SortedSet<Element>) -> SortedSet<Element> {
    return lhs.union(rhs)
}

public func += <Element>(lhs: inout SortedSet<Element>, rhs: SortedSet<Element>) {
    lhs.formUnion(rhs)
}

public func - <Element>(lhs: SortedSet<Element>, rhs: SortedSet<Element>) -> SortedSet<Element> {
    return lhs.subtracting(rhs)
}

public func -= <Element>(lhs: inout SortedSet<Element>, rhs: SortedSet<Element>) {
    lhs.subtract(rhs)
}

public func <= <Element>(lhs: SortedSet<Element>, rhs: SortedSet<Element>) -> Bool {
    return lhs.isSubset(of: rhs)
}

public func >= <Element>(lhs: SortedSet<Element>, rhs: SortedSet<Element>) -> Bool {
    return lhs.isSuperset(of: rhs)
}

public func > <Element>(lhs: SortedSet<Element>, rhs: SortedSet<Element>) -> Bool {
    return lhs.isStrictSuperset(of: rhs)
}

public func < <Element>(lhs: SortedSet<Element>, rhs: SortedSet<Element>) -> Bool {
    return lhs.isStrictSubset(of: rhs)
}
