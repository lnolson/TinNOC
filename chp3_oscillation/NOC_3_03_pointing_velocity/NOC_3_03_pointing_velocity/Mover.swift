//
//  Mover.swift
//  NOC_3_03_pointing_velocity
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
    var topspeed: Double
    var mass: Double
    
    init() {
        position = TVector2(x: tin.midX, y: tin.midY)
        velocity = TVector2(x: 0.0, y: 0.0)
        acceleration = TVector2(x: 0.0, y: 0.0)
        topspeed = 4.0
        mass = 1.0
    }
    
    
    func applyForce(force: TVector2) {
        let f = force / mass
        acceleration = acceleration + f
    }
    
    
    func update() {
        let mouse = TVector2(x: tin.mouseX, y: tin.mouseY)
        var dir = mouse - position
        dir.normalize()
        dir = dir * 0.5
        acceleration = dir
        velocity = velocity + acceleration
        velocity.limit(mag: topspeed)
        position = position + velocity
        
        acceleration = acceleration * 0.0
    }
    
    
    func display() {
        let theta = velocity.heading()
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.0, alpha: 0.5)
        pushState()
        translate(dx: position.x, dy: position.y)
        rotate(by: theta)
        rect(x: -15.0, y: -5.0, width: 30.0, height: 10.0)
        popState()
    }
    
    
    func checkEdges() {
        if position.x > tin.width {
            position.x = 0.0
        }
        else if position.x < 0.0 {
            position.x = tin.width
        }
        
        if position.y > tin.height {
            position.y = 0.0
        }
        else if position.y < 0.0 {
            position.y = tin.height
        }
    }
    
}

