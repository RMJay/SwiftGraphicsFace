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
    var panStart = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load face data and generate a 3D object
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
        
        //Adding observers for user interactions
        let leftMousePan = NSPanGestureRecognizer(target: self, action: .leftMousePan)
        leftMousePan.buttonMask = 0b001 //left button
        renderView.addGestureRecognizer(leftMousePan)
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
    
    @objc func leftMousePan(pan: NSPanGestureRecognizer) {
        let translation = pan.translation(in: renderView)
        let increment = translation - panStart
        switch pan.state {
        case .began, .changed:
            print("leftMousePan increment[x:\(increment.dx), y:\(increment.dy)]")
            panStart = translation
            let θx = Double(-increment.dy / renderView.bounds.width)
            let θy = Double(-increment.dx / renderView.bounds.width)
            renderView.rotateBy(θx: θx, θy: θy)
        case .ended:
            panStart = CGPoint.zero
        default: break
        }
    }
    
}

fileprivate extension Selector {
    static let leftMousePan = #selector(ViewController.leftMousePan)
}

fileprivate extension CGPoint {
    static func - (left: CGPoint, right: CGPoint) -> CGVector {
        return CGVector(dx: left.x - right.x, dy: left.y - right.y)
    }
}

