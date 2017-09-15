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

public struct RedBlackTree<Key: Comparable, Value>: Probable, Collection, BidirectionalCollection, CustomStringConvertible {
    public typealias Element = (key: Key, value: Value?)
    public typealias ProbableElement = Key
    
    /// Returns the position immediately after the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index value immediately after `i`.
    public func index(after i: Int) -> Int {
        return i + 1
    }

    public func index(before i: Int) -> Int {
        return i - 1
    }

	public typealias Iterator = AnyIterator<Element>
	
	/**
	Total number of elements within the RedBlackTree
	*/
	public internal(set) var count = 0
	
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
        return "[" + map { "\($0)" }.joined(separator: ", ") + "]"
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
     :name:    first
     :description:    Get the first node value in the tree, this is
     the first node based on the order of keys where
     k1 <= k2 <= K3 ... <= Kn
     - returns:    Element?
     */
    public var first: Element? {
        guard 0 < count else {
            return nil
        }
        
        return self[0]
    }
    
    /**
     :name:    last
     :description:    Get the last node value in the tree, this is
     the last node based on the order of keys where
     k1 <= k2 <= K3 ... <= Kn
     - returns:    Element?
     */
    public var last: Element? {
        guard 0 < count else {
            return nil
        }
        
        return self[count - 1]
    }
    
    /// Retrieves an Array of the key values in order.
    public var keys: [Key] {
        return map { $0.key }
    }
    
