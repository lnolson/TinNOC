//
//  Path.swift
//  NOC_6_06_PathFollowing
//
//
// Path Following

import Foundation
import Tin


class Path {
    // A Path is an array of points (TVector2 objects)
    var points: [TVector2]
    // A path has a radius, i.e how far is it ok for the boid to wander off
    var radius: Double
    
    
    init() {
        // Arbitrary radius of 20
        radius = 20.0
        points = []
    }
    
    
    func addPoint(x: Double, y: Double) {
        let point = TVector2(x: x, y: y)
        points.append(point)
    }
    
    
    func getStart() -> TVector2? {
        return points.first
    }
    
    
    func getEnd() -> TVector2? {
        return points.last
    }
    
    
    // Draw the path
    func display() {
        if let context = NSGraphicsContext.current {
            let cg = context.cgContext
            cg.setLineJoin(.round)
        }
        
        // Draw thick line for radius
        lineWidth(radius * 2.0)
        fillDisable()
        strokeColor(gray: 0.0, alpha: 0.3921)
        pathBegin()
        for p in points {
            pathVertex(x: p.x, y: p.y)
        }
        pathClose()
        pathEnd()
        
        // Draw thin line for center of path
        lineWidth(1.0)
        strokeColor(gray: 0.0)
        pathBegin()
        for p in points {
            pathVertex(x: p.x, y: p.y)
        }
        pathClose()
        pathEnd()
    }
    
}
