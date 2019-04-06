//
//  FaceView.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 08/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//
import Cocoa

class RenderView: NSView {
    
    let pixelContext = PixelContext()
    var rotation = Transform3D.identity
        .rotatedBy(θx: Double.pi, θy: 0.0)
        .scaledBy(sx: 1.0, sy: -1.0, sz: 1.0)
    var zoom = Transform3D.identity
    var scroll = Transform3D.identity
    
    var triangles = [ScreenSpaceTriangle]()
    var modelBounds: Rectangle? = nil
    
    override func draw(_ dirtyRect: NSRect) {
        guard let currentContext = NSGraphicsContext.current?.cgContext else { return }

        if  pixelContext.width != currentContext.width || pixelContext.height != currentContext.height {
            pixelContext.resize(width: currentContext.width, height: currentContext.height)
        }
        
        drawBackground(in: pixelContext)
        drawTestTriangles(in: pixelContext)
        //drawModelBounds(in: PixelContext)
        
        if let image = pixelContext.getImage() {
            currentContext.draw(image, in: self.bounds)
        }
    }
    
    func drawBackground(in pixelContext: PixelContext) {
        let topColor = ColorRGB.orchid
        let bottomColor = ColorRGB.midnight
        
        let topRed = Double(topColor.r)
        let topGreen = Double(topColor.g)
        let topBlue = Double(topColor.b)
        
        let bottomRed = Double(bottomColor.r)
        let bottomGreen = Double(bottomColor.g)
        let bottomBlue = Double(bottomColor.b)

        let height = Double(pixelContext.height)
        
        let deltaRed = (bottomRed - topRed) / height
        let deltaGreen = (bottomGreen - topGreen) / height
        let deltaBlue =  (bottomBlue - topBlue) / height
        
        for y in 0..<pixelContext.height {
            let red = UInt8(topRed + deltaRed * Double(y))
            let green = UInt8(topGreen + deltaGreen * Double(y))
            let blue = UInt8(topBlue + deltaBlue * Double(y))
            
            for x in 0..<pixelContext.width {
                pixelContext.setRGB(x: x, y: y, r: red, g: green, b: blue)
            }
        }
    }
    
    //for testing
    func drawTestTriangles(in pixelContext: PixelContext) {
        var vertexes = [
                Point3D(x: 100, y: 700, z: 0),
                Point3D(x: 700, y: 500, z: 0),
                Point3D(x: 200, y: 100, z: 0),
                Point3D(x: 120, y: 300, z: 0),
                Point3D(x: 390, y: 680, z: 0),
                Point3D(x: 720, y: 370, z: 0),
                Point3D(x: 250, y: 540, z: 0),
                Point3D(x: 520, y: 620, z: 0),
                Point3D(x: 500, y: 220, z: 0),
            ]
        
        let t0 = ScreenSpaceTriangle(v0: vertexes[0], v1: vertexes[1], v2: vertexes[2])
        let t1 = ScreenSpaceTriangle(v0: vertexes[3], v1: vertexes[4], v2: vertexes[5])
        let t2 = ScreenSpaceTriangle(v0: vertexes[6], v1: vertexes[7], v2: vertexes[8])

        self.triangles = [t0, t1, t2]
        self.modelBounds = self.triangles.reduce(Rectangle.null){ $0.union($1.bounds) }
        
        t0.drawSolid(in: pixelContext, color: .spring)
        t1.drawSolid(in: pixelContext, color: .maraschino)
        t2.drawSolid(in: pixelContext, color: .tangerine)
    }
}
