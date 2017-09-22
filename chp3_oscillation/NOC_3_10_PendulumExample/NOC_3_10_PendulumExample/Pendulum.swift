//
//  Pendulum.swift
//  NOC_3_10_PendulumExample
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Pendulum

// A Simple Pendulum Class
// Includes functionality for user can click and drag the pendulum

import Foundation
import Tin

class Pendulum {
    var position: TVector2          // position of pendulum ball
    var origin: TVector2            // position of arm origin
    var r: Double                   // length of arm
    var angle: Double               // pendulum arm angle
    var aVelocity: Double           // angle velocity
    var aAcceleration: Double       // angle acceleration
    
    var ballr: Double               // ball radius
    var damping: Double             // arbitrary damping amount
    
    var dragging: Bool
    
    init(origin: TVector2, r: Double) {
        self.origin = origin
        self.r = r
        position = TVector2()
        angle = Double.pi / 4.0
        aVelocity = 0.0
        aAcceleration = 0.0
        damping = 0.995
        ballr = 48.0
        dragging = false
    }
    
    
    func go() {
        update()
        drag()
        display()
    }
    
    
    func update() {
        if !dragging {
            let gravity = 0.4
            
            // Calculate acceleration (see: http://www.myphysicslab.com/pendulum1.html)
            aAcceleration = (-1.0 * gravity / r) * sin(angle)
            
            aVelocity += aAcceleration
            aVelocity *= damping
            angle += aVelocity
        }
    }
    
    
    func display() {
        let x = r * sin(angle)
        let y = r * cos(angle)
        position = TVector2(x: x, y: y)
        position = origin - position
        
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        
        // Draw arm
        line(x1: origin.x, y1: origin.y, x2: position.x, y2: position.y)
        fillColor(gray: 0.6862)
        if dragging {
            fillColor(gray: 0.0)
        }
        
        // Draw the ball
        ellipse(centerX: position.x, centerY: position.y, width: ballr, height: ballr)
    }
    
    
    // The methods below are for mouse interaction
    
    // This checks to see if we clicked on the pendulum ball
    func clicked(mx: Double, my: Double) {
        let d = dist(x1: mx, y1: my, x2: position.x, y2: position.y)
        if d < ballr {
            dragging = true
        }
    }
    
    // This tells us we are no longer clicking on the ball
    func stopDragging() {
        if dragging {
            aVelocity = 0.0
            dragging = false
        }
    }
    
    
    func drag() {
        // If we are draging the ball, we calculate the angle between the
        // pendulum origin and mouse position
        // we assign that angle to the pendulum
        if dragging {
            let mouse = TVector2(x: tin.mouseX, y: tin.mouseY)
            let diff = origin - mouse
            angle = atan2(-1.0 * diff.y, diff.x) + toRadians(degrees: 90.0)
        }
    }
    
}
