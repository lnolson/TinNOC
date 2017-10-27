//
//  Vehicle.swift
//  
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Vehicle class

import Foundation
import Tin

class Vehicle {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var r: Double
    var maxforce: Double
    var maxspeed: Double
    
    
    init(x: Double, y: Double) {
        acceleration = TVector2()
        let a = random(max: Double.pi * 2.0)
        let vx = cos(a)
        let vy = sin(a)
        velocity = TVector2(x: vx, y: vy)
        position = TVector2(x: x, y: y)
        r = 12.0
        maxspeed = 3.0
        maxforce = 0.2
    }
    
    
    func update() {
        velocity = velocity + acceleration
        velocity.limit(mag: maxspeed)
        position = position + velocity
        acceleration = acceleration * 0.0
    }
    
    
    func apply(force: TVector2) {
        acceleration = acceleration + force
    }
    
    
    
    // Separation
    // Method checks for nearby vehicles and steers away
    func separate(vehicles: [Vehicle]) {
        let desiredSeparation = r * 2.0
        var sum = TVector2()
        var count = 0
        // For every boid in the system, check if it's too close
        for other in vehicles {
            let d = position.distance(v: other.position)
            if d > 0.0 && d < desiredSeparation {
                var diff = position - other.position
                diff.normalize()
                diff = diff / d         // Weight by distance
                sum = sum + diff
                count += 1             // Keep track of how many
            }
        }
        
        // Average -- divide by how many
        if count > 0 {
            // Our desired vector is moving away maximum speed
            sum.magnitude = maxspeed
            // Implement Reynolds: Steering = Desired - Velocity
            var steer = sum - velocity
            steer.limit(mag: maxforce)
            apply(force: steer)
        }
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
    
    
    // Alignment
    // For every nearby boid in the system, calculate the average velocity
    func align(boids: [Vehicle]) {
        let neighbordist = 30.0
        var sum = TVector2()
        var count = 0
        for other in boids {
            let d = position.distance(v: other.position)
            if d > 0.0 && d < neighbordist {
                sum = sum + other.velocity
                count += 1
            }
        }
        if count > 0 {
            sum = sum / Double(count)
            sum.normalize()
            sum = sum * maxspeed
            var steer = sum - velocity
            steer.limit(mag: maxforce)
            apply(force: steer)
        }
    }
    
    
    func display() {
        fillColor(gray: 0.6862)
        strokeColor(gray: 0)
        lineWidth(1.0)
        pushState()
        translate(dx: position.x, dy: position.y)
        ellipse(centerX: 0, centerY: 0, width: r, height: r)
        popState()
    }
    
    
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
}

