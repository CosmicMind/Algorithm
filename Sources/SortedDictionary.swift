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

public struct SortedDictionary<Key: Comparable & Hashable, Value>: Probable, Collection, BidirectionalCollection, Equatable, CustomStringConvertible {
  public typealias Element = RedBlackTree<Key, Value>.Element
  public typealias ProbableElement = RedBlackTree<Key, Value>.ProbableElement
  
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
  
  /// Total number of elements within the RedBlackTree
  public internal(set) var count = 0
  
  /// Internal storage of (key, value) pairs.
  internal var tree: RedBlackTree<Key, Value>
  
  /// Get the data as a Dictionary.
  public var asDictionary: [Key: Value?] {
    var d = [Key: Value?]()
    for (k, v) in self {
      d[k] = v
    }
    return d
  }
  
  /// Conforms to the Printable Protocol. Outputs the
  public var description: String {
    return tree.description
  }
  
  /// Conforms to the Collection Protocol.
  public var startIndex: Int {
    return 0
  }
  
  /// Conforms to the Collection Protocol.
  public var endIndex: Int {
    return count
  }
  
  /// Retrieves an Array of the key values in order.
  public var keys: [Key] {
    return tree.keys
  }
  
  /// Retrieves an Array of the values that are sorted based
  public var values: [Value] {
    return tree.values
  }
  
  /// Initializer.
  public init() {
    tree = RedBlackTree(uniqueKeys: true)
  }
  
  /**
   Initializes with a given list of elements.
   - Parameter elements: A list of (key, value) pairs.
   */
  public init(elements: (Key, Value?)...) {
    self.init(elements: elements)
  }
  
  /**
   Initializes with a given Array of elements.
   - Parameter elements: An Array of (key, value) pairs.
   */
  public init(elements: [(Key, Value?)]) {
    self.init()
    insert(elements)
  }
  
  fileprivate init(tree : RedBlackTree<Key, Value>) {
    self.init()
    self.tree = tree
  }
  
  public func _customIndexOfEquatableElement(_ element: Key) -> Int?? {
    return nil
  }
  
  public func makeIterator() -> Iterator {
    var i = indices.makeIterator()
    return AnyIterator { i.next().map { self[$0] } }
  }
  
  /**
   Retrieves the total count of instances for the given
   keys. 
   - Parameter of keys: A list of Key types.
   - Returns: An Int.
   */
  public func count(of keys: Key...) -> Int {
    return count(of: keys)
  }
  
  /**
   Retrieves the total count of instances for the given
   keys.
   - Parameter of keys: An Array of Key types.
   - Returns: An Int.
   */
  public func count(of keys: [Key]) -> Int {
    return tree.count(of: keys)
  }
  
  /**
   Calculates the probability of the given keys.
   - Parameter of keys: A list of Key types.
   - Returns: A Double.
   */
  public func probability(of keys: Key...) -> Double {
    return probability(of: keys)
  }
  
  /**
   Calculates the probability of the given keys.
   - Parameter of keys: An Array of Key types.
   - Returns: A Double.
   */
  public func probability(of keys: [Key]) -> Double {
    return tree.probability(of: keys)
  }
  
  /**
   Calculates the probability using a block.
   - Parameter execute block: A block function to execute.
   - Returns: A Double.
   */
  public func probability(execute block: (Key, Value?) -> Bool) -> Double {
    return tree.probability(execute: block)
  }
  
  /**
   The expected value of given keys based on a number of trials.
   - Parameter trials: An Int.
   - Parameter for keys: A list of Elements.
   - Returns: A Double.
   */
  public func expectedValue(trials: Int, for keys: Key...) -> Double {
    return expectedValue(trials: trials, for: keys)
  }
  
  /**
   The expected value of given keys based on a number of trials.
   - Parameter trials: An Int.
   - Parameter for keys: A list of Elements.
   - Returns: A Double.
   */
  public func expectedValue(trials: Int, for keys: [Key]) -> Double {
    return tree.expectedValue(trials: trials, for: keys)
  }
  
  /**
   Property key mapping. If the key type is a String, this feature 
   allows access like a Dictionary.
   - Parameter key: A Key type.
   - Returns: An optional Value type.
   */
  public subscript(key: Key) -> Value? {
    get {
      return tree[key]
    }
    set(value) {
      tree[key] = value
      count = tree.count
    }
  }
  
  public subscript(position: Int) -> Key {
    return self[position].key
  }
  
  /**
   Allows Array like access of the index. Items are kept in order, 
   so when iterating through the items, they are returned in their
   ordered form.
   - Parameter index: An Int.
   - Returns:	A (key: Key, value: Value?)
   */
  public subscript(index: Int) -> (key: Key, value: Value?) {
    get {
      return tree[index]
    }
    set(value) {
      tree[index] = value
      count = tree.count
    }
  }
  
