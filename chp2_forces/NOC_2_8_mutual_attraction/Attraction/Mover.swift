//
//  Mover.swift
//  2-4: Forces Friction
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
//

import Foundation
import Tin


let g = 0.4


class Mover {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var mass: Double
    
    init(mass: Double, x: Double, y: Double) {
        position = TVector2(x: x, y: y)
        velocity = TVector2(x: 0.0, y: 0.0)
        acceleration = TVector2(x: 0.0, y: 0.0)
        self.mass = mass
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
        fillColor(gray: 0.0, alpha: 0.5)
        ellipse(centerX: position.x, centerY: position.y, width: mass * 16.0, height: mass * 16.0)
    }
    
    
    func checkEdges() {
        if position.x > Double(tin.size.width) {
            position.x = Double(tin.size.width);
            velocity.x *= -1.0;
        } else if (position.x < 0.0) {
            velocity.x *= -1.0;
            position.x = 0.0;
        }
        
        if (position.y < 0.0) {
            velocity.y *= -1.0;
            position.y = 0.0;
        }
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
    
}
