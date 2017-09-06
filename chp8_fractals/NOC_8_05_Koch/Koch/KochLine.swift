//
//  KochLine.swift
//  Koch
//
//

// Koch Curve
// A class to describe one line segment in the fractal
// Includes methods to calculate midPVectors along the line according to the Koch algorithm


import Cocoa
import Tin



class KochLine {
    var a: TVector2
    var b: TVector2
    
    
    init(start: TVector2, end: TVector2) {
        a = start
        b = end
    }
    
    
    func display() {
        strokeColor(gray: 0.0)
        line(x1: a.x, y1: a.y, x2: b.x, y2: b.y)
    }
    
    
    func start() -> TVector2 {
        return a
    }
    
    
    func end() -> TVector2 {
        return b
    }
    
    
    func kochleft() -> TVector2 {
        var v = b - a
        v = v / 3.0
        v = v + a
        return v
    }
    
    
    func kochmiddle() -> TVector2 {
        var v = b - a
        v = v / 3.0
        
        var p = a
        p = p + v
        
        // rotate 60 degrees
        let theta = toRadians(degrees: 60.0)
        let xTemp = v.x
        v.x = v.x * cos(theta) - v.y * sin(theta)
        v.y = xTemp * sin(theta) + v.y * cos(theta)
        
        p = p + v
        
        return p
    }
    
    
    func kochright() -> TVector2 {
        var v = a - b
        v = v / 3.0
        v = v + b
        return v
    }
    
    
    
}
