//
//  BoundsAccumulator.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 07/04/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct Bounds {
    var minX: Double
    var minY: Double
    var maxX: Double
    var maxY: Double
    
    var width: Double {
        return maxX - minX
    }
    
    var height: Double {
        return maxY - minY
    }
    
    static func enclosing(points: [Point3D]) -> Bounds {
        let firstP = points.first!
        var bounds = Bounds(minX: firstP.x, minY: firstP.y, maxX: firstP.x, maxY: firstP.y)
        for p in points {
            if p.x < bounds.minX {
                bounds.minX = p.x
            } else if p.x > bounds.maxX {
                bounds.maxX = p.x
            }
            if p.y < bounds.minY {
                bounds.minY = p.y
            } else if p.y > bounds.maxY {
                bounds.maxY = p.y
            }
        }
        return bounds
    }
}
