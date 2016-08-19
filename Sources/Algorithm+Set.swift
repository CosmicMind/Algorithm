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

extension Set: ProbableType {
    /**
     The total count for the given Elements.
     - Parameter of elements: A list of Elements.
     - Returns: An Int.
     */
    public func count<Element: Equatable>(of elements: Element...) -> Int {
        return count(of: elements)
    }
    
    /**
     The total count for the given Elements.
     - Parameter of elements: An Array of Elements.
     - Returns: An Int.
     */
    public func count<Element: Equatable>(of elements: [Element]) -> Int {
        var c: Int = 0
        for v in elements {
            for x in self {
                if v == x as! Element {
                    c += 1
                }
            }
        }
        return c
    }
    
    /**
     The probability of getting the given Elements.
     - Parameter of elements: A list of Elements.
     - Returns: A Double.
     */
    public func probability<Element: Equatable>(of elements: Element...) -> Double {
        return probability(of: elements)
    }
    
    /**
     The probability of getting the given Elements.
     - Parameter of elements: An Array of Elements.
     - Returns: A Double.
     */
    public func probability<Element: Equatable>(of elements: [Element]) -> Double {
        guard 0 < count else {
            return 0
        }
        
        return Double(count(of: elements)) / Double(count)
    }
    
    /**
     A probability method that uses a block to determine the member state of a condition.
     - Parameter of elements: A list of Elements.
     - Returns: A Double.
     */
    public func probability(of block: (Element) -> Bool) -> Double {
        guard 0 < count else {
            return 0
        }
        
        var c: Int = 0
        for x in self {
            if block(x) {
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
    public func expectedValue<Element: Equatable>(trials: Int, elements: Element...) -> Double {
        return expectedValue(trials: trials, elements: elements)
    }
    
    /**
     Calculates the expected value of elements based on a given number of trials.
     - Parameter trials: Number of trials.
     - Parameter elements: An Array of Elements.
     - Returns: A Double.
     */
    public func expectedValue<Element: Equatable>(trials: Int, elements: [Element]) -> Double {
        return Double(trials) * probability(of: elements)
    }
}
