//
//  FaceView.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 08/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//
import Cocoa

class FaceView: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        guard let currentContext = NSGraphicsContext.current?.cgContext else { return }
        
        let pixelBuffer = PixelBuffer(width: currentContext.width, height: currentContext.height)
        
        for y in 0..<pixelBuffer.height {
            for x in 0..<pixelBuffer.width {
                pixelBuffer.setRGB(x: x, y: y, r: 255, g: 255, b: 255)
            }
        }
        
        CGDataProvider(directInfo: pixelBuffer.baseAddress,
                       size: pixelBuffer.bytesPerRow * pixelBuffer.height,
                       callbacks),
        
        let image = CGImage(width: pixelBuffer.width,
                            height: pixelBuffer.height,
                            bitsPerComponent: 8,
                            bitsPerPixel: 32,
                            bytesPerRow: pixelBuffer.bytesPerRow,
                            space: CGColorSpaceCreateDeviceRGB(),
                            bitmapInfo: ,
                            provider:,
                            decode: nil, //used to produce some effects e.g. invert colors
                            shouldInterpolate: false,
                            intent: CGColorRenderingIntent.defaultIntent)

        currentContext.draw(image, in: self.bounds)
    }
    
}
