//
//  Mover.swift
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
//

import Foundation
import Tin

class Mover {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var mass: Double
    var angle: Double
    var aVelocity: Double
    var aAcceleration: Double
    
    init(mass: Double, x: Double, y: Double) {
        position = TVector2(x: x, y: y)
        velocity = TVector2(x: TRandom.next(min: -1.0, max: 1.0), y: TRandom.next(min: -1.0, max: 1.0))
        acceleration = TVector2(x: 0.0, y: 0.0)
        self.mass = mass
        angle = 0.0
        aVelocity = 0.0
        aAcceleration = 0.0
    }
    
    
    func applyForce(force: TVector2) {
        let f = force / mass
        acceleration = acceleration + f
    }
    
    
    func update() {
        velocity = velocity + acceleration
        position = position + velocity
        
        aAcceleration = acceleration.x / 10.0
        aVelocity += aAcceleration
        aVelocity = constrain(value: aVelocity, min: -0.1, max: 0.1)
        angle += aVelocity
        
        acceleration = acceleration * 0.0
    }
    
    
    func display() {
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.0, alpha: 0.5)
        pushState()
        translate(dx: position.x, dy: position.y)
        rotate(by: angle)
        let w = mass * 16.0
        let w2 = w / 2.0
        rect(x: -w2, y: -w2, width: w, height: w)
        popState()
    }
    
}
