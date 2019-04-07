//
//  Triangle2D.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 03/04/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct ScreenSpaceTriangle {
    private let vertexes: [Point3D]
    private let colors: [ColorRGB]
    private let normals: [VectorXYZ]
    private let faceNormal: VectorXYZ
    
    let bounds: Bounds
    private let isFrontSide: Bool
    private let lines: [VectorXYW]
    
    //used in the barycentric interpolation - cached here for speed
    private let v01, v02: VectorXY
    private let d00, d01, d11, invDenom: Double
    
    init(vertexes: [Point3D], colors: [ColorRGB], normals: [VectorXYZ], faceNormal: VectorXYZ) {
        self.vertexes = vertexes
        self.colors = colors
        self.normals = normals
        self.faceNormal = faceNormal
        bounds = Bounds.enclosing(points: vertexes)
        
        let vertexes2D = vertexes.map{ $0.to2D() }
        lines = [VectorXYW.lineThrough(vertexes2D[0], vertexes2D[1]),
                 VectorXYW.lineThrough(vertexes2D[1], vertexes2D[2]),
                 VectorXYW.lineThrough(vertexes2D[2], vertexes2D[0])]
        
        v01 = vertexes2D[1] - vertexes2D[0]
        v02 = vertexes2D[2] - vertexes2D[0]
        let crossProdZ = v01.x * v02.y - v01.y * v02.x //out of plane component of the cross product
        isFrontSide = crossProdZ <= 0
        d00 = VectorXY.dot(v01, v01)
        d01 = VectorXY.dot(v01, v02)
        d11 = VectorXY.dot(v02, v02)
        invDenom = 1.0 / (d00 * d11 - d01 * d01)
    }
    
    init(from t: Triangle3D, applying transform: Transform3D) {
        self.init(vertexes: t.vertexes.map{ $0.applying(transform) },
                  colors: t.colors, normals: t.normals, faceNormal: t.faceNormal)
    }
    
    init(v0: Point3D, v1: Point3D, v2: Point3D) {
        let n = VectorXYZ(x: 0, y: 0, z: 1)
        self.init(vertexes: [v0, v1, v2], colors: [.white, .white, .white], normals: [n, n, n], faceNormal: n)
    }
    
    func drawSolid(in pixelContext: PixelContext, color: ColorRGB) {
        let minI = max(0, Int(bounds.minX))
        let maxI = min(pixelContext.width, Int(bounds.maxX)+1)
        let minJ = max(0, Int(bounds.minY))
        let maxJ = min(pixelContext.height, Int(bounds.maxY)+1)
        
        guard minI < maxI else { return }
        guard minJ < maxJ else { return }
        
        var x, y, dot0, dot1, dot2: Double
        let w = 1.0
        for i in minI..<maxI {
            x = Double(i)
            for j in minJ..<maxJ {
                y = Double(j)
                dot0 = x*lines[0].x + y*lines[0].y + w*lines[0].w
                dot1 = x*lines[1].x + y*lines[1].y + w*lines[1].w
                dot2 = x*lines[2].x + y*lines[2].y + w*lines[2].w
                if dot0 < 0.5 && dot1 < 0.5 && dot2 < 0.5 {
                    pixelContext.setRGB(x: i, y: j, r: color.r, g: color.g, b: color.b)
                }
            }
        }
    }
    
    func drawPolygon(in pixelContext: PixelContext, fill: ColorRGB, stroke: ColorRGB) {
        let minI = max(0, Int(bounds.minX))
        let maxI = min(pixelContext.width, Int(bounds.maxX)+1)
        let minJ = max(0, Int(bounds.minY))
        let maxJ = min(pixelContext.height, Int(bounds.maxY)+1)
        
        guard minI < maxI else { return }
        guard minJ < maxJ else { return }
        
        var x, y, z, dot0, dot1, dot2: Double
        var bary: BaryCentric
        let w = 1.0
        for i in minI..<maxI {
            x = Double(i)
            for j in minJ..<maxJ {
                y = Double(j)
                bary = baryCentricCoords(x: x, y: y)
                z = bary[0] * vertexes[0].z + bary[1] * vertexes[1].z + bary[2] * vertexes[2].z
                dot0 = x*lines[0].x + y*lines[0].y + w*lines[0].w
                dot1 = x*lines[1].x + y*lines[1].y + w*lines[1].w
                dot2 = x*lines[2].x + y*lines[2].y + w*lines[2].w
                if dot0 < 0.5 && dot1 < 0.5 && dot2 < 0.5 {
                    if dot0 > -0.5 || dot1 > -0.5 || dot2 > -0.5 {
                        if z < pixelContext.getBufferedZ(x: i, y: j) {
                            pixelContext.setRGB(x: i, y: j, r: stroke.r, g: stroke.g, b: stroke.b)
                            pixelContext.setBufferedZ(x: i, y: j, z: z)
                        }
                    } else {
                        if z < pixelContext.getBufferedZ(x: i, y: j) {
                            pixelContext.setRGB(x: i, y: j, r: fill.r, g: fill.g, b: fill.b)
                            pixelContext.setBufferedZ(x: i, y: j, z: z)
                        }
                    }
                }
            }
        }
    }
    
    func baryCentricCoords(x: Double, y: Double) -> BaryCentric {
        let v = VectorXY(x: x - vertexes[0].x, y: y - vertexes[0].y)
        let d20 = VectorXY.dot(v, v01)
        let d21 = VectorXY.dot(v, v02)
        let bary1 = (d11 * d20 - d01 * d21) * invDenom
        let bary2 = (d00 * d21 - d01 * d20) * invDenom
        let bary0 = 1.0 - bary1 - bary2
        return BaryCentric(bary0, bary1, bary2)
    }
    
//    func drawFlat(in pixelContext: PixelContext, lightPosition: Point3D) {
//        let directionToLightSource = 
//    }

}
