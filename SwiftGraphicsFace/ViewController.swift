//
//  ViewController.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 07/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSWindowDelegate {
    
    @IBOutlet weak var renderView: RenderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            renderView.setObject3D(face)
        } catch let error {
            print(error)
        }
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        renderView.window?.delegate = self
    }
    
    func windowDidResize(_ notification: Notification) {
        guard let pixelScale = renderView.window?.backingScaleFactor else { return }
        renderView.centerAndScale(pixelWidth: Double(renderView.bounds.width * pixelScale),
                                  pixelHeight: Double(renderView.bounds.height * pixelScale))
    }
    
    func windowDidChangeBackingProperties(_ notification: Notification) {
        guard let pixelScale = renderView.window?.backingScaleFactor else { return }
        renderView.centerAndScale(pixelWidth: Double(renderView.bounds.width * pixelScale),
                                  pixelHeight: Double(renderView.bounds.height * pixelScale))
    }
    
}

