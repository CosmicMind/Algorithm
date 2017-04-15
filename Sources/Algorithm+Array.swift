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

extension Array where Element: Equatable {
	/**
     Removes a given Element from an Array if it exists.
     - Parameter object: An Element.
     - Returns: An optional Element if the removed
     element exists.
     */
    @discardableResult
    mutating func remove(object: Element) -> Element? {
      return index(of: object).map { self.remove(at: $0) }
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
