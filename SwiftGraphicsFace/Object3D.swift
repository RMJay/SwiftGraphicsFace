//
//  Model.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 18/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Foundation

struct Object3D {
    let triangles: [Triangle3D]
    
    init(triangles: [Triangle3D]) {
        self.triangles = triangles
    }
    
}
