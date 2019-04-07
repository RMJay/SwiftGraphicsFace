//
//  ColorRGB.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 23/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct ColorRGB {
    let r: UInt8
    let g: UInt8
    let b: UInt8
}

extension ColorRGB {
    static let white = ColorRGB(r: 255, g: 255, b: 255)
    static let spring = ColorRGB(r: 0, g: 255, b: 0)
    static let maraschino = ColorRGB(r: 255, g: 0, b: 0)
    static let lemon = ColorRGB(r: 255, g: 250, b: 3)
    static let tangerine  = ColorRGB(r: 255, g: 153, b: 0)
    static let orchid = ColorRGB(r: 110, g: 118, b: 255)
    static let midnight   = ColorRGB(r: 0, g: 24, b: 136)
}
