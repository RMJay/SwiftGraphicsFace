//
//  VectorXYZ.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 03/04/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct VectorXYZ {
    let x: Double
    let y: Double
    let z: Double
    
    static func +(l: VectorXYZ, r: VectorXYZ) -> VectorXYZ {
        return VectorXYZ(x: l.x + r.x, y: l.y + r.y, z: l.z + r.z)
    }
    
    static func +=(l: inout VectorXYZ, r: VectorXYZ) {
        l = l + r
    }
    
    static func *(l: VectorXYZ, r: Double) -> VectorXYZ {
        return VectorXYZ(x: l.x * r, y: l.y * r, z: l.z * r)
    }
    
    static func /(l: VectorXYZ, r: Double) -> VectorXYZ {
        return VectorXYZ(x: l.x / r, y: l.y / r, z: l.z / r)
    }
    
    static func dot(_ l: VectorXYZ, _ r: VectorXYZ) -> Double {
        return l.x * l.x + l.y * l.y + l.z * l.z
    }
    
    static func cross(_ l: VectorXYZ, _ r: VectorXYZ) -> VectorXYZ {
        return VectorXYZ(x: l.y * r.z - l.z * r.y,
                         y: l.z * r.x - l.x * r.z,
                         z: l.x * r.y - l.y * r.x)
    }
    
    func normalized() -> VectorXYZ {
        return self / sqrt(x*x + y*y + z*z)
    }
    
}
