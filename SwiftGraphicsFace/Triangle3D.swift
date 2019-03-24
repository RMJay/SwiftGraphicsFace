//
//  Triangle3D.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 23/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct Triangle3D {
    let vertexes: [Point3D]
    let colors: [ColorRGB] //the color at each vertex
    let faceNormal: Vector3D
    let normals: [Vector3D] //the normal vector at each vertex
}
