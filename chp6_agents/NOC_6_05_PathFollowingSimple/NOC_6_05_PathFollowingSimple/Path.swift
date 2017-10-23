//
//  Path.swift
//  NOC_6_05_PathFollowingSimple
//
//
// Path Following

import Foundation
import Tin


class Path {
    // A Path is line between two points (TVector2 objects)
    var start: TVector2
    var end: TVector2
    // A path has a radius, i.e how far is it ok for the boid to wander off
    var radius: Double
    
    
    init() {
        // Arbitrary radius of 20
        radius = 20.0
        start = TVector2(x: 0, y: (tin.height/3.0) * 2.0)
        end = TVector2(x: tin.width, y: tin.height/3.0)
    }
    
    // Draw the path
    func display() {
        lineWidth(radius * 2.0)
        strokeColor(gray: 0.0, alpha: 0.3921)
        line(x1: start.x, y1: start.y, x2: end.x, y2: end.y)
        
        lineWidth(1.0)
        strokeColor(gray: 0.0)
        line(x1: start.x, y1: start.y, x2: end.x, y2: end.y)
    }
    
}
