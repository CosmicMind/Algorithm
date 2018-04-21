![Algorithm](http://www.cosmicmind.com/algorithm/github/algorithm-logo.png)

## Welcome to Algorithm

Algorithm is a library of tools that is used to create intelligent applications.

## Features

- [x] Probability Tools 
- [x] Expected Value
- [x] Programmable Probability Blocks
- [x] Array Extensions
- [x] Set Extensions

## Data Structures

- [x] DoublyLinkedList
- [x] Stack
- [x] Queue
- [x] Deque
- [x] RedBlackTree
- [x] SortedSet
- [x] SortedMultiSet
- [x] SortedDictionary
- [x] SortedMultiDictionary

## Requirements

* iOS 8.0+ / Mac OS X 10.9+
* Xcode 8.0+

## Communication

- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/cosmicmind). (Tag 'cosmicmind')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/cosmicmind).
- If you **found a bug**, _and can provide steps to reliably reproduce it_, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

> **Embedded frameworks require a minimum deployment target of iOS 8 or OS X Mavericks (10.9).**
> - [Download Algorithm](https://github.com/CosmicMind/Algorithm/archive/master.zip)

Visit the [Installation](https://github.com/CosmicMind/Algorithm/wiki/Installation) page to learn how to install Algorithm using [CocoaPods](http://cocoapods.org) and [Carthage](https://github.com/Carthage/Carthage).

## Changelog

Algorithm is a growing project and will encounter changes throughout its development. It is recommended that the [Changelog](https://github.com/CosmicMind/Algorithm/wiki/Changelog) be reviewed prior to updating versions.

# Samples

The following are samples to see how Algorithm may be used within your applications.

* Visit the [Samples](https://github.com/CosmicMind/Samples) repo to see example projects using Algorithm.

* [Probability](#probability)
* [ExpectedValue](#expectedvalue)
* [DoublyLinkedList](#doublylinkedlist)
* [Stack](#stack)
* [Queue](#queue)
* [Deque](#deque)
* [RedBlackTree](#redblacktree)
* [SortedSet](#sortedset)
* [SortedMultiSet](#sortedmultiset)
* [SortedDictionary](#sorteddictionary)
* [SortedMultiDictionary](#sortedmultidictionary)

<a name="probability"></a>
## Probability

Each data structure within Algorithm is equipped with probability tools.

#### Basic Probability

For example, determining the probability of rolling a 3 using a die of 6 numbers.

```swift
let die = [Int](arrayLiteral: 1, 2, 3, 4, 5, 6)

if 0.1 < die.probability(of: 3) 
		// Do something ...
}
```

#### Conditional Probability

For conditional probabilities that require a more complex calculation, use block statements.

```swift
let die = [Int](arrayLiteral: 1, 2, 3, 4, 5, 6)

let pOfX = die.probability { (number) in
	return 5 < number || 0 == number % 3
}

if 0.33 < pOfX {
	// Do something ...
}
```

<a name="expectedvalue"></a>
## Expected Value

The expected value of rolling a 3 or 6 with 100 trials using a die of 6 numbers.

```swift
let die = [Int](arrayLiteral: 1, 2, 3, 4, 5, 6)

if 20 < die.expectedValue(trials: 100, for: 3, 6) {
		// Do something ...
}
```

<a name="doublylinkedlist"></a>
## DoublyLinkedList

The DoublyLinkedList data structure is excellent for large growing collections of data. Below is an example of its usage.

```swift
var listA = DoublyLinkedList<Int>()
        
listA.insert(atFront: 3)
listA.insert(atFront: 2)
listA.insert(atFront: 1)

var listB = DoublyLinkedList<Int>()

listB.insert(atBack: 4)
listB.insert(atBack: 5)
listB.insert(atBack: 6)

var listC = listA + listB

listC.cursorToFront()

var value = listC.cursor

while nil != value {
    // Do something ...
    
    value = listC.next()
}
```

<a name="stack"></a>
## Stack

The Stack data structure is a container of objects that are inserted and removed according to the last-in-first-out (LIFO) principle. Below is an example of its usage.

```swift
var stack = Stack<Int>()

stack.push(1)
stack.push(2)
stack.push(3)

while !stack.isEmpty {
	let value = stack.pop()
	
	// Do something ...
}
```

<a name="queue"></a>
## Queue

The Queue data structure is a container of objects that are inserted and removed according to the first-in-first-out (FIFO) principle. Below is an example of its usage.

```swift
var queue = Queue<Int>()

queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)

while !queue.isEmpty {
    let value = queue.dequeue()

    // Do something ...
}
```

<a name="deque"></a>
## Deque

The Deque data structure is a container of objects that are inserted and removed according to the first-in-first-out (FIFO) and last-in-first-out (LIFO) principle. Essentially, a Deque is a Stack and Queue combined. Below are examples of its usage.

```swift
var dequeA = Deque<Int>()
dequeA.insert(atBack: 1)
dequeA.insert(atBack: 2)
dequeA.insert(atBack: 3)

while !dequeA.isEmpty {
	let value = dequeA.removeAtFront()
	
	// Do something ...
}

var dequeB = Deque<Int>()
dequeB.insert(atBack: 4)
dequeB.insert(atBack: 5)
dequeB.insert(atBack: 6)

while !dequeB.isEmpty {
	let value = dequeB.removeAtFront()
	
	// Do something ...
}
```

<a name="redblacktree"></a>
## RedBlackTree

A RedBlackTree is a Balanced Binary Search Tree that maintains insert, remove, update, and search operations in a complexity of O(logn). The following implementation of a RedBlackTree also includes an order-statistic, which allows the data structure to be accessed using subscripts like an array or dictionary. RedBlackTrees may store unique keys or non-unique key values. Below is an example of its usage.

```swift
var ages = RedBlackTree<String, Int>(uniqueKeys: true)

ages.insert(value: 16, for: "Sarah")
ages.insert(value: 12, for: "Peter")
ages.insert(value: 23, for: "Alex")

let node = ages[1]

if "Peter" == node.key {
    // Do something ...
}
```

<a name="sortedset"></a>
## SortedSet

SortedSets are a powerful data structure for algorithm and analysis design. Elements within a SortedSet are unique and insert, remove, and search operations have a complexity of O(logn). The following implementation of a SortedSet also includes an order-statistic, which allows the data structure to be accessed using an index subscript like an array. Below are examples of its usage.

```swift
let setA = SortedSet<Int>(elements: 1, 2, 3)
let setB = SortedSet<Int>(elements: 4, 3, 6)
let setC = SortedSet<Int>(elements: 7, 1, 2)
let setD = SortedSet<Int>(elements: 1, 7)
let setE = SortedSet<Int>(elements: 1, 6, 7)

// Union.
setA + setB
setA.union(setB)

// Intersection.
setC.intersection(setD)

// Subset.
setD < setC
setD.isSubset(of: setC)

// Superset.
setD > setC
setD.isSuperset(of: setC)

// Contains.
setE.contains(setA.first!)

// Probability.
setE.probability(of: setA.first!, setA.last!)
```

<a name="sortedmultiset"></a>
## SortedMultiSet

A SortedMultiSet is identical to a SortedSet, except that a SortedMultiSet allows non-unique elements. Look at [SortedSet](#sortedset) for examples of its usage.

<a name="sorteddictionary"></a>
## SortedDictionary

A SortedDictionary is a powerful data structure that maintains a sorted set of keys with value pairs. Keys within a SortedDictionary are unique and insert, remove, update, and search operations have a complexity of O(logn).

<a name="sortedmultidictionary"></a>
## SortedMultiDictionary

A SortedMultiDictionary is identical to a SortedDictionary, except that a SortedMultiDictionary allows non-unique keys. Below is an example of its usage.

```swift
struct Student {
    var name: String
}

let sarah = Student(name: "Sarah")
let peter = Student(name: "Peter")
let alex = Student(name: "Alex")

var students = SortedMultiDictionary<String, Student>()

students.insert(value: sarah, for: sarah.name)
students.insert(value: peter, for: peter.name)
students.insert(value: alex, for: alex.name)

for student in students {
    // Do something ...
}
```

## License

Copyright (C) 2015 - 2018, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.com>. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

*   Redistributions of source code must retain the above copyright notice, this     
    list of conditions and the following disclaimer.

*   Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

*   Neither the name of CosmicMind nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
