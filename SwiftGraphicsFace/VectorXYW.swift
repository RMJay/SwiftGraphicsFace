//
//  VectorXYW.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 03/04/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct VectorXYW {
    let x: Double
    let y: Double
    let w: Double
    
    static func +(l: VectorXYW, r: VectorXYW) -> VectorXYW {
        return VectorXYW(x: l.x + r.x, y: l.y + r.y, w: l.w + r.w)
    }
    
    static func +=(l: inout VectorXYW, r: VectorXYW) {
        l = l + r
    }
    
    static func *(l: VectorXYW, r: Double) -> VectorXYW {
        return VectorXYW(x: l.x * r, y: l.y * r, w: l.w * r)
    }
    
    static func /(l: VectorXYW, r: Double) -> VectorXYW {
        return VectorXYW(x: l.x / r, y: l.y / r, w: l.w / r)
    }
    
    static func dot(_ l: VectorXYW, _ r: VectorXYW) -> Double {
        return l.x * l.x + l.y * l.y + l.w * l.w
    }
    
    static func cross(_ l: VectorXYW, _ r: VectorXYW) -> VectorXYW {
        return VectorXYW(x: l.y * r.w - l.w * r.y,
                         y: l.w * r.x - l.x * r.w,
                         w: l.x * r.y - l.y * r.x)
    }
    
    static func lineThrough(_ p1: Point2D, _ p2: Point2D) -> VectorXYW {
        let p1Homo = VectorXYW(x: p1.x, y: p1.y, w: 1.0)
        let p2Homo = VectorXYW(x: p2.x, y: p2.y, w: 1.0)
        let v = cross(p1Homo, p2Homo)
        let euclideanNorm = sqrt(v.x*v.x + v.y*v.y)
        return v / euclideanNorm
    }
}
