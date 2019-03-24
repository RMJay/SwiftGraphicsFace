//
//  AffineTransform3D.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 24/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct Transform3D {
    private var matrix: Matrix4x4
    
    static var identity: Transform3D {
        return Transform3D(matrix: Matrix4x4.identity)
    }
    
    private func applying(_ transform: Transform3D) -> Transform3D {
        return Transform3D(matrix: Matrix4x4.multiply(transform.matrix, self.matrix))
    }
    
    func scaledBy(_ scale: Double) -> Transform3D {
        var s = Matrix4x4.identity
        s[0,0] = scale
        s[1,1] = scale
        s[2,2] = scale
        return Transform3D(matrix: Matrix4x4.multiply(s, self.matrix))
    }
    
    func scaledBy(sx: Double, sy: Double, sz: Double) -> Transform3D {
        var s = Matrix4x4.identity
        s[0,0] = sx
        s[1,1] = sy
        s[2,2] = sz
        return Transform3D(matrix: Matrix4x4.multiply(s, self.matrix))
    }
    
    func translatedBy(tx: Double, ty: Double, tz: Double) -> Transform3D {
        var t = Matrix4x4.identity
        t[3,0] = tx
        t[3,1] = ty
        t[3,2] = tz
        return Transform3D(matrix: Matrix4x4.multiply(t, self.matrix))
    }
    
    func rotatedBy(θx: Double, θy: Double) -> Transform3D {
        var rx = Matrix4x4.identity
        rx[1,1] = cos(θx)
        rx[1,2] = -sin(θx)
        rx[2,1] = sin(θx)
        rx[2,1] = cos(θx)
        var ry = Matrix4x4.identity
        ry[0,0] = cos(θy)
        ry[0,2] = sin(θy)
        ry[2,0] = -sin(θy)
        ry[2,2] = cos(θy)
        let r = Matrix4x4.multiply(rx, ry)
        return Transform3D(matrix: Matrix4x4.multiply(r, self.matrix))
    }
}

