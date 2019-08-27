//
//  Mover.swift
//  2-1: Forces
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
    
    init() {
        position = TVector2(x: 30.0, y: tin.height - 30.0)
        velocity = TVector2(x: 0.0, y: 0.0)
        acceleration = TVector2(x: 0.0, y: 0.0)
        mass = 1.0
    }
    
    
    func applyForce(force: TVector2) {
        let f = force / mass
        acceleration = acceleration + f
    }
    
    
    func update() {
        velocity = velocity + acceleration
        position = position + velocity
        acceleration = acceleration * 0.0
    }
    
    
    func display() {
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.5)
        ellipse(centerX: position.x, centerY: position.y, width: 48.0, height: 48.0)
    }
    
    
    func checkEdges() {
        if position.x > tin.width {
            position.x = tin.width
            velocity.x *= -1.0
        } else if position.x < 0.0 {
            velocity.x *= -1.0
            position.x = 0.0
        }
        
        if position.y < 0.0 {
            velocity.y *= -1.0
            position.y = 0.0
        }
    }
    
}
