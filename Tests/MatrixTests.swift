/*
 * Copyright (C) 2015 - 2018, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.com>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *    *    Redistributions of source code must retain the above copyright notice, this
 *        list of conditions and the following disclaimer.
 *
 *    *    Redistributions in binary form must reproduce the above copyright notice,
 *        this list of conditions and the following disclaimer in the documentation
 *        and/or other materials provided with the distribution.
 *
 *    *    Neither the name of CosmicMind nor the names of its
 *        contributors may be used to endorse or promote products derived from
 *        this software without specific prior written permission.
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

import XCTest
@testable import Algorithm

class MatrixTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMatrix() {
        
        let data = [1,2,3,4,5,6]
        var matrix1 = Matrix.init(rows: 3, columns: 2, data: data)
        
        /// Print Matrix 1's size
        print(matrix1.size)

        /// Print Matrix 1's description
        print(matrix1.description)
        /*
         Matrix
         1 , 2
         3 , 4
         5 , 6
         */
    
        /// Test Two Ways to transpose a matrix
        // (1)
        let matrix2 = matrix1.transpose_copy()
        
        // (2)
        matrix1.transpose()

        /// Test if matrix 1 is equal to matrix 2
        XCTAssert(matrix1 == matrix2)

        /// Print the transpose matrix
        print(matrix1.description)
        
        /*
         Matrix
         1 3 5
         2 4 6
         */
        
        /// Prints the 2nd row
        print(matrix1.row(index: 1))
        /*
         [2 4 6]
        */
        
        /// Prints the 3rd column
        print(matrix1.column(index: 2))
        /*
         [5,6]
         */
        
        let matrix3 = Matrix.init(rows: 2, columns: 2, data: [1,0,0,1])
        XCTAssert(matrix3.isDiagonal)
        XCTAssert(matrix3.isSquare)

    }
    
    func testMatrixOperations() {
        
        let data = [1.0,2.0,3.0,4.0,5.0,6.0]
        let matrix1 = Matrix.init(rows: 3, columns: 2, data: data)
        let matrix2 = Matrix.init(rows: 2, columns: 3, data: data)

        print(matrix1.description)
        print(matrix2.description)
        print((matrix1 + matrix1).description)
        print((matrix1 - matrix1).description)
        print((matrix1 * matrix2).description)
        print((matrix1 / matrix1).description)

        
        
    }

    
    func testPerformance() {
        self.measure() {}
    }
}
