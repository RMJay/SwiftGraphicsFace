//
//  FaceView.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 08/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//
import Cocoa

class RenderView: NSView {
    
    let pixelContext: PixelContext
    
    override init(frame: NSRect) {
        pixelContext = PixelContext()
        super.init(frame: frame)
    }
    
    required init?(coder decoder: NSCoder) {
        pixelContext = PixelContext()
        super.init(coder: decoder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        guard let currentContext = NSGraphicsContext.current?.cgContext else { return }

        if  pixelContext.width != currentContext.width ||
            pixelContext.height != currentContext.height
        {
            pixelContext.resize(width: currentContext.width, height: currentContext.height)
        }
        
        drawBackground(in: pixelContext)
        //drawScene(in: pixelContext)

        if let image = pixelContext.getImage() {
            currentContext.draw(image, in: self.bounds)
        }

    }
    
    func drawBackground(in pixelContext: PixelContext) {
        let topColor = RGBColor.orchid
        let bottomColor = RGBColor.midnight
        
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
            for x in 0..<pixelContext.width {
                pixelContext.setRGB(x: x,
                                    y: y,
                                    r: UInt8(topRed + deltaRed * Double(y)),
                                    g: UInt8(topGreen + deltaGreen * Double(y)),
                                    b: UInt8(topBlue + deltaBlue * Double(y))
                )
            }
        }
        
    }
    
}
