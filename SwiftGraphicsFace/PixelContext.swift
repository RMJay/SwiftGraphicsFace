//
//  PixelBuffer.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 10/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//
import Foundation

class PixelContext {

    private var _width: Int
    private var _height: Int
    private var pixBuf: UnsafeMutablePointer<UInt32>
    private var zBuf: UnsafeMutablePointer<Double>
    
    init() {
        _width = 0
        _height = 0
        pixBuf = UnsafeMutablePointer<UInt32>.allocate(capacity: 1)
        pixBuf.initialize(repeating: 0, count: 1)
        zBuf = UnsafeMutablePointer<Double>.allocate(capacity: 1)
        zBuf.initialize(repeating: Double.infinity, count: 1)
    }

    var width: Int {
        return _width
    }

    var height: Int {
        return _height
    }
    
    func resize(width: Int, height: Int) {
        _width = width
        _height = height
        let numPixels = width * height
        
        pixBuf.deallocate()
        pixBuf = UnsafeMutablePointer<UInt32>.allocate(capacity: numPixels)
        pixBuf.initialize(repeating: 0, count: numPixels)
        
        zBuf.deallocate()
        zBuf = UnsafeMutablePointer<Double>.allocate(capacity: numPixels)
        zBuf.initialize(repeating: Double.infinity, count: numPixels)
    }

    deinit {
        pixBuf.deallocate()
    }

    func setRGB(x: Int, y: Int, r: UInt8, g: UInt8, b: UInt8) {
        let pixPtr = pixBuf.advanced(by: y * width + x)
        pixPtr.withMemoryRebound(to: UInt8.self, capacity: 4) {
            $0.advanced(by: 1).pointee = r
            $0.advanced(by: 2).pointee = g
            $0.advanced(by: 3).pointee = b
        }
    }

    func getRGB(x: Int, y: Int) -> (r: UInt8, g: UInt8, b: UInt8) {
        let pixPtr = pixBuf.advanced(by: y * width + x)
        return pixPtr.withMemoryRebound(to: UInt8.self, capacity: 4) {
            let r = $0.advanced(by: 1).pointee
            let g = $0.advanced(by: 2).pointee
            let b = $0.advanced(by: 3).pointee
            return (r: r, g: g, b: b)
        }
    }
    
    func getBufferedZ(x: Int, y: Int) -> Double {
        return zBuf.advanced(by: y * width + x).pointee
    }
    
    func setBufferedZ(x: Int, y: Int, z: Double) {
        zBuf.advanced(by: y * width + x).pointee = z
    }

    func getImage() -> CGImage? {
        let data = NSData(bytes: pixBuf, length: width * height * MemoryLayout<UInt32>.size)
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Big.rawValue |
                                                CGImageAlphaInfo.noneSkipFirst.rawValue)

        if  let dataProvider = CGDataProvider(data: data),
            let image = CGImage(
                width: width,
                height: height,
                bitsPerComponent: 8,
                bitsPerPixel: 32,
                bytesPerRow: width * MemoryLayout<UInt32>.size,
                space: CGColorSpaceCreateDeviceRGB(),
                bitmapInfo: bitmapInfo,
                provider: dataProvider,
                decode: nil, //used to produce some effects e.g. invert colors
                shouldInterpolate: false,
                intent: CGColorRenderingIntent.defaultIntent)
        {
            return image
        } else {
            return nil
        }
    }
    
    func resetZBuffer() {
        let numPixels = _width * _height
        zBuf.initialize(repeating: Double.infinity, count: numPixels)
    }

}
