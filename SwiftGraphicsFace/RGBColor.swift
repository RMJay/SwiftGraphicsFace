//
//  RGBColor.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 16/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct RGBColor {
    let r: UInt8
    let g: UInt8
    let b: UInt8
}

extension RGBColor {
    static var orchid: RGBColor {
        return RGBColor(r: 110, g: 118, b: 255)
    }
    static var midnight: RGBColor {
        return RGBColor(r: 0, g: 24, b: 136)
    }
}
