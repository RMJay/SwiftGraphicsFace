//
//  Matrix4x4.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 24/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct Matrix4x4 {
    private var _00: Double
    private var _01: Double
    private var _02: Double
    private var _03: Double
    
    private var _10: Double
    private var _11: Double
    private var _12: Double
    private var _13: Double
    
    private var _20: Double
    private var _21: Double
    private var _22: Double
    private var _23: Double
    
    private var _30: Double
    private var _31: Double
    private var _32: Double
    private var _33: Double
    
    subscript(row: Int, col: Int) -> Double {
        get {
            switch (row, col) {
            case (0,0): return _00
            case (0,1): return _01
            case (0,2): return _02
            case (0,3): return _03
            
            case (1,0): return _10
            case (1,1): return _11
            case (1,2): return _12
            case (1,3): return _13
                
            case (2,0): return _20
            case (2,1): return _21
            case (2,2): return _22
            case (2,3): return _23
                
            case (3,0): return _30
            case (3,1): return _31
            case (3,2): return _32
            case (3,3): return _33
                
            default: fatalError()
            }
        }
        set {
            switch (row, col) {
            case (0,0): _00 = newValue
            case (0,1): _01 = newValue
            case (0,2): _02 = newValue
            case (0,3): _03 = newValue
                
            case (1,0): _10 = newValue
            case (1,1): _11 = newValue
            case (1,2): _12 = newValue
            case (1,2): _13 = newValue
                
            case (2,0): _20 = newValue
            case (2,1): _21 = newValue
            case (2,2): _22 = newValue
            case (2,3): _23 = newValue
                
            case (3,0): _30 = newValue
            case (3,1): _31 = newValue
            case (3,2): _32 = newValue
            case (3,3): _33 = newValue
                
            default: fatalError()
            }
        }
    }
    
    static var zero: Matrix4x4 {
        return Matrix4x4(_00: 0.0, _01: 0.0, _02: 0.0, _03: 0.0,
                         _10: 0.0, _11: 0.0, _12: 0.0, _13: 0.0,
                         _20: 0.0, _21: 0.0, _22: 0.0, _23: 0.0,
                         _30: 0.0, _31: 0.0, _32: 0.0, _33: 0.0)
    }
    
    static var identity: Matrix4x4 {
        var m = Matrix4x4.zero
        for i in 0..<4 {
            m[i,i] = 1.0
        }
        return m
    }
    
    static func * (l: Double, r: Matrix4x4) -> Matrix4x4 {
        var m = Matrix4x4.zero
        m[0,0] = l * r[0,0]
        m[0,1] = l * r[0,1]
        m[0,2] = l * r[0,2]
        m[0,3] = l * r[0,3]
        
        m[1,0] = l * r[1,0]
        m[1,1] = l * r[1,1]
        m[1,2] = l * r[1,2]
        m[1,3] = l * r[1,3]
        
        m[2,0] = l * r[2,0]
        m[2,1] = l * r[2,1]
        m[2,2] = l * r[2,2]
        m[2,3] = l * r[2,3]
        
        m[3,0] = l * r[3,0]
        m[3,1] = l * r[3,1]
        m[3,2] = l * r[3,2]
        m[3,3] = l * r[3,3]
        return m
    }
    
    static func multiply(_ a: Matrix4x4, _ b: Matrix4x4) -> Matrix4x4 {
        var m = Matrix4x4.zero
        for i in 0..<4 {
            for j in 0..<4 {
                for k in 0..<4 {
                    m[i,j] += a[i,k] * b[k,j]
                }
            }
        }
        return m
    }
    
    func transposed() -> Matrix4x4 {
        var m = Matrix4x4.zero
        for i in 0..<4 {
            for j in 0..<4 {
                m[i,j] = self[j,i]
            }
        }
        return m
    }
    
    func det() -> Double {
        var result: Double
        for i in 0..<4 {
            result += self[0,i] * cofactor(0,i)
        }
        return result
    }
    
    func cofactor(_ row: Int, _ col: Int) -> Double {
        let subDet = submatrix(row, col).det()
        return (row + col) & 0b1 == 0 ? subDet : -subDet
    }
    
    func submatrix(_ row: Int, _ col: Int) -> Matrix3x3 {
        var m = Matrix3x3.zero
        for (k, i) in zip(0..., Array(0..<4).filter{ $0 != row }) {
            for (l, j) in zip(0..., Array(0..<4).filter{ $0 != col }) {
                m[k,l] = self[i,j]
            }
        }
        return m
    }
    
    func inverse() -> Matrix4x4 {
        let adjoint = self.adjoint()
        var det = 0.0
        for i in 0..<4 {
            det += self[0,i] * adjoint[i,0]
        }
        return (1.0/det) * adjoint
    }
    
    //adjoint is the transpose of the cofactor matrix
    func adjoint() -> Matrix4x4 {
        var m = Matrix4x4.zero
        for i in 0..<4 {
            for j in 0..<4 {
                m[i,j] = cofactor(j,i)
            }
        }
        return m
    }
    
}
