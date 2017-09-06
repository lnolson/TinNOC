//
//  Boid.swift
//  Flocking
//
//  Translation from The Nature of Code, Daniel Shiffman
//  Ch 6. Flocking
//

import Cocoa
import Tin


class Boid {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var r: Double
    var maxforce: Double
    var maxspeed: Double
    
    
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
        Tin.rotate(by: theta)
        triangle(x1: 0.0, y1: -r * 2.0, x2: -r, y2: r * 2.0, x3: r, y3: r * 2.0)
        popState()
    }
    
    
    func borders() {
        if position.x < -r {
            position.x = Double(tin.size.width) + r
        }
        if position.y < -r {
            position.y = Double(tin.size.height) + r
        }
        if position.x > Double(tin.size.width) + r {
            position.x = -r
        }
        if position.y > Double(tin.size.height) + r {
            position.y = -r
        }
    }
    
    
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
