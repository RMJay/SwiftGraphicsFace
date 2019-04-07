//
//  Rectangle.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 03/04/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct Rectangle {
    let minX: Double
    let minY: Double
    let width: Double
    let height: Double
    
    var maxX: Double { return minX + width }
    var maxY: Double { return minY + height }
    var isNull: Bool { return minX == Double.infinity || minY == Double.infinity }
    
    static var null: Rectangle {
        return Rectangle(minX: Double.infinity, minY: Double.infinity, width: 0, height: 0)
    }
    
    func union(_ other: Rectangle) -> Rectangle {
        if self.isNull { return other }
        if other.isNull { return self }
        let minX = min(self.minX, other.minX)
        let minY = min(self.minY, other.minY)
        let maxX = max(self.maxX, other.maxX)
        let maxY = max(self.maxY, other.maxY)
        let width = maxX - minX
        let height = maxY - minY
        return Rectangle(minX: minX, minY: minY, width: width, height: height)
    }

}
