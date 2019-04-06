//
//  Matrix2x2.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 30/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct Matrix2x2 {
    private var _00: Double
    private var _01: Double
    private var _10: Double
    private var _11: Double
    
    subscript(row: Int, col: Int) -> Double {
        get {
            switch (row, col) {
            case (0,0): return _00
            case (0,1): return _01
            case (1,0): return _10
            case (1,1): return _11
            default: fatalError()
            }
        }
        set {
            switch (row, col) {
            case (0,0): _00 = newValue
            case (0,1): _01 = newValue
            case (1,0): _10 = newValue
            case (1,1): _11 = newValue
            default: fatalError()
            }
        }
    }
    
    static var zero: Matrix2x2 {
        return Matrix2x2(_00: 0.0, _01: 0.0,
                         _10: 0.0, _11: 0.0)
    }
    
    static var identity: Matrix2x2 {
        var m = Matrix2x2.zero
        for i in 0..<2 {
            m[i,i] = 1.0
        }
        return m
    }

}
