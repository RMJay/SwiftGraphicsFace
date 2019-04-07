//
//  BaryCentric.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 07/04/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct BaryCentric {
    private var b0: Double
    private var b1: Double
    private var b2: Double
    
    init(_ b0: Double, _ b1: Double, _ b2: Double) {
        self.b0 = b0
        self.b1 = b1
        self.b2 = b2
    }
    
    subscript(i: Int) -> Double {
        get{
            switch (i) {
            case 0: return b0
            case 1: return b1
            case 2: return b2
            default: fatalError()
            }
        }
        set {
            switch (i) {
            case 0: b0 = newValue
            case 1: b1 = newValue
            case 2: b2 = newValue
            default: fatalError()
            }
        }
    }
}
