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

internal class RedBlackNode<Key: Comparable, Value>: Comparable, Equatable, CustomStringConvertible {
  /**
   :name:	parent
   :description:	A reference to the parent node of a given node.
   - returns:	RedBlackNode!
   */
  internal var parent: RedBlackNode!
  
  /**
   :name:	left
   :description:	A reference to the left child node of a given node.
   - returns:	RedBlackNode!
   */
  internal var left: RedBlackNode!
  
  /**
   :name:	right
   :description:	A reference to the right child node of a given node.
   - returns:	RedBlackNode!
   */
  internal var right: RedBlackNode!
  
  /**
   :name:	isRed
   :description:	A boolean indicating whether te node is marked isRed or black.
   - returns:	Bool
   */
  internal var isRed: Bool
  
  /**
   :name:	order
   :description:	Used to track the order statistic of a node, which maintains
   key order in the tree.
   - returns:	Int
   */
  internal var order: Int
  
  /**
   :name:	key
   :description:	A reference to the key value of the node, which is what organizes
   a node in a given tree.
   - returns:	Key!
   */
  internal var key: Key!
  
  /**
   :name:	value
   :description:	Satellite data stoisRed in the node.
   - returns:	Value?
   */
  internal var value: Value?
  
  /**
   :name:	description
   :description:	Conforms to the Printable Protocol.
   - returns:	String
   */
  internal var description: String {
    return "(\(String(describing: key)), \(String(describing: value)))"
  }
  
  /**
   :name:	init
   :description:	Constructor used for sentinel nodes.
   */
  internal init() {
    isRed = false
    order = 0
  }
  
  /**
   :name:	init
   :description:	Constructor used for nodes that store data.
   */
  internal init(parent: RedBlackNode, sentinel: RedBlackNode, key: Key, value: Value?) {
    self.key = key
    self.value = value
    self.parent = parent
    left = sentinel
    right = sentinel
    isRed = true
    order = 1
  }
  
  static func ==(lhs: RedBlackNode, rhs: RedBlackNode) -> Bool {
    return lhs.key == rhs.key
  }
  
  static func <(lhs: RedBlackNode, rhs: RedBlackNode) -> Bool {
    return lhs.key < rhs.key
  }
}


