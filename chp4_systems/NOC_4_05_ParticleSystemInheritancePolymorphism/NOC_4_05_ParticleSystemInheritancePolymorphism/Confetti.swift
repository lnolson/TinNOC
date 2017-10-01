//
//  Confetti.swift
//  NOC_4_05_ParticleSystemInheritancePolymorphism
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import Foundation
import Tin

class Confetti: Particle {
    
    override init(location: TVector2) {
        super.init(location: location)
    }
    
    
    override func display() {
        let a = lifespan / 255.0
        fillColor(gray: 0.5, alpha: a)
        strokeColor(gray: 0.0, alpha: a)
        lineWidth(2.0)
        pushState()
        
        translate(dx: position.x, dy: position.y)
        let theta = remap(value: position.x, start1: 0.0, stop1: tin.width, start2: 0.0, stop2: Double.pi * 4.0)
        rotate(by: theta)
        rect(x: -6, y: -6, width: 12, height: 12)
        
        popState()
    }
}
