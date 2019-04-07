//
//  Sphere.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 07/04/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct Sphere {
    let triangles: [Triangle3D]
    
    init(radius: Double) {
        let N = 10
        var pointAcc = Array(repeating: Array(repeating: Point3D.zero, count: 2*N), count: N+1)
        for i in 0...N {
            let theta = Double(i) * Double.pi / Double(N)
            for j in 0..<2*N {
                let phi = Double(j) * Double.pi / Double(N)
                pointAcc[i][j] = Point3D(x: radius * sin(theta) * cos(phi),
                                         y: radius * sin(theta) * sin(phi),
                                         z: radius * cos(theta))
            }
        }
        let points = pointAcc
        var triangleAcc = [Triangle3D]()
        triangleAcc.reserveCapacity(4*N*(N-1))
        var p0, p1, p2, p3: Point3D
        var faceNormal: VectorXYZ
        for i in 1...N {
            for j in 0..<2*N {
                p0 = points[i][j%(2*N)]
                p1 = points[i][(j+1)%(2*N)]
                p2 = points[i-1][j%(2*N)]
                p3 = points[i-1][(j+1)%(2*N)]
                if i < N {
                    faceNormal = VectorXYZ.cross(p1 - p0, p2 - p0).normalized()
                    triangleAcc.append(Triangle3D(vertexes: [p0, p1, p2],
                                                  colors: [.white, .white, .white],
                                                  normals: [faceNormal, faceNormal, faceNormal],
                                                  faceNormal: faceNormal))
                }
                if i > 1 {
                    faceNormal = VectorXYZ.cross(p3 - p1, p2 - p1).normalized()
                    triangleAcc.append(Triangle3D(vertexes: [p1, p3, p2],
                                                  colors: [.white, .white, .white],
                                                  normals: [faceNormal, faceNormal, faceNormal],
                                                  faceNormal: faceNormal))
                }
            }
        }
        triangles = triangleAcc
    }
}
