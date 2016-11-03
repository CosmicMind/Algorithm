![CosmicMind](http://www.cosmicmind.com/algorithm/index/images/AlgorithmIcon.png)

## Welcome to Algorithm

Algorithm is a collection of data structures that are empowered by a probability toolset.

Algorithm's architecture is designed for beginners and professionals. Its robust API requires no setup and is ready for the simplest and most extensive applications.

## Requirements

* iOS 8.0+ / Mac OS X 10.9+
* Xcode 7.3+

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

## A Tour  

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
let die: Array<Int> = Array<Int>(arrayLiteral: 1, 2, 3, 4, 5, 6)
print(die.probabilityOf(3)) // Output: 0.166666666666667
```

#### Conditional Probability

For conditional probabilities that require a more complex calculation, use block statements.

```swift
let die: Array<Int> = Array<Int>(arrayLiteral: 1, 2, 3, 4, 5, 6)

let probabilityOfX: Double = die.probabilityOf { (number: Int) in
	if 5 < number || 0 == number % 3 {
		// Do more.
		return true
	}
	return false
}

if 0.33 < probabilityOfX {
	// Do something.
}
```

<a name="expectedvalue"></a>
## Expected Value

The expected value of rolling a 3 or 6 with 100 trials using a die of 6 numbers.

```swift
let die: Array<Int> = Array<Int>(arrayLiteral: 1, 2, 3, 4, 5, 6)
print(die.expectedValueOf(100, elements: 3, 6)) // Output: 33.3333333333333
```

<a name="doublylinkedlist"></a>
## DoublyLinkedList

The DoublyLinkedList data structure is excellent for large growing collections of data. Below is an example of its usage.

```swift
let listA: DoublyLinkedList<Int> = DoublyLinkedList<Int>()
listA.insertAtFront(3)
listA.insertAtFront(2)
listA.insertAtFront(1)

let listB: DoublyLinkedList<Int> = DoublyLinkedList<Int>()
listB.insertAtBack(4)
listB.insertAtBack(5)
listB.insertAtBack(6)

let listC: DoublyLinkedList<Int> = listA + listB

listC.cursorToFront()
repeat {
	print(listC.cursor)
} while nil != listC.next
// Output:
// 1
// 2
// 3
// 4
// 5
// 6
```

<a name="stack"></a>
## Stack

The Stack data structure is a container of objects that are inserted and removed according to the last-in-first-out (LIFO) principle. Below is an example of its usage.

```swift
let stack: Stack<Int> = Stack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)

while !stack.isEmpty {
	print(stack.pop())
}
// Output:
// 3
// 2
// 1
```

<a name="queue"></a>
## Queue

The Queue data structure is a container of objects that are inserted and removed according to the first-in-first-out (FIFO) principle. Below is an example of its usage.

```swift
let queue: Queue<Int> = Queue<Int>()
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)

while !queue.isEmpty {
	print(queue.dequeue())
}
// Output:
// 1
// 2
// 3
```

<a name="deque"></a>
## Deque

The Deque data structure is a container of objects that are inserted and removed according to the first-in-first-out (FIFO) and last-in-first-out (LIFO) principle. Essentially, a Deque is a Stack and Queue combined. Below are examples of its usage.

```swift
let dequeA: Deque<Int> = Deque<Int>()
dequeA.insertAtBack(1)
dequeA.insertAtBack(2)
dequeA.insertAtBack(3)

while !dequeA.isEmpty {
	print(dequeA.removeAtFront())
}
// Output:
// 1
// 2
// 3

let dequeB: Deque<Int> = Deque<Int>()
dequeB.insertAtBack(4)
dequeB.insertAtBack(5)
dequeB.insertAtBack(6)

while !dequeB.isEmpty {
	print(dequeB.removeAtBack())
}
// Output:
// 6
// 5
// 4
```

<a name="redblacktree"></a>
## RedBlackTree

A RedBlackTree is a Balanced Binary Search Tree that maintains insert, remove, update, and search operations in a complexity of O(logn). The following implementation of a RedBlackTree also includes an order-statistic, which allows the data structure to be accessed using subscripts like an array or dictionary. RedBlackTrees may store unique keys or non-unique key values. Below is an example of its usage.

```swift
let rbA: RedBlackTree<Int, Int> = RedBlackTree<Int, Int>(uniqueKeys: true)

for var i: Int = 1000; 0 < i; --i {
	rbA.insert(1, value: 1)
	rbA.insert(2, value: 2)
	rbA.insert(3, value: 3)
}
print(rbA.count) // Output: 3
```

<a name="sortedset"></a>
## SortedSet

SortedSets are a powerful data structure for algorithm and analysis design. Elements within a SortedSet are unique and insert, remove, and search operations have a complexity of O(logn). The following implementation of a SortedSet also includes an order-statistic, which allows the data structure to be accessed using an index subscript like an array. Below are examples of its usage.

```swift
let setA: SortedSet<Int> = SortedSet<Int>(elements: 1, 2, 3) // Sorted: [1, 2, 3]
let setB: SortedSet<Int> = SortedSet<Int>(elements: 4, 3, 6) // Sorted: [3, 4, 6]

let setC: SortedSet<Int> = SortedSet<Int>(elements: 7, 1, 2) // Sorted: [1, 2, 7]
let setD: SortedSet<Int> = SortedSet<Int>(elements: 1, 7) // Sorted: [1, 7]

let setE: SortedSet<Int> = SortedSet<Int>(elements: 1, 6, 7) // Sorted: [1, 6, 7]

// Union.
print((setA + setB).count) // Output: 5
print(setA.union(setB).count) // Output: 5

// Intersect.
print(setC.intersect(setD).count) // Output: 2

// Subset.
print(setD < setC) // true
print(setD.isSubsetOf(setC)) // true

// Superset.
print(setD > setC) // false
print(setD.isSupersetOf(setC)) // false

// Contains.
print(setE.contains(setA.first!)) // true

// Probability.
print(setE.probabilityOf(setA.first!, setA.last!)) // 0.333333333333333
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

let dict: SortedMultiDictionary<String, Student> = SortedMultiDictionary<String, Student>()

// Do something with an alphabetically SortedMultiDictionary of Student structs.
for student in students {
	dict.insert(student.name, value: student)
}
```

## License

Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.com>. All rights reserved.

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
