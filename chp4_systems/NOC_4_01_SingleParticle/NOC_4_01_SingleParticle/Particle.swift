//
//  Particle.swift
//  NOC_4_01_SingleParticle
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


import Foundation
import Tin


class Particle {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var lifespan: Double
    
    
    init(location: TVector2) {
        position = location
        velocity = TVector2(x: random(min: -1.0, max: 1.0), y: random(min: 1.0, max: 0.0))
        acceleration = TVector2(x: 0.0, y: -0.05)
        lifespan = 255.0
    }
    
    
    func run() {
        update()
        display()
    }
    
    
    func update() {
        velocity = velocity + acceleration
        position = position + velocity
        lifespan -= 2.0
    }
    
    
    func display() {
        let a = lifespan / 255.0
        strokeColor(gray: 0.0, alpha: a)
        lineWidth(2.0)
        fillColor(gray: 0.5, alpha: a)
        ellipse(centerX: position.x, centerY: position.y, width: 12.0, height: 12.0)
    }
    
    
    func isDead() -> Bool {
        if lifespan < 0.0 {
            return true
        }
        else {
            return false
        }
    }
}
