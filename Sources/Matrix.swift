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

import Foundation

public struct Matrix<T: Arithmetic> {
    
    private(set) var rows : Int
    private(set) var columns : Int
    
    internal var data: [T]
    
    init(rows: Int, columns: Int, data: [T]) {
        self.rows = rows
        self.columns = columns
        self.data = data
    }
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.data = Array.init(repeating: T.zero, count: rows * columns)
    }
    
    /**
     :name:    size
     :description:    returns a tuple with number of rows and columns
     - returns:    (Int, Int)
     */
    public var size : (row: Int, column: Int) {
        return (rows,columns)
    }
    
    subscript(row: Int, column: Int) -> T {
        get {
            precondition(validIndex(row: row, column: column), MatrixError.invalid.localizedDescription)
            return self.data[(row * columns) + column]
        }
        set {
            precondition(validIndex(row: row, column: column ), MatrixError.invalid.localizedDescription)
            self.data[(row * columns) + column] = newValue
        }
    }
    
    /**
     :name:    validIndex
     :description:    asserts that the (row,col) index is valid
     - returns:    Bool
     */
    private func validIndex(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    /**
     :name:    column
     :description:    gets the column using the index
     - returns:    [Arithmetic]
     */
    func row(index: Int) -> [T] {
        precondition(validIndex(row: index, column: 0), MatrixError.invalid.localizedDescription)
        let row = Array(data[(index * columns)..<(index * columns) + columns])
        return row
    }
    
    /**
     :name:    column
     :description:    gets the column using the index
     - returns:    [Arithmetic]
     */
    func column(index: Int) -> [T] {
        assert(validIndex(row: 0, column: index), MatrixError.invalid.localizedDescription)
        let column = (0..<rows).map { (currentRow) -> T in
            let currentColumnIndex = currentRow * columns + index
            return data[currentColumnIndex]
        }
        return column
    }
    
    /**
     :name:    transpose
     :description:    mutates self to become the transpose matrix
     - returns:    Void
     */
    mutating func transpose() {
        var trans = Matrix.init(rows: self.columns, columns: self.rows, data: self.data)
        for row in 0..<trans.rows {
            for col in 0..<trans.columns {
                trans[row,col] = self[col, row]
            }
        }
        self = trans
    }
    
    /**
     :name:    transpose_copy
     :description:    creates a copy of transpose matrix
     - returns:    Matrix<T: Numeric>
     */
    func transpose_copy() -> Matrix<T> {
        var trans = Matrix.init(rows: self.columns, columns: self.rows, data: self.data)
        for row in 0..<trans.rows {
            for col in 0..<trans.columns {
                trans[row,col] = self[col, row]
            }
        }
        return trans
    }
    
}


// MARK: Matrix Booleans
extension Matrix {
    
    /**
     :name:    isSquare
     :description:    checks if the matrix has same number of rows and columns
     - returns:    Bool
     */
    public var isSquare : Bool {
        return self.rows == self.columns
    }
    
    /**
     :name:    isDiagonal
     :description:    checks if the matrix is a square matrix and if it is, from i=0 to i = rowSize - 1 , if matrix[i,i] = 1.
     - returns:    Bool
     */
    public var isDiagonal : Bool {
        if !isSquare { return false }
        for row in 0..<self.rows {
            for column in 0..<self.columns {
                if row == column && self[row,column] != 1 { return false }
                if row != column && self[row,column] != 0 { return false }
            }
        }
        return true
    }

}


// MARK: Matrix Description
extension Matrix : CustomStringConvertible {
    
    public var description: String {
        var description = "Matrix\n"
        for row in 0..<self.rows {
            for col in 0..<self.columns {
                description += "\(self[row,col]) "
            }
            description += "\n"
        }
        return description
    }
    
}


// MARK: Matrix Operations
extension Matrix : Equatable {
    
    // Checks if two matrices are equal
    // Conditions: Must have same number of rows and columns
    public static func ==(lhs: Matrix<T>, rhs: Matrix<T>) -> Bool {
        if lhs.rows != rhs.rows && lhs.columns != rhs.columns { return false }
        
        for i in 0..<lhs.data.count {
            if lhs.data[i] != rhs.data[i] { return false }
        }
        
        return true
    }
    
