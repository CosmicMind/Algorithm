/*
* Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.io>. 
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

public class RedBlackTree<Key: Comparable, Value>: ProbableType, Collection, CustomStringConvertible {
    /// Returns the position immediately after the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    public func index(after i: Int) -> Int {
        return i < endIndex ? i + 1 : 0
    }

	public typealias Iterator = AnyIterator<(key: Key, value: Value?)>
	
	/**
	Total number of elements within the RedBlackTree
	*/
	public internal(set) var count: Int = 0
	
	/**
		:name:	sentinel
		:description:	A node used to mark the end of a path in the tree.
		- returns:	RedBlackNode<Key, Value>
	*/
	internal private(set) var sentinel: RedBlackNode<Key, Value>

	/**
		:name:	root
		:description:	The root of the tree data structure.
		- returns:	RedBlackNode<Key, Value>
	*/
	internal private(set) var root: RedBlackNode<Key, Value>

	/**
		:name:	internalDescription
		:description:	Returns a String with only the node data for all
		nodes in the Tree.
		- returns:	String
	*/
	internal var internalDescription: String {
		var output: String = "["
		let l: Int = count - 1
		for i in 0..<count {
			output += "\(self[i])"
			if i != l {
				output += ", "
			}
		}
		return output + "]"
	}

	/**
		:name:	isUniquelyKeyed
		:description:	A boolean used to indicate whether to allow the
		tree to store non-unique key values or only unique
		key values.
		- returns:	Bool
	*/
	public private(set) var isUniquelyKeyed: Bool
	
	/**
		:name:	description
		:description:	Conforms to the Printable Protocol. Outputs the
		data in the Tree in a readable format.
		- returns:	String
	*/
	public var description: String {
		return internalDescription
	}

	/**
		:name:	first
		:description:	Get the first node value in the tree, this is
		the first node based on the order of keys where
		k1 <= k2 <= Key3 ... <= Keyn
		- returns:	(key: Key, value: Value?)?
	*/
	public var first: (key: Key, value: Value?)? {
		return isEmpty ? nil : self[0]
	}

	/**
		:name:	last
		:description:	Get the last node value in the tree, this is
		the last node based on the order of keys where
		k1 <= k2 <= Key3 ... <= Keyn
		- returns:	(key: Key, value: Value?)?
	*/
	public var last: (key: Key, value: Value?)? {
		return isEmpty ? nil : self[count - 1]
	}

	/**
		:name:	isEmpty
		:description:	A boolean of whether the RedBlackTree is empty.
		- returns:	Bool
	*/
	public var isEmpty: Bool {
		return 0 == count
	}

	/**
		:name:	startIndex
		:description:	Conforms to the CollectionType Protocol.
		- returns:	Int
	*/
	public var startIndex: Int {
		return 0
	}

	/**
		:name:	endIndex
		:description:	Conforms to the CollectionType Protocol.
		- returns:	Int
	*/
	public var endIndex: Int {
		return count
	}
	
	/**
		:name:	init
		:description:	Constructor where the tree is guaranteed to store
		non-unique keys.
	*/
	public init() {
		isUniquelyKeyed = false
		sentinel = RedBlackNode<Key, Value>()
		root = sentinel
	}

	/**
		:name:	init
		:description:	Constructor where the tree is optionally allowed
		to store uniqe or non-unique keys.
		- parameter	uniqueKeys:	Bool	Set the keys to be unique.
	*/
	public init(uniqueKeys: Bool) {
		isUniquelyKeyed = uniqueKeys
		sentinel = RedBlackNode<Key, Value>()
		root = sentinel
	}

	//
	//	:name:	generate
	//	:description:	Conforms to the SequenceType Protocol. Returns
	//	the next value in the sequence of nodes using
	//	index values [0...n-1].
	//	:returns:	RedBlackTree.Generator
	//
	public func makeIterator() -> RedBlackTree.Iterator {
		var index = startIndex
		return AnyIterator {
			if index < self.endIndex {
				let i: Int = index
				index += 1
				return self[i]
			}
			return nil
		}
	}

	/**
	Conforms to ProbableType protocol.
	*/
	public func count<T: Equatable>(of keys: T...) -> Int {
        return count(of: keys)
	}

	/**
	Conforms to ProbableType protocol.
	*/
	public func count<T: Equatable>(of keys: Array<T>) -> Int {
		var c: Int = 0
		for key in keys {
			internalCount(key as! Key, node: root, count: &c)
		}
		return c
	}
	
	/**
	The probability of elements.
	*/
	public func probability<T: Equatable>(of elements: T...) -> Double {
        return probability(of: elements)
	}
	
	/**
	The probability of elements.
	*/
	public func probability<T: Equatable>(of elements: Array<T>) -> Double {
        return 0 == count ? 0 : Double(count(of: elements)) / Double(count)
	}
	
	/**
	The probability of elements.
	*/
	public func probability(_ block: (Key, Value?) -> Bool) -> Double {
		if 0 == count {
			return 0
		}
		
		var c: Int = 0
		for (k, v) in self {
			if block(k, v) {
				c += 1
			}
		}
		return Double(c) / Double(count)
	}
	
	/**
	The expected value of elements.
	*/
	public func expectedValue<T: Equatable>(trials: Int, elements: T...) -> Double {
        return expectedValue(trials: trials, elements: elements)
	}
	
	/**
	The expected value of elements.
	*/
	public func expectedValue<T: Equatable>(trials: Int, elements: Array<T>) -> Double {
        return Double(trials) * probability(of: elements)
	}

	/**
		:name:	insert
		:description:	Insert a key / value pair.
		- returns:	Bool
	*/
	public func insert(_ key: Key, value: Value?) -> Bool {
		return sentinel !== internalInsert(key, value: value)
	}
	
	/**
		:name:	insert
		:description:	Inserts a list of (Key, Value?) pairs.
		- parameter	nodes:	(Key, Value?)...	Elements to insert.
	*/
	public func insert(_ nodes: (Key, Value?)...) {
		insert(nodes)
	}
	
	/**
		:name:	insert
		:description:	Inserts an array of (Key, Value?) pairs.
		- parameter	nodes:	Array<(Key, Value?)>	Elements to insert.
	*/
	public func insert(_ nodes: Array<(Key, Value?)>) {
		for (k, v) in nodes {
			_ = insert(k, value: v)
		}
	}

	/**
		:name:	removeValueForKeys
		:description:	Removes a node from the tree based on the key value given.
		If the tree allows non-unique keys, then all keys matching
		the given key value will be removed.
		- returns:	RedBlackTree<Key, Value>?
	*/
	public func removeValueForKeys(_ keys: Key...) {
		return removeValueForKeys(keys)
	}
	
	/**
		:name:	removeValueForKeys
		:description:	Removes a key / value pairs from the tree based on the key given.
		If the tree allows non-unique keys, then all keys matching
		the given key will be removed.
		- returns:	RedBlackTree<Key, Value>?
	*/
	public func removeValueForKeys(_ keys: Array<Key>) {
		for x in keys {
			var z: RedBlackNode<Key, Value> = internalRemoveValueForKey(x)
			while sentinel !== z {
				z = internalRemoveValueForKey(x)
			}
		}
	}

	/**
		:name:	removeValueForKey
		:description:	Removes a single instance of a value for a key. This is
		important when using non-unique keys.
		- returns:	Value?
	*/
	public func removeInstanceValueForKey(_ key: Key) -> Value? {
		return internalRemoveValueForKey(key).value
	}
	
	/**
		:name:	removeAll
		:description:	Remove all nodes from the tree.
	*/
	public func removeAll() {
		while sentinel !== root {
			_ = internalRemoveValueForKey(root.key)
		}
	}

	/**
		:name:	updateValue
		:description:	Updates a node for the given key value.
		If the tree allows non-unique keys, then all keys matching
		the given key value will be updated.
	*/
	public func updateValue(_ value: Value?, forKey: Key) {
		internalUpdateValue(value, forKey: forKey, node: root)
	}

	/**
		:name:	findValueForKey
		:description:	Finds the first instance in a non-unique tree and only instance
		in isUniquelyKeyed tree of a given keyed node.
		- returns:	Value?
	*/
	public func findValueForKey(_ key: Key) -> Value? {
		return internalFindNodeForKey(key).value
	}

	/**
		:name:	operator [0...count - 1]
		:description:	Allows array like access of the index.
		Items are kept in order, so when iterating
		through the items, they are returned in their
		ordeisRed form.
		- returns:	(key: Key, value: Value?)
	*/
	public subscript(index: Int) -> (key: Key, value: Value?) {
		get {
			let x: RedBlackNode<Key, Value> = internalSelect(root, order: index + 1)
			return (x.key, x.value)
		}
		set(element) {
			internalUpdateValue(element.value, forKey: element.key, node: root)
		}
	}
	
	/**
		:name:	operator ["key1"..."keyN"]
		:description:	Property key mapping. If the key type is a
		String, this feature allows access like a
		Dictionary.
		- returns:	Value?
	*/
	public subscript(key: Key) -> Value? {
		get {
			return internalFindNodeForKey(key).value
		}
		set(value) {
			if sentinel === internalFindNodeForKey(key) {
				_ = internalInsert(key, value: value)
			} else {
				updateValue(value, forKey: key)
			}
		}
	}
	
	/**
		:name:	indexOf
		:description:	Returns the Index of a given member, or nil if the member is not present in the set.
		- returns:	Int
	*/
	public func indexOf(_ key: Key) -> Int {
		let x: RedBlackNode<Key, Value> = internalFindNodeForKey(key)
		return sentinel === x ? -1 : internalOrder(x) - 1
	}
	
	/**
		:name:	internalInsert
		:description:	Insert a new node with the given key and value.
		- returns:	RedBlackNode<Key, Value>
	*/
	private func internalInsert(_ key: Key, value: Value?) -> RedBlackNode<Key, Value> {
		if isUniquelyKeyed && sentinel !== internalFindNodeForKey(key) {
			return sentinel;
		}

		var y: RedBlackNode<Key, Value> = sentinel
		var x: RedBlackNode<Key, Value> = root

		while x !== sentinel {
			y = x
			y.order += 1
			x = key < x.key ? x.left : x.right
		}

		let z: RedBlackNode<Key, Value> = RedBlackNode<Key, Value>(parent: y, sentinel: sentinel, key: key, value: value)

		if y === sentinel {
			root = z
		} else if key < y.key {
			y.left = z
		} else {
			y.right = z
		}

		insertCleanUp(z)
		count += 1
		return z
	}

	/**
		:name:	insertCleanUp
		:description:	The clean up procedure needed to maintain the RedBlackTree balance.
		- returns:	RedBlackNode<Key, Value>
	*/
	private func insertCleanUp(_ node: RedBlackNode<Key, Value>) {
		var z: RedBlackNode<Key, Value> = node
		while z.parent.isRed {
			if z.parent === z.parent.parent.left {
				let y: RedBlackNode<Key, Value> = z.parent.parent.right
				// violation 1, parent child relationship re to isRed
				if y.isRed {
					z.parent.isRed = false
					y.isRed = false
					z.parent.parent.isRed = true
					z = z.parent.parent
				} else {
					// case 2, parent is isRed, uncle is black
					if z === z.parent.right {
						z = z.parent
						leftRotate(z)
					}
					// case 3, balance colours
					z.parent.isRed = false
					z.parent.parent.isRed = true
					rightRotate(z.parent.parent)
				}
			} else {
				// symetric
				let y: RedBlackNode<Key, Value> = z.parent.parent.left
				// violation 1, parent child relationship re to isRed
				if y.isRed {
					z.parent.isRed = false
					y.isRed = false
					z.parent.parent.isRed = true
					z = z.parent.parent
				} else {
					// case 2, parent is isRed, uncle is black
					if z === z.parent.left {
						z = z.parent
						rightRotate(z)
					}
					// case 3, balance colours
					z.parent.isRed = false
					z.parent.parent.isRed = true
					leftRotate(z.parent.parent)
				}
			}
		}
		root.isRed = false
	}

	/**
		:name:	internalRemoveValueForKey
		:description:	Removes a node with the given key value and returns that
		node. If the value does not exist, the sentinel is returned.
		- returns:	RedBlackNode<Key, Value>
	*/
	private func internalRemoveValueForKey(_ key: Key) -> RedBlackNode<Key, Value> {
		let z: RedBlackNode<Key, Value> = internalFindNodeForKey(key)
		if z === sentinel {
			return sentinel
		}

		if z !== root {
			var t: RedBlackNode<Key, Value> = z.parent
			while t !== root {
				t.order -= 1
				t = t.parent
			}
			root.order -= 1
		}


		var x: RedBlackNode<Key, Value>!
		var y: RedBlackNode<Key, Value> = z
		var isRed: Bool = y.isRed

		if z.left === sentinel {
			x = z.right
			transplant(z, v: z.right)
		} else if z.right === sentinel {
			x = z.left
			transplant(z, v: z.left)
		} else {
			y = minimum(z.right)
			isRed = y.isRed
			x = y.right
			if y.parent === z {
				x.parent = y
			} else {
				transplant(y, v: y.right)
				y.right = z.right
				y.right.parent = y
				var t: RedBlackNode<Key, Value> = x.parent
				while t !== y {
					t.order -= 1
					t = t.parent
				}
				y.order = y.left.order + 1
			}
			transplant(z, v: y)
			y.left = z.left
			y.left.parent = y
			y.isRed = z.isRed
			y.order = y.left.order + y.right.order + 1
		}
		if !isRed {
			removeCleanUp(x)
		}
		count -= 1
		return z
	}

	/**
		:name:	removeCleanUp
		:description:	After a successful removal of a node, the RedBlackTree
		is rebalanced by this method.
	*/
	private func removeCleanUp(_ node: RedBlackNode<Key, Value>) {
		var x: RedBlackNode<Key, Value> = node
		while x !== root && !x.isRed {
			if x === x.parent.left {
				var y: RedBlackNode<Key, Value> = x.parent.right
				if y.isRed {
					y.isRed = false
					x.parent.isRed = true
					leftRotate(x.parent)
					y = x.parent.right
				}
				if !y.left.isRed && !y.right.isRed {
					y.isRed = true
					x = x.parent
				} else {
					if !y.right.isRed {
						y.left.isRed = false
						y.isRed = true
						rightRotate(y)
						y = x.parent.right
					}
					y.isRed = x.parent.isRed
					x.parent.isRed = false
					y.right.isRed = false
					leftRotate(x.parent)
					x = root
				}
			} else { // symetric left and right
				var y: RedBlackNode<Key, Value> = x.parent.left
				if y.isRed {
					y.isRed = false
					x.parent.isRed = true
					rightRotate(x.parent)
					y = x.parent.left
				}
				if !y.right.isRed && !y.left.isRed {
					y.isRed = true
					x = x.parent
				} else {
					if !y.left.isRed {
						y.right.isRed = false
						y.isRed = true
						leftRotate(y)
						y = x.parent.left
					}
					y.isRed = x.parent.isRed
					x.parent.isRed = false
					y.left.isRed = false
					rightRotate(x.parent)
					x = root
				}
			}
		}
		x.isRed = false
	}

	/**
		:name:	minimum
		:description:	Finds the minimum keyed node.
		- returns:	RedBlackNode<Key, Value>
	*/
	private func minimum(_ node: RedBlackNode<Key, Value>) -> RedBlackNode<Key, Value> {
		var x: RedBlackNode<Key, Value> = node
		var y: RedBlackNode<Key, Value> = sentinel
		while x !== sentinel {
			y = x
			x = x.left
		}
		return y
	}

	/**
		:name:	transplant
		:description:	Swaps two subTrees in the tree.
	*/
	private func transplant(_ u: RedBlackNode<Key, Value>, v: RedBlackNode<Key, Value>) {
		if u.parent === sentinel {
			root = v
		} else if u === u.parent.left {
			u.parent.left = v
		} else {
			u.parent.right = v
		}
		v.parent = u.parent
	}

	/**
		:name:	leftRotate
		:description:	Rotates the nodes to satisfy the RedBlackTree
		balance property.
	*/
	private func leftRotate(_ x: RedBlackNode<Key, Value>) {
		let y: RedBlackNode<Key, Value> = x.right

		x.right = y.left
		if sentinel !== y.left {
			y.left.parent = x
		}

		y.parent = x.parent

		if sentinel === x.parent {
			root = y
		} else if x === x.parent.left {
			x.parent.left = y
		} else {
			x.parent.right = y
		}

		y.left = x
		x.parent = y
		y.order = x.order
		x.order = x.left.order + x.right.order + 1
	}

	/**
		:name:	rightRotate
		:description:	Rotates the nodes to satisfy the RedBlackTree
		balance property.
	*/
	private func rightRotate(_ y: RedBlackNode<Key, Value>) {
		let x: RedBlackNode<Key, Value> = y.left

		y.left = x.right
		if sentinel !== x.right {
			x.right.parent = y
		}

		x.parent = y.parent

		if sentinel === y.parent {
			root = x
		} else if y === y.parent.right {
			y.parent.right = x
		} else {
			y.parent.left = x
		}

		x.right = y
		y.parent = x
		x.order = y.order
		y.order = y.left.order + y.right.order + 1
	}

	/**
		:name:	internalFindNodeForKey
		:description:	Finds a node with a given key value.
		- returns:	RedBlackNode<Key, Value>
	*/
	private func internalFindNodeForKey(_ key: Key) -> RedBlackNode<Key, Value> {
		var z: RedBlackNode<Key, Value> = root
		while z !== sentinel {
			if key == z.key {
				return z
			}
			z = key < z.key ? z.left : z.right
		}
		return sentinel
	}

	/**
		:name:	internalSelect
		:description:	Internally searches for a node by the order statistic value.
		- returns:	RedBlackNode<Key, Value>
	*/
	private func internalSelect(_ x: RedBlackNode<Key, Value>, order: Int) -> RedBlackNode<Key, Value> {
		validateOrder(order)
		let r: Int = x.left.order + 1
		if order == r {
			return x
		} else if order < r {
			return internalSelect(x.left, order: order)
		}
		return internalSelect(x.right, order: order - r)
	}

	/**
		:name:	internalCount
		:description:	Traverses the Tree while counting number of times a key appears.
	*/
	private func internalCount(_ key: Key, node: RedBlackNode<Key, Value>, count: inout Int) {
		if sentinel !== node {
			if key == node.key {
				count += 1
			}
			internalCount(key, node: node.left, count: &count)
			internalCount(key, node: node.right, count: &count)
		}
	}
	
	/**
		:name:	internalUpdateValue
		:description:	Traverses the Tree and updates all the values that match the key.
	*/
	private func internalUpdateValue(_ value: Value?, forKey: Key, node: RedBlackNode<Key, Value>) {
		if node !== sentinel {
			if forKey == node.key {
				node.value = value
			}
			internalUpdateValue(value, forKey: forKey, node: node.left)
			internalUpdateValue(value, forKey: forKey, node: node.right)
		}
	}
	
	/**
		:name:	internalOrder
		:description:	Traverses the Tree for the internal order statistic of a key.
		- returns:	Int
	*/
	private func internalOrder(_ node: RedBlackNode<Key, Value>) -> Int {
		var x: RedBlackNode<Key, Value> = node
		var r: Int = x.left.order + 1
		while root !== x {
			if x.parent.right === x {
				r += x.parent.left.order + 1
			}
			x = x.parent
		}
		return r
	}

	/**
		:name:	validateOrder
		:description:	Validates the order statistic being within range of 1...n.
	*/
	private func validateOrder(_ order: Int) {
		assert(order >= startIndex || order < endIndex, "[Algorithm Error: Order out of bounds.]")
	}
}

