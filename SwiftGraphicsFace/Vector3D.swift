//
//  Vector3D.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 23/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

infix operator ⨯

struct Vector3D {
    let x: Double
    let y: Double
    let z: Double
    
    static func +(l: Vector3D, r: Vector3D) -> Vector3D {
        return Vector3D(x: l.x + r.x, y: l.y + r.y, z: l.z + r.z)
    }
    
    static func +=(l: inout Vector3D, r: Vector3D) {
        l = l + r
    }
    
    static func *(l: Vector3D, r: Double) -> Vector3D {
        return Vector3D(x: l.x * r, y: l.y * r, z: l.z * r)
    }
    
    static func /(l: Vector3D, r: Double) -> Vector3D {
        return Vector3D(x: l.x / r, y: l.y / r, z: l.z / r)
    }
    
    static func ⨯(l: Vector3D, r: Vector3D) -> Vector3D {
        return Vector3D(x: l.y * r.z - l.z * r.y,
                        y: l.z * r.x - l.x * r.z,
                        z: l.x * r.y - l.y * r.x)
    }
    
    var length: Double {
        return sqrt(x*x + y*y + z*z)
    }
    
    func normalized() -> Vector3D {
        return self/length
    }
}
