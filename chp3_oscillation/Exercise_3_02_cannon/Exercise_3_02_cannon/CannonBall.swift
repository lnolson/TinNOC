//
//  CannonBall.swift
//  Exercise_3_02_cannon
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import Foundation
import Tin


class CannonBall {
    // All of our regular motion stuff
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var r = 8.0;
    var topspeed = 10.0;
    var mass = 1.0
    
    init(x: Double, y: Double) {
        position = TVector2(x: x, y: y)
        velocity = TVector2()
        acceleration = TVector2()
    }
    
    
    func update() {
        velocity = velocity + acceleration
        velocity.limit(mag: topspeed)
        position = position + velocity
        
        acceleration = acceleration * 0.0
    }
    
    
    func applyForce(force: TVector2) {
        let f = force / mass
        acceleration = acceleration + f
    }
    
    
    func display() {
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        pushState()
        translate(dx: position.x, dy: position.y)
        ellipse(centerX: 0.0, centerY: 0.0, width: r * 2.0, height: r * 2.0)
        popState()
    }
    
    
}
