//
//  PixelBuffer.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 10/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//
import Foundation

class PixelBuffer {
    private static let bytesPerPixel = 4
    private static let rowAlignment = 64
    
    let width: Int
    let height: Int
    let bytesPerRow: Int
    private let data: UnsafeMutablePointer<UInt32>
    
    var baseAddress: UnsafeRawPointer {
        return data
    }
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        let n = width * PixelBuffer.bytesPerPixel

        if n % PixelBuffer.rowAlignment == 0 {
            bytesPerRow = n
        } else {
            bytesPerRow = (n / PixelBuffer.rowAlignment + 1) * PixelBuffer.rowAlignment
        }
        
        
    }
    
    deinit {
        
    }
    
    func setRGB(x: Int, y: Int, r: UInt8, g: UInt8, b: UInt8) {
        var rgb: UInt32 = UInt32(r)
        rgb = (rgb << 8) + UInt32(g)
        rgb = (rgb << 8) + UInt32(b)
        let row = baseAddress.advanced(by: y * bytesPerRow)
            .bindMemory(to: UInt32.self, capacity: width)
        row.advanced(by: x).pointee = rgb
        //buf.advanced(by: y * bytesPerRow + x).pointee = rgb
    }

    func getRGB(x: Int, y: Int) -> (r: UInt8, g: UInt8, b: UInt8) {
        let row = baseAddress
            .advanced(by: y * bytesPerRow)
            .bindMemory(to: UInt32.self, capacity: width)
        let rgb = row.advanced(by: x).pointee
        let r = UInt8(rgb >> 16)
        let g = UInt8(rgb >> 8)
        let b = UInt8(rgb)
        return (r: r, g: g, b: b)
    }

}
