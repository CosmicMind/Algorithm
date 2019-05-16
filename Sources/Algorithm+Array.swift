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

extension Array where Element: Equatable {
  /**
   Removes a given Element from an Array if it exists.
   - Parameter object: An Element.
   - Returns: An optional Element if the removed
   element exists.
   */
  @discardableResult
  mutating func remove(object: Element) -> Element? {
    return firstIndex(of: object).map { self.remove(at: $0) }
  }
  
  /**
   Removes a list of given Elements from an Array if
   they exists.
   - Parameter objects: A list of Elements.
   */
  mutating func remove(objects: Element...) {
    remove(objects: objects)
  }
  
  /**
   Removes an Array of given Elements from an Array if
   they exists.
   - Parameter objects: An Array of Elements.
   */
  mutating func remove(objects: [Element]) {
    objects.forEach {
      self.remove(object: $0)
    }
  }
  
  /**
   The total count for the given Elements.
   - Parameter of elements: A list of Elements.
   - Returns: An Int.
   */
  public func count(of elements: Element...) -> Int {
    return count(of: elements)
  }
  
  /**
   The total count for the given Elements.
   - Parameter of elements: An Array of Elements.
   - Returns: An Int.
   */
  public func count(of elements: [Element]) -> Int {
    
    var c = 0
    for e in elements {
      for x in self where e == x {
        c += 1
      }
    }
    return c
  }
  
  /**
   The probability of getting the given Elements.
   - Parameter of elements: A list of Elements.
   - Returns: A Double.
   */
  public func probability(of elements: Element...) -> Double {
    return probability(of: elements)
  }
  
  /**
   The probability of getting the given Elements.
   - Parameter of elements: An Array of Elements.
   - Returns: A Double.
   */
  public func probability(of elements: [Element]) -> Double {
    return 0 < count ? Double(count(of: elements)) / Double(count) : 0
  }
  
  /**
   A probability method that uses a block to determine the member state of a condition.
   - Parameter of elements: A list of Elements.
   - Returns: A Double.
   */
  public func probability(execute block: @escaping (Element) -> Bool) -> Double {
    guard 0 < count else {
      return 0
    }
    
    var c = 0
    for e in self {
      if block(e) {
        c += 1
      }
    }
    
    return Double(c) / Double(count)
  }
  
  /**
   Calculates the expected value of elements based on a given number of trials.
   - Parameter trials: Number of trials.
   - Parameter elements: A list of Elements.
   - Returns: A Double.
   */
  public func expectedValue(trials: Int, for elements: Element...) -> Double {
    return expectedValue(trials: trials, for: elements)
  }
  
  /**
   Calculates the expected value of elements based on a given number of trials.
   - Parameter trials: Number of trials.
   - Parameter elements: An Array of Elements.
   - Returns: A Double.
   */
  public func expectedValue(trials: Int, for elements: [Element]) -> Double {
    return Double(trials) * probability(of: elements)
  }
}
