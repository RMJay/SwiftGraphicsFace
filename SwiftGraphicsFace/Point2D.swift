//
//  Point2D.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 03/04/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct Point2D {
    let x: Double
    let y: Double
    
    static func -(l: Point2D, r: Point2D) -> VectorXY {
        return VectorXY(x: l.x - r.x, y: l.y - r.y)
    }
}
