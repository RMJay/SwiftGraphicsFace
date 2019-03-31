//
//  Matrix.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 28/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct Matrix<T> {
    shape [4, 4]
    
    private let elements: UnsafePointer<T>
    
}

func matMul(a Matrix, b Matrix) where a.shape.0 == b.shape.1 {
    var m = Matrix4x4.zero
    for i in 0...3 {
        for j in 0...3 {
            for k in 0...3 {
                m[i,j] += a[i,k] * b[k,j]
            }
        }
    }
    return m
}
