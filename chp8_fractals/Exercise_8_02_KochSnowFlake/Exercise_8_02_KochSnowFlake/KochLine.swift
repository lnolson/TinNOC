//
//  KochLine.swift
//  NOC_8_05_KochSimple
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Koch Curve
// A class to describe one line segment in the fractal
// Includes methods to calculate midPVectors along the line according to the Koch algorithm



import Foundation
import Tin


class KochLine {
    // Two PVectors,
    // a is the "left" TVector2 and
    // b is the "right TVector2
    var start: TVector2
    var end: TVector2
    
    
    init(a: TVector2, b: TVector2) {
        start = a
        end = b
    }
    
    
    func display() {
        strokeColor(gray: 0)
        line(x1: start.x, y1: start.y, x2: end.x, y2: end.y)
    }
    
    
    func kochA() -> TVector2 {
        return start
    }
    
    
    // This is easy, just 1/3 of the way
    func kochB() -> TVector2 {
        var v = end - start
        v = v / 3.0
        v = start + v
        return v
    }

    // More complicated, have to use a little trig to figure out where this TVector2 is!
    func kochC() -> TVector2 {
        var a = start   // Start at the beginning
        
        var v = end - start
        v = v / 3.0
        a = a + v       // Move to point B
        
        v.rotate(theta: toRadians(degrees: -60.0))
        
        a = a + v       // Move to point C
        
        return a
    }

    
    // Easy, just 2/3 of the way
    func kochD() -> TVector2 {
        var v = end - start
        v = v * (2.0/3.0)
        v = start + v
        return v
    }

    
    func kochE() -> TVector2 {
        return end
    }
    
}
