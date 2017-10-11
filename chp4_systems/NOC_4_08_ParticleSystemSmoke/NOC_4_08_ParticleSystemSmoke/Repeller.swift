//
//  Repeller.swift
//  NOC_4_07_ParticleSystemForcesRepeller
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Particles + Forces

// A very basic Repeller class

import Foundation
import Tin

class Repeller {
    var g: Double   // Gravitational constant
    var position: TVector2
    var r: Double
    
    
    init(x: Double, y: Double) {
        position = TVector2(x: x, y: y)
        g = 100.0
        r = 10.0
    }
    
    
    func display() {
        strokeColor(gray: 0)
        lineWidth(2)
        fillColor(gray: 0.6862)
        ellipse(centerX: position.x, centerY: position.y, width: 48, height: 48)
    }
    
    
    func repel(p: Particle) -> TVector2 {
        var dir = position - p.position
        var d = dir.magnitude
        dir.normalize()
        d = constrain(value: d, min: 5.0, max: 100.0)
        let force = -1.0 * g / (d * d)
        dir = dir * force
        return dir
    }
    
}
