//
//  Attractor.swift
//  Forces_angular_motion
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Attraction

// A class for a draggable attractive body in our world


import Foundation
import Tin

class Attractor {
    var mass: Double
    var position: TVector2
    var g: Double
    
    init() {
        position = TVector2(x: Double(tin.size.width)/2.0, y: Double(tin.size.height)/2.0)
        mass = 20.0
        g = 0.4
    }
    
    func attract(mover: Mover) -> TVector2 {
        var force = position - mover.position
        var d = force.magnitude
        d = constrain(value: d, min: 5.0, max: 25.0)
        force.normalize()
        let strength = (g * mass * mover.mass) / (d * d)
        force = force * strength
        return force
    }
    
    func display() {
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.5)
        ellipse(centerX: position.x, centerY: position.y, width: 48.0, height: 48.0)
    }
}
