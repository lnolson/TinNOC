//
//  Vehicle.swift
//  NOC_6_05
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


// The Vehicle class

import Foundation
import Tin

class Vehicle {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var r: Double
    var maxforce: Double
    var maxspeed: Double
    
    
    init(position p: TVector2, ms: Double, mf: Double) {
        position = p
        r = 4.0
        maxspeed = ms
        maxforce = mf
        acceleration = TVector2()
        velocity = TVector2(x: maxspeed, y: 0.0)
    }
    
    
    func run() {
        update()
        display()
    }
    
    
    // This function implements Craig Reynolds' path following algorithm
    // http://www.red3d.com/cwr/steer/PathFollow.html
    func follow(p: Path) {
        // Predict position 50 (arbitrary choice) frames ahead
        var predict = velocity
        predict.normalize()
        predict = predict * 50.0
        let predictpos = position + predict
        
        // Look at the line segment
        let a = p.start
        let b = p.end
        
        // Get the normal point to that line
        let normalPoint = getNormalPoint(p: predictpos, a: a, b: b)
        
        // Find target point a little further ahead of normal
        var dir = b - a
        dir.normalize()
        dir = dir * 10.0   // This could be based on velocity instead of just an arbitrary 10 pixels
        let target = normalPoint + dir
        
        // How far away are we from the path?
        let distance = predictpos.distance(v: normalPoint)
        // Only if the distance is greater than the path's radius do we bother to steer
        if distance > p.radius {
            seek(target: target)
        }
        
        if Scene.debug() {
            fillColor(gray: 0)
            strokeColor(gray: 0)
            line(x1: position.x, y1: position.y, x2: predictpos.x, y2: predictpos.y)
            ellipse(centerX: predictpos.x, centerY: predictpos.y, width: 4, height: 4)
            
            // Draw normal position
            fillColor(gray: 0)
            strokeColor(gray: 0)
            line(x1: predictpos.x, y1: predictpos.y, x2: normalPoint.x, y2: normalPoint.y)
            ellipse(centerX: normalPoint.x, centerY: normalPoint.y, width: 4, height: 4)
            if distance > p.radius {
                fillColor(red: 1, green: 0, blue: 0, alpha: 1)
            }
            strokeDisable()
            ellipse(centerX: target.x+dir.x, centerY: target.y+dir.y, width: 8, height: 8)
        }
    }
    
    
    // A function to get the normal point from a point (p) to a line segment (a-b)
    // This function could be optimized to make fewer new Vector objects
    func getNormalPoint(p: TVector2, a: TVector2, b: TVector2) -> TVector2 {
        // Vector from a to p
        let ap = p - a
    
        // Vector from a to b
        var ab = b - a
        ab.normalize()  // Normalize the line
        
        // Project vector "diff" onto line by using the dot product
        ab = ab * ap.dot(v: ab)
        
        let normalPoint = a + ab
        return normalPoint;
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
    
    
    func seek(target: TVector2) {
        var desired = target - position
        
        // If the magnitude of desired equals 0, skip out of here
        // (We could optimize this to check if x and y are 0 to avoid mag() square root
        if desired.magnitude == 0.0 {
            return
        }
        
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
    
    
    func boundaries(d: Double) {
        var v: TVector2? = nil
        
        if position.x < d {
            v = TVector2(x: maxspeed, y: velocity.y)
        }
        else if position.x > tin.width - d {
            v = TVector2(x: -maxspeed, y: velocity.y)
        }
        
        if position.y < d {
            v = TVector2(x: velocity.x, y: maxspeed)
        }
        else if position.y > tin.height - d {
            v = TVector2(x: velocity.x, y: -maxspeed)
        }
        
        if var desired = v {
            desired.normalize()
            desired = desired * maxspeed
            var steer = desired - velocity
            steer.limit(mag: maxforce)
            apply(force: steer)
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
    
    
    // Wraparound
    func borders(p: Path) {
        if position.x > p.end.x + r {
            position.x = p.start.x - r;
            position.y = p.start.y + (position.y-p.end.y);
        }
    }
    
}

