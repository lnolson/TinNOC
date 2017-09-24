//
//  Bob.swift
//  Exercise_3_16_springs
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Bob class, just like our regular Mover (position, velocity, acceleration, mass)

import Foundation
import Tin

class Bob {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var mass: Double
    
    // Arbitrary damping to simulate friction / drag
    var damping: Double
    
    // For mouse interaction
    var dragOffset: TVector2
    var dragging: Bool
    var dragable: Bool
    
    init(x: Double, y: Double) {
        position = TVector2(x: x, y: y)
        velocity = TVector2(x: 0.0, y: 0.0)
        acceleration = TVector2(x: 0.0, y: 0.0)
        mass = 12.0
        damping = 0.95
        dragOffset = TVector2(x: 0.0, y: 0.0)
        dragging = false
        dragable = false
    }
    
    
    func applyForce(force: TVector2) {
        let f = force / mass
        acceleration = acceleration + f
    }
    
    
    func update() {
        velocity = velocity + acceleration
        velocity = velocity * damping
        position = position + velocity
        
        acceleration = acceleration * 0.0
    }
    
    
    func display() {
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        if dragging {
            fillColor(gray: 0.1968)
        }
        else if dragable {
            fillColor(red: 0.1, green: 0.68, blue: 0.1, alpha: 1.0)
        }
        else {
            fillColor(gray: 0.6862)
        }
        ellipse(centerX: position.x, centerY: position.y, width: mass * 2.0, height: mass * 2.0)
    }
    
    
    // The methods below are for mouse interaction
    
    // This checks to see if we clicked on the mover
    func clicked(mx: Double, my: Double) {
        let d = dist(x1: mx, y1: my, x2: position.x, y2: position.y)
        if d < mass {
            dragging = true
            dragOffset.x = position.x - mx
            dragOffset.y = position.y - my
        }
    }
    
    
    // This tells us we are no longer clicking on the ball
    func stopDragging() {
        dragging = false
    }
    
    
    func drag(mx: Double, my: Double) {
        if dragging {
            position.x = mx + dragOffset.x
            position.y = my + dragOffset.y
        }
    }
}

