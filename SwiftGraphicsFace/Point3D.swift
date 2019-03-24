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

    static func -(l: Point3D, r: Point3D) -> Vector3D {
        return Vector3D(x: l.x - r.x, y: l.y - r.y, z: l.z - r.z)
    }

}