    // Adds two matrices
    // Conditions: Must have same number of rows and columns
    public static func +(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
        precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, MatrixError.unequal.localizedDescription)
        var temp = lhs
        for i in 0...temp.data.count - 1{
            temp.data[i] += rhs.data[i]
        }
        return temp
    }
    
    /// Adds two matrices
    // Conditions: Must have same number of rows and columns
    public static func +=(lhs: inout Matrix<T>, rhs: Matrix<T>) {
        precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, MatrixError.unequal.localizedDescription)
        for i in 0...lhs.data.count - 1{
            lhs.data[i] += rhs.data[i]
        }
    }
    
    // Subtracts two matrices
    // Conditions: Must have same number of rows and columns
    public static func -(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
        precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, MatrixError.unequal.localizedDescription)
        
        var temp = lhs
        for i in 0...temp.data.count - 1{
            temp.data[i] -= rhs.data[i]
        }
        
        return temp
        
    }
    
    
    
    // Subtracts two matrices
    // Conditions: Must have same number of rows and columns
    public static func -=(lhs: inout Matrix<T>, rhs: Matrix<T>) -> Matrix<T> {
        precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, MatrixError.unequal.localizedDescription)
        
        for row in 0..<lhs.rows {
            for column in 0..<rhs.columns {
                lhs[row,column] -= rhs[row,column]
            }
        }
        
        return lhs
        
    }
    
    // Multiplies two matrices
    // Conditions: Matrix 1's column size must be equal to matrix 2's row size
    public static func *(lhs:Matrix<T>, rhs:Matrix<T>) -> Matrix<T> {
        var lhs_temp = lhs
        var rhs_temp = rhs
        
        // Check for single row matrices
        if (lhs_temp.rows == 1 && rhs_temp.rows == 1) && (lhs_temp.columns == rhs_temp.columns) {
            rhs_temp.transpose()
        }
        // Check for single column matrices
        else if (lhs_temp.columns == 1 && rhs_temp.columns == 1) && (lhs_temp.rows == rhs_temp.rows) {
            lhs_temp.transpose()
        }
        
        precondition(lhs_temp.columns == rhs_temp.rows, MatrixError.multiplication.localizedDescription)
        
        var mult = Matrix(rows: lhs_temp.rows, columns:rhs_temp.columns)
        
        for row in 0..<lhs_temp.rows {
            for col in 0..<rhs_temp.columns {
                let a = lhs_temp.row(index: row).dot_product(rhs_temp.column(index: col))
                mult[row,col] = a
            }
        }
        return mult
    }
    
    // Multiplies a matrix by a scalar
    public static func *=(lhs: Matrix<T>, rhs: T) -> Matrix<T> {
        var temp = lhs
        for row in 0..<lhs.rows {
            for col in 0..<lhs.columns {
                temp[row,col] *= rhs
            }
        }
        return temp
    }
    
    // Multiplies two matrices by a scalar
    public static func *=(lhs: inout Matrix<T>, rhs: T) {
        for row in 0..<lhs.rows {
            for col in 0..<lhs.columns {
                lhs[row,col] *= rhs
            }
        }
        
    }
    
    // Divides two matrices
    // Conditions : Matrices must be the same size
    public static func /(lhs: Matrix<T>, rhs: Matrix<T>) -> Matrix<T>{
        precondition(lhs.rows == rhs.rows && lhs.columns == rhs.columns, MatrixError.unequal.localizedDescription)
        var temp = lhs
        for row in 0..<lhs.rows {
            for col in 0..<lhs.columns {
                temp[row,col] /= rhs[row,col]
            }
        }
        return temp
    }
    
    // Divides a matrix by a scalar value
    public static func /(lhs: Matrix<T>, rhs: T) -> Matrix<T>{
        var temp = lhs
        for row in 0..<lhs.rows {
            for col in 0..<lhs.columns {
                temp[row,col] /= rhs
            }
        }
        return temp
    }
    
    // Divides a matrix by a scalar value
    public static func /=(lhs: inout Matrix<T>, rhs: T) {
        for row in 0..<lhs.rows {
            for col in 0..<lhs.columns {
                lhs[row,col] /= rhs
            }
        }
        
    }

}

enum MatrixError : Error {
    case undefined
    case unequal
    case invalid
    case multiplication
    
    
    var localizedDescription: String {
        switch self {
        case .undefined:
            return "Undefined Matrix"
        case .unequal:
            return "Unequal Matrices size"
        case .invalid:
            return "Invalid Range"
        case .multiplication:
            return "Matrix A's column must be equal to Matrix B's row"
        }
    }
}













