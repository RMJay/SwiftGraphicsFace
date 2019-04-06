//
//  VectorXY.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 03/04/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct VectorXY {
    let x: Double
    let y: Double
    
    static func dot(_ l: VectorXY, _ r: VectorXY) -> Double {
        return l.x * r.x + l.y * r.y
    }
}