public func ==<Key : Comparable, Value>(lhs: RedBlackTree<Key, Value>, rhs: RedBlackTree<Key, Value>) -> Bool {
    if lhs.count != rhs.count {
		return false
	}
	for i in 0..<lhs.count {
		if lhs[i].key != rhs[i].key {
			return false
		}
	}
	return true
}

public func !=<Key : Comparable, Value>(lhs: RedBlackTree<Key, Value>, rhs: RedBlackTree<Key, Value>) -> Bool {
	return !(lhs == rhs)
}

public func +<Key : Comparable, Value>(lhs: RedBlackTree<Key, Value>, rhs: RedBlackTree<Key, Value>) -> RedBlackTree<Key, Value> {
	let t: RedBlackTree<Key, Value> = lhs
	for (k, v) in rhs {
		_ = t.insert(k, value: v)
	}
	return t
}

public func +=<Key : Comparable, Value>(lhs: RedBlackTree<Key, Value>, rhs: RedBlackTree<Key, Value>) {
	for (k, v) in rhs {
		_ = lhs.insert(k, value: v)
	}
}

public func -<Key : Comparable, Value>(lhs: RedBlackTree<Key, Value>, rhs: RedBlackTree<Key, Value>) -> RedBlackTree<Key, Value> {
	let t: RedBlackTree<Key, Value> = rhs
	for (k, _) in rhs {
		t.removeValueForKeys(k)
	}
	return t
}

public func -=<Key : Comparable, Value>(lhs: RedBlackTree<Key, Value>, rhs: RedBlackTree<Key, Value>) {
	for (k, _) in rhs {
		lhs.removeValueForKeys(k)
	}
}
