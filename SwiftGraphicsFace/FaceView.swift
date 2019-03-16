//
//  FaceView.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 08/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//
import Cocoa

class FaceView: NSView {
    
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

        for y in 0..<pixelContext.height {
            for x in 0..<pixelContext.width {
                pixelContext.setRGB(x: x, y: y, r: 255, g: 0, b: 255)
            }
        }

        if let image = pixelContext.getImage() {
            currentContext.draw(image, in: self.bounds)
        }

    }
    
}