    /// Retrieves an Array of the values that are sorted based.
    public var values: [Value] {
        return flatMap { $0.value }
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

    public func _customIndexOfEquatableElement(_ element: Key) -> Int?? {
        return nil
    }
    
	//
	//	:name:	generate
	//	:description:	Conforms to the SequenceType Protocol. Returns
	//	the next value in the sequence of nodes using
	//	index values [0...n-1].
	//	:returns:	RedBlackTree.Generator
	//
	public func makeIterator() -> RedBlackTree.Iterator {
        var i = indices.makeIterator()
        return AnyIterator { i.next().map { self[$0] } }
	}

	/**
	Conforms to Probable protocol.
	*/
	public func count(of keys: Key...) -> Int {
        return count(of: keys)
	}

	/**
	Conforms to Probable protocol.
	*/
	public func count(of keys: [Key]) -> Int {
		var c = 0
        
		for k in keys {
			internalCount(k, node: root, count: &c)
		}
        
		return c
	}
	
	/**
	The probability of elements.
	*/
	public func probability(of keys: Key...) -> Double {
        return probability(of: keys)
	}
	
	/**
	The probability of elements.
	*/
	public func probability(of keys: [Key]) -> Double {
        return 0 == count ? 0 : Double(count(of: keys)) / Double(count)
	}
	
	/**
	The probability of elements.
	*/
	public func probability(execute block: (Key, Value?) -> Bool) -> Double {
		if 0 == count {
			return 0
		}
		
		var c = 0
		
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
	public func expectedValue(trials: Int, for keys: Key...) -> Double {
        return expectedValue(trials: trials, for: keys)
	}
	
	/**
	The expected value of elements.
	*/
	public func expectedValue(trials: Int, for keys: [Key]) -> Double {
        return Double(trials) * probability(of: keys)
	}

	/**
		:name:	insert
		:description:	Insert a key / value pair.
		- returns:	Bool
	*/
    @discardableResult
	mutating public func insert(value: Value?, for key: Key) -> Bool {
		return sentinel !== internalInsert(key, value: value)
	}
	
	/**
		:name:	insert
		:description:	Inserts a list of (Key, Value?) pairs.
		- parameter	nodes:	(Key, Value?)...	Elements to insert.
	*/
	mutating public func insert(_ nodes: (Key, Value?)...) {
        insert(nodes)
	}
	
	/**
		:name:	insert
		:description:	Inserts an array of (Key, Value?) pairs.
		- parameter	nodes:	[(Key, Value?)]	Elements to insert.
	*/
	mutating public func insert(_ nodes: [(Key, Value?)]) {
		for (k, v) in nodes {
            insert(value: v, for: k)
		}
	}

	/**
		:name:	removeValueForKeys
		:description:	Removes a node from the tree based on the key value given.
		If the tree allows non-unique keys, then all keys matching
		the given key value will be removed.
		- returns:	RedBlackTree<Key, Value>?
	*/
	mutating public func removeValue(for keys: Key...) {
        return removeValue(for: keys)
	}
	
	/**
		:name:	removeValueForKeys
		:description:	Removes a key / value pairs from the tree based on the key given.
		If the tree allows non-unique keys, then all keys matching
		the given key will be removed.
		- returns:	RedBlackTree<Key, Value>?
	*/
	mutating public func removeValue(for keys: [Key]) {
		for x in keys {
			var z = internalRemoveValueForKey(x)
            
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
    @discardableResult
	mutating public func removeInstanceValueForKey(_ key: Key) -> Value? {
		return internalRemoveValueForKey(key).value
	}
	
	/**
		:name:	removeAll
		:description:	Remove all nodes from the tree.
	*/
	mutating public func removeAll() {
		while sentinel !== root {
			internalRemoveValueForKey(root.key)
		}
	}

	/**
		:name:	updateValue
		:description:	Updates a node for the given key value.
		If the tree allows non-unique keys, then all keys matching
		the given key value will be updated.
	*/
	mutating public func update(value: Value?, for key: Key) {
		internalUpdateValue(value, for: key, node: root)
	}

	/**
		:name:	findValueForKey
		:description:	Finds the first instance in a non-unique tree and only instance
		in isUniquelyKeyed tree of a given keyed node.
		- returns:	Value?
	*/
	public func findValue(for key: Key) -> Value? {
		return internalFindNodeForKey(key).value
	}

    /**
     Returns the Key value at a given position.
     - Parameter position: An Int.
     - Returns: A Key.
     */
    public subscript(position: Int) -> Key {
        return self[position].key
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
            let x = internalSelect(root, order: index + 1)
			return (x.key, x.value)
		}
		set(element) {
			internalUpdateValue(element.value, for: element.key, node: root)
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
                update(value: value, for: key)
			}
		}
	}
	
	/**
		:name:	indexOf
		:description:	Returns the Index of a given member, or nil if the member is not present in the set.
		- returns:	Int
	*/
	public func index(of key: Key) -> Int {
		let x = internalFindNodeForKey(key)
		return sentinel === x ? -1 : internalOrder(x) - 1
	}
	
	/**
		:name:	internalInsert
		:description:	Insert a new node with the given key and value.
		- returns:	RedBlackNode<Key, Value>
	*/
	mutating private func internalInsert(_ key: Key, value: Value?) -> RedBlackNode<Key, Value> {
		if isUniquelyKeyed && sentinel !== internalFindNodeForKey(key) {
			return sentinel;
		}

		var y = sentinel
		var x = root

		while x !== sentinel {
			y = x
			y.order += 1
			x = key < x.key as Key ? x.left : x.right
		}

		let z = RedBlackNode<Key, Value>(parent: y, sentinel: sentinel, key: key, value: value)

		if y === sentinel {
			root = z
		} else if key < y.key as Key {
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
	mutating private func insertCleanUp(_ node: RedBlackNode<Key, Value>) {
		var z = node
		while z.parent.isRed {
			if z.parent === z.parent.parent.left {
				let y = z.parent.parent.right!
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
				let y = z.parent.parent.left!
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
    @discardableResult
	mutating private func internalRemoveValueForKey(_ key: Key) -> RedBlackNode<Key, Value> {
		let z = internalFindNodeForKey(key)
		if z === sentinel {
			return sentinel
		}

		if z !== root {
			var t = z.parent!
			while t !== root {
				t.order -= 1
				t = t.parent
			}
			root.order -= 1
		}

		var x: RedBlackNode<Key, Value>!
		var y = z
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
				var t = x.parent!
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
	mutating private func removeCleanUp(_ node: RedBlackNode<Key, Value>) {
		var x = node
		while x !== root && !x.isRed {
			if x === x.parent.left {
				var y = x.parent.right!
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
				var y = x.parent.left!
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
		var x = node
		var y = sentinel
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
	mutating private func transplant(_ u: RedBlackNode<Key, Value>, v: RedBlackNode<Key, Value>) {
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
	mutating private func leftRotate(_ x: RedBlackNode<Key, Value>) {
		let y = x.right!

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
	mutating private func rightRotate(_ y: RedBlackNode<Key, Value>) {
		let x = y.left!

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
		var z = root
		while z !== sentinel {
			if key == z.key {
				return z
			}
			z = key < z.key as Key ? z.left : z.right
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
        
		let r = x.left.order + 1
		
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
	private func internalUpdateValue(_ value: Value?, for key: Key, node: RedBlackNode<Key, Value>) {
		if node !== sentinel {
			if key == node.key {
				node.value = value
			}
            
			internalUpdateValue(value, for: key, node: node.left)
			internalUpdateValue(value, for: key, node: node.right)
		}
	}
	
	/**
		:name:	internalOrder
		:description:	Traverses the Tree for the internal order statistic of a key.
		- returns:	Int
	*/
	private func internalOrder(_ node: RedBlackNode<Key, Value>) -> Int {
		var x = node
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
		assert(order > startIndex || order <= endIndex, "[Algorithm Error: Order out of bounds.]")
	}
    
    public static func ==(lhs: RedBlackTree, rhs: RedBlackTree) -> Bool {
        return lhs.count == rhs.count && lhs.elementsEqual(rhs, by: { a, b -> Bool in
            return a.key == b.key
        })
    }
    
    public static func !=(lhs: RedBlackTree, rhs: RedBlackTree) -> Bool {
        return !(lhs == rhs)
    }

    public static func +(lhs: RedBlackTree, rhs: RedBlackTree) -> RedBlackTree<Key, Value> {
        var t = RedBlackTree()
        
        for (k, v) in lhs {
            t.insert(value: v, for: k)
        }
        
        for (k, v) in rhs {
            t.insert(value: v, for: k)
        }
        
        return t
    }
    
    public static func +=(lhs: inout RedBlackTree, rhs: RedBlackTree) {
        for (k, v) in rhs {
            lhs.insert(value: v, for: k)
        }
    }
    
    public static func -(lhs: RedBlackTree, rhs: RedBlackTree) -> RedBlackTree {
        var t = rhs
        
        for (k, _) in rhs {
            t.removeValue(for: k)
        }
        
        return t
    }
    
    public static func -=(lhs: inout RedBlackTree, rhs: RedBlackTree) {
        for (k, _) in rhs {
            lhs.removeValue(for: k)
        }
    }
}