  /**
   Returns the Index of a given member, or -1 if the member is not 
   present.
   - Parameter of key: A Key type.
   - Returns:	An Int.
   */
  public func index(of key: Key) -> Int {
    return tree.index(of: key)
  }
  
  /**
   Insert a key / value pair.
   - Parameter value: An optional Value type.
   - Parameter for key: A Key type.
   - Returns:	A boolean of the result, true if inserted, false
   otherwise.
   */
  @discardableResult
  mutating public func insert(value: Value?, for key: Key) -> Bool {
    let result = tree.insert(value: value, for: key)
    count = tree.count
    return result
  }
  
  /**
   Inserts a list of key / value pairs.
   - Parameter elements: A list of (Key, Value?) tuples.
   */
  mutating public func insert(_ elements: (Key, Value?)...) {
    insert(elements)
  }
  
  /**
   Inserts an Array of key / value pairs.
   - Parameter elements: An Array of (Key, Value?) tuples.
   */
  mutating public func insert(_ elements: [(Key, Value?)]) {
    tree.insert(elements)
    count = tree.count
  }
  
  /**
   Removes key / value pairs based on the keys given.
   - Parameter for keys: A list of Key types.
   */
  mutating public func removeValue(for keys: Key...) {
    removeValue(for: keys)
  }
  
  /**
   Removes key / value pairs based on the keys given.
   - Parameter for keys: An Array of Key types.
   */
  mutating public func removeValue(for keys: [Key]) {
    tree.removeValue(for: keys)
    count = tree.count
  }
  
  /// Removes all key / value pairs.
  mutating public func removeAll() {
    tree.removeAll()
    count = tree.count
  }
  
  /**
   Updates a vlue for the given key.
   - Parameter value: An optional Value type.
   - Parameter for key: A Key type.
   */
  mutating public func update(value: Value?, for key: Key) {
    tree.update(value: value, for: key)
  }
  
  /**
   Finds the value for a given key.
   - Parameter for key: A Key type.
   - Returns: An optional Value type.
   */
  public func findValue(for key: Key) -> Value? {
    return tree.findValue(for: key)
  }
  
  /**
   Finds the value for a key which is less or equal given.
   - Parameter for key: A Key type.
   - Returns: An optional Value type.
   */
  public func findLowerEntry(for key: Key) -> Value? {
    return tree.findLowerValue(for: key)
  }
  
  /**
   Finds the value for a key which is larger or equal given.
   - Parameter for key: A Key type.
   - Returns: An optional Value type.
   */
  public func findCeilingEntry(for key: Key) -> Value? {
    return tree.findCeilingValue(for: key)
  }
  
  /**
   Searches for given keys in the SortedDictionary.
   - Parameter for keys: A list of Key types.
   - Returns: A SortedDictionary.
   */
  public func search(for keys: Key...) -> SortedDictionary<Key, Value> {
    return search(for: keys)
  }
  
  /**
   Searches for given keys in the SortedDictionary.
   - Parameter for keys: An Array of Key types.
   - Returns: A SortedDictionary.
   */
  public func search(for keys: [Key]) -> SortedDictionary<Key, Value> {
    var d = SortedDictionary<Key, Value>()
    for key in keys {
      traverse(for: key, node: tree.root, dictionary: &d)
    }
    return d
  }
  
  /**
   Traverses the SortedDictionary, looking for a key matches.
   - Parameter for key: A Key type.
   - Parameter node: A RedBlackNode<Key, Value>.
   - Parameter dictionary: A SortedDictionary to map the results too.
   */
  internal func traverse(for key: Key, node: RedBlackNode<Key, Value>, dictionary: inout SortedDictionary) {
    guard tree.sentinel !== node else {
      return
    }
    
    if key == node.key {
      dictionary.insert(value: node.value, for: key)
    }
    
    traverse(for: key, node: node.left, dictionary: &dictionary)
    traverse(for: key, node: node.right, dictionary: &dictionary)
  }
  
  static public func ==(lhs: SortedDictionary, rhs: SortedDictionary) -> Bool {
    return lhs.tree == rhs.tree
  }
  
  static public func +(lhs: SortedDictionary, rhs: SortedDictionary) -> SortedDictionary<Key, Value> {
    return SortedDictionary(tree : lhs.tree + rhs.tree)
  }
  
  static public func +=(lhs: inout SortedDictionary, rhs: SortedDictionary) {
    lhs.tree += rhs.tree
  }
  
  static public func -(lhs: SortedDictionary, rhs: SortedDictionary) -> SortedDictionary<Key, Value> {
    return SortedDictionary(tree : lhs.tree - rhs.tree)
  }
  
  static public func -=(lhs: inout SortedDictionary, rhs: SortedDictionary) {
    lhs.tree -= rhs.tree
  }
}

