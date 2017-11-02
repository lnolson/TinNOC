//
//  Vehicle.swift
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// The "Vehicle" class

import Foundation
import Tin

class Vehicle {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var r: Double
    var maxforce: Double
    var maxspeed: Double
    var wandertheta: Double
    
    init(x: Double, y: Double) {
        acceleration = TVector2()
        velocity = TVector2(x: 0.0, y: 0.0)
        position = TVector2(x: x, y: y)
        r = 6.0
        maxspeed = 2.0
        maxforce = 0.05
        wandertheta = 0.0
    }
    
    func run() {
        update()
        borders()
        display()
    }
    
    
    func update() {
        velocity = velocity + acceleration
        velocity.limit(mag: maxspeed)
        position = position + velocity
        acceleration = acceleration * 0.0
    }
    
    
    func wander() {
        let wanderR = 25.0    // Radius for our "wander circle"
        let wanderD = 80.0    // Distance for our "wander circle"
        let change = 0.3
        wandertheta += random(min: -change, max: change)
        
        // Now we have to calculate the new position to steer towards on the wander circle
        var circlepos = velocity            // Start with velocity
        circlepos.normalize()
        circlepos = circlepos * wanderD     // Multiply by distance
        circlepos = circlepos + position    // Make it relative to boid's position
        
        let h = velocity.heading()          // We need to know the heading to offset wandertheta
        
        let cx = wanderR * cos(wandertheta + h)
        let cy = wanderR * sin(wandertheta + h)
        let circleOffset = TVector2(x: cx, y: cy)
        let target = circlepos + circleOffset
        seek(target: target)
        
        // Render wandering circle, etc.
        if debug {
            drawWanderStuff(position: position, circle: circlepos, target: target, rad: wanderR)
        }
    }
    
    
    func apply(force: TVector2) {
        acceleration = acceleration + force
    }
    
    
    func seek(target: TVector2) {
        var desired = target - position
        desired.normalize()
        desired = desired * maxspeed
        
        var steer = desired - velocity
        steer.limit(mag: maxforce)
        
        apply(force: steer)
    }
    
    // A method that calculates a steering force towards a target
    // STEER = DESIRED MINUS VELOCITY
    func arrive(target: TVector2) {
        var desired = target - position
        let d = desired.magnitude
        if d < 100 {
            let m = remap(value: d, start1: 0, stop1: 100, start2: 0, stop2: maxspeed)
            desired.magnitude = m
        }
        else {
            desired.magnitude = maxspeed
        }
        
        var steer = desired - velocity
        steer.limit(mag: maxforce)
        apply(force: steer)
    }
    
    
    // Wraparound
    func borders() {
        if position.x < -r {
            position.x = tin.width + r
        }
        if position.y < -r {
            position.y = tin.height + r
        }
        if position.x > tin.width + r {
            position.x = -r
        }
        if position.y > tin.height + r {
            position.y = -r
        }
    }
    
    
    
    func display() {
        let theta = velocity.heading() + .pi / 2.0
        fillColor(gray: 0.5)
        strokeColor(gray: 0.0)
        lineWidth(1.0)
        pushState()
        translate(dx: position.x, dy: position.y)
        rotate(by: theta)
        pathBegin()
        pathVertex(x: 0.0, y: -r * 2.0)
        pathVertex(x: -r, y: r * 2.0)
        pathVertex(x:  r, y: r * 2.0)
        pathClose()
        pathEnd()
        popState()
    }
}



func drawWanderStuff(position: TVector2, circle: TVector2, target: TVector2, rad: Double) {
    strokeColor(gray: 0)
    fillDisable()
    lineWidth(1)
    ellipse(centerX: circle.x, centerY: circle.y, width: rad * 2, height: rad * 2)
    ellipse(centerX: target.x, centerY: target.y, width: 4, height: 4)
    line(x1: position.x, y1: position.y, x2: circle.x, y2: circle.y)
    line(x1: circle.x, y1: circle.y, x2: target.x, y2: target.y)
}

