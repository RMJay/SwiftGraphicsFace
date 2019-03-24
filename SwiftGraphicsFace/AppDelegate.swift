//
//  AppDelegate.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 07/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        guard let vertexDataURL = Bundle.main.url(forResource: "face_vertex_data", withExtension: "txt") else {
            fatalError("\"face_vertex_data.txt\" not found in bundle")
        }
        guard let triangleDataURL = Bundle.main.url(forResource: "face_triangle_data", withExtension: "txt") else {
            fatalError("\"face_triangle_data.txt\" not found in bundle")
        }
        
        do {
            let vertexDataFile = try FileHandle(forReadingFrom: vertexDataURL)
            let triangleDataFile = try FileHandle(forReadingFrom: triangleDataURL)
            
            let face = try Object3DReader.read(vertexDataFile: vertexDataFile, triangleDataFile: triangleDataFile)
            
        } catch let error {
            print(error)
        }
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

