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

internal protocol Probable {
    associatedtype ProbableElement: Equatable
    
	/**
     The instance count of elements.
     - Parameter of elements: A list of ProbableElements
     - Returns:	An Int.
     */
	func count(of elements: ProbableElement...) -> Int
	
    /**
     The instance count of elements.
     - Parameter of elements: An Array of ProbableElements.
     - Returns:	An Int.
     */
    func count(of elements: [ProbableElement]) -> Int
	
	/**
     The probability of given elements.
     - Parameter of elements: A list of ProbableElements.
     - Returns:	A Double.
     */
	func probability(of elements: ProbableElement...) -> Double
	
    /**
     The probability of given elements.
     - Parameter of elements: An Array of ProbableElements.
     - Returns:	A Double.
     */
    func probability(of elements: [ProbableElement]) -> Double
	
	/**
     The expected value of given elements based on a number of trials.
     - Parameter trials: An Int.
     - Parameter for elements: A list of ProbableElements.
     - Returns: A Double.
     */
	func expectedValue(trials: Int, for elements: ProbableElement...) -> Double
	
    /**
     The expected value of given elements based on a number of trials.
     - Parameter trials: An Int.
     - Parameter for elements: An Array of ProbableElements.
     - Returns: A Double.
     */
    func expectedValue(trials: Int, for elements: [ProbableElement]) -> Double
}
