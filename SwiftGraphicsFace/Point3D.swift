//
//  Point3D.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 23/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct Point3D {
    let x: Double
    let y: Double
    let z: Double

    static func -(l: Point3D, r: Point3D) -> VectorXYZ {
        return VectorXYZ(x: l.x - r.x, y: l.y - r.y, z: l.z - r.z)
    }

    func to2D() -> Point2D {
        return Point2D(x: x, y: y)
    }
    
    func applying(_ transform: Transform3D) -> Point3D {
        let m = transform.matrix
        return Point3D(x: m[0,0]*x + m[0,1]*y + m[0,2]*z + m[0,3],
                       y: m[1,0]*x + m[1,1]*y + m[1,2]*z + m[1,3],
                       z: m[2,0]*x + m[2,1]*y + m[2,2]*z + m[2,3])
    }
}
