//
//  ModelReader.swift
//  SwiftGraphicsFace
//
//  Created by Robert Muckle-Jones on 18/03/2019.
//  Copyright © 2019 Robert Muckle-Jones. All rights reserved.
//
import Foundation

class Object3DReader {
    
    static func read(vertexDataFile: FileHandle, triangleDataFile: FileHandle) throws -> Object3D {
        var vertexAcc = [VertexData]()
        let vertexLineReader = LineReader(file: vertexDataFile)
        _ = vertexLineReader.nextLine() //ignore title line
        for line in vertexLineReader {
            let split = line.split(separator: " ")
            vertexAcc.append(VertexData(
                x: Double(split[0])!,
                y: Double(split[1])!,
                z: Double(split[2])!,
                r: UInt8(split[3])!,
                g: UInt8(split[4])!,
                b: UInt8(split[5])!
            ))
        }
        let allVertexes = vertexAcc
        
        var triangleDataAcc = [TriangleData]()
        var adjacencyList = [Int: [TriangleData]]()
        for i in 0..<allVertexes.count {
            adjacencyList[i] = [TriangleData]()
        }
    
        let triangleLineReader = LineReader(file: triangleDataFile)
        for line in triangleLineReader {
            let vertexIndexes = line
                .split(separator: " ")
                .map{ indexStr -> Int in
                    Int(indexStr)!
                }
                
            let vertexDataTriple = vertexIndexes
                .map{ index -> VertexData in
                    allVertexes[index]
                }
            
            let vertexes = vertexDataTriple
                .map{ vertexData -> Point3D in
                    Point3D(x: vertexData.x, y: vertexData.y, z: vertexData.z)
                }
            
            let colors = vertexDataTriple
                .map{ vertexData -> ColorRGB in
                    ColorRGB(r: vertexData.r, g: vertexData.g, b: vertexData.b)
                }
            
            let v0ToV1 = vertexes[1] - vertexes[0]
            let v0ToV2 = vertexes[2] - vertexes[0]
            let faceNormal = (v0ToV1 ⨯ v0ToV2).normalized()
            
            let triangleData = TriangleData(vertexes: vertexes,
                                            vertexIndexes: vertexIndexes,
                                            colors: colors,
                                            faceNormal: faceNormal)
            
            triangleDataAcc.append(triangleData)
            for vertexIndex in vertexIndexes {
                adjacencyList[vertexIndex]?.append(triangleData)
            }
        }
        
        let triangles = triangleDataAcc.map{ triangleData -> Triangle3D in
            let normals = triangleData.vertexIndexes
                .map{ vertexIndex -> Vector3D in
                    let adjacentTriangles = adjacencyList[vertexIndex]!
                    var sumNormal = Vector3D(x: 0.0, y: 0.0, z: 0.0)
                    for triangle in adjacentTriangles {
                        sumNormal += triangle.faceNormal
                    }
                    return sumNormal.normalized()
                }
            return Triangle3D(vertexes: triangleData.vertexes,
                              colors: triangleData.colors,
                              faceNormal: triangleData.faceNormal,
                              normals: normals)
            }
        
        return Object3D(triangles: triangles)
    }
    
}

fileprivate struct VertexData {
    let x: Double
    let y: Double
    let z: Double
    let r: UInt8
    let g: UInt8
    let b: UInt8
}

fileprivate struct TriangleData {
    let vertexes: [Point3D]
    let vertexIndexes: [Int]
    let colors: [ColorRGB] //the color at each vertex
    let faceNormal: Vector3D
}
