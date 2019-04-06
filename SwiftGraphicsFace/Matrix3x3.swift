//
//  Matrix3x3.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 28/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct Matrix3x3 {
    private var _00: Double
    private var _01: Double
    private var _02: Double
    
    private var _10: Double
    private var _11: Double
    private var _12: Double
    
    private var _20: Double
    private var _21: Double
    private var _22: Double
    
    subscript(row: Int, col: Int) -> Double {
        get {
            switch (row, col) {
            case (0,0): return _00
            case (0,1): return _01
            case (0,2): return _02
                
            case (1,0): return _10
            case (1,1): return _11
            case (1,2): return _12
                
            case (2,0): return _20
            case (2,1): return _21
            case (2,2): return _22
                
            default: fatalError()
            }
        }
        set {
            switch (row, col) {
            case (0,0): _00 = newValue
            case (0,1): _01 = newValue
            case (0,2): _02 = newValue
                
            case (1,0): _10 = newValue
            case (1,1): _11 = newValue
            case (1,2): _12 = newValue
                
            case (2,0): _20 = newValue
            case (2,1): _21 = newValue
            case (2,2): _22 = newValue
                
            default: fatalError()
            }
        }
    }
    
    static var zero: Matrix3x3 {
        return Matrix3x3(_00: 0.0, _01: 0.0, _02: 0.0,
                         _10: 0.0, _11: 0.0, _12: 0.0,
                         _20: 0.0, _21: 0.0, _22: 0.0)
    }
    
    static var identity: Matrix3x3 {
        var m = Matrix3x3.zero
        for i in 0..<3 {
            m[i,i] = 1.0
        }
        return m
    }
    
}
