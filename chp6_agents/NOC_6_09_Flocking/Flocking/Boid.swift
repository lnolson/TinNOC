//
//  Boid.swift
//  Flocking
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Boid class
// Methods for Separation, Cohesion, Alignment added

import Cocoa
import Tin


class Boid {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var r: Double
    var maxforce: Double     // Maximum steering force
    var maxspeed: Double     // Maximum speed
    
    
    init(x: Double, y: Double) {
        acceleration = TVector2(x: 0.0, y: 0.0)
        velocity = TVector2(x: TRandom.next(min: -1.0, max: 1.0), y: TRandom.next(min: -1.0, max: 1.0))
        position = TVector2(x: x, y: y)
        r = 3.0
        maxspeed = TRandom.next(min: 2.0, max: 3.0)
        maxforce = 0.05
    }
    
    
    func run(boids: [Boid]) {
        flock(boids: boids)
        update()
        borders()
        render()
    }
    
    
    func applyForce(force: TVector2) {
        acceleration = acceleration + force
    }
    
    
    // We accumulate a new acceleration each time based on three rules
    func flock(boids: [Boid]) {
        var sep = separate(boids: boids)
        var ali = align(boids: boids)
        var coh = cohesion(boids: boids)
        
        sep = sep * 1.5
        ali = ali * 1.0
        coh = coh * 1.0
        
        applyForce(force: sep)
        applyForce(force: ali)
        applyForce(force: coh)
    }
    
    
    func update() {
        velocity = velocity + acceleration
        velocity.limit(mag: maxspeed)
        position = position + velocity
        acceleration = acceleration * 0.0
    }
    
    
    // A method that calculates and applies a steering force towards a target
    // STEER = DESIRED MINUS VELOCITY
    func seek(target: TVector2) -> TVector2 {
        var desired = target - position
        desired.normalize()
        desired = desired * maxspeed
        var steer = desired - velocity
        steer.limit(mag: maxforce)
        return steer
    }
    
    
    func render() {
        let theta = velocity.heading() + toRadians(degrees: 90.0)
        pushState()
        fillColor(gray: 0.68)
        strokeColor(gray: 0.0)
        lineWidth(1.0)
        translate(dx: position.x, dy: position.y)
        rotate(by: theta)
        triangle(x1: 0.0, y1: -r * 2.0, x2: -r, y2: r * 2.0, x3: r, y3: r * 2.0)
        popState()
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
    
    
    // Separation
    // Method checks for nearby boids and steers away
    func separate(boids: [Boid]) -> TVector2 {
        let desiredseparation = 25.0
        var steer = TVector2(x: 0.0, y: 0.0)
        var count = 0
        for other in boids {
            let d = position.distance(v: other.position)
            if d > 0.0 && d < desiredseparation {
                var diff = position - other.position
                diff.normalize()
                diff = diff / d
                steer = steer + diff
                count += 1
            }
        }
        if count > 0 {
            steer = steer / Double(count)
        }
        
        if steer.magnitude > 0.0 {
            steer.normalize()
            steer = steer * maxspeed
            steer = steer - velocity
            steer.limit(mag: maxforce)
        }
        
        return steer
    }
    
    
    // Alignment
    // For every nearby boid in the system, calculate the average velocity
    func align(boids: [Boid]) -> TVector2 {
        let neighbordist = 50.0
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
            return steer
        }
        else {
            return TVector2()
        }
    }
    
    
    // Cohesion
    // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
    func cohesion(boids: [Boid]) -> TVector2 {
        let neighbordist = 50.0
        var sum = TVector2()
        var count = 0
        for other in boids {
            let d = position.distance(v: other.position)
            if d > 0.0 && d < neighbordist {
                sum = sum + other.position
                count += 1
            }
        }
        if count > 0 {
            sum = sum / Double(count)
            return seek(target: sum)
        }
        else {
            return TVector2()
        }
    }
    
}
