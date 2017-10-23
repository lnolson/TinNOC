//
//  Vehicle.swift
//  NOC_6_06
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
        
        // Now we must find the normal to the path from the predicted position
        // We look at the normal for each line segment and pick out the closest one

        var normal: TVector2?
        var target: TVector2?
        var worldRecord = 1000000.0
        
        // Loop through all points of the path
        for i in 0 ..< p.points.count-1 {
            // Look at a line segment
            let a = p.points[i]
            let b = p.points[i+1]
            
            // Get the normal point to that line
            var normalPoint = getNormalPoint(p: predictpos, a: a, b: b)
            
            // This only works because we know our path goes from left to right
            // We could have a more sophisticated test to tell if the point is in the line segment or not
            if normalPoint.x < a.x || normalPoint.x > b.x {
                // This is something of a hacky solution, but if it's not within the line segment
                // consider the normal to just be the end of the line segment (point b)
                normalPoint = b;
            }
            
            // How far away are we from the path?
            let distance = predictpos.distance(v: normalPoint)
            // Did we beat the record and find the closest line segment?
            if distance < worldRecord {
                worldRecord = distance
                // If so the target we want to steer towards is the normal
                normal = normalPoint
                
                // Look at the direction of the line segment so we can seek a little bit ahead of the normal
                var dir = b - a
                dir.normalize()
                // This is an oversimplification
                // Should be based on distance to path & velocity
                dir = dir * 10.0   // This could be based on velocity instead of just an arbitrary 10 pixels
                target = normalPoint + dir
            }
        }
        
        // Only if the distance is greater than the path's radius do we bother to steer
        if worldRecord > p.radius {
            if let target = target {
                seek(target: target)
            }
        }
        
        if Scene.debug() {
            fillColor(gray: 0)
            strokeColor(gray: 0)
            line(x1: position.x, y1: position.y, x2: predictpos.x, y2: predictpos.y)
            ellipse(centerX: predictpos.x, centerY: predictpos.y, width: 4, height: 4)
            
            // Draw normal position
            fillColor(gray: 0)
            strokeColor(gray: 0)
            if let normal = normal {
                line(x1: predictpos.x, y1: predictpos.y, x2: normal.x, y2: normal.y)
                ellipse(centerX: normal.x, centerY: normal.y, width: 4, height: 4)
            }
            if worldRecord > p.radius {
                fillColor(red: 1, green: 0, blue: 0, alpha: 1)
            }
            strokeDisable()
            if let target = target {
                ellipse(centerX: target.x, centerY: target.y, width: 8, height: 8)
            }
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
        guard let end = p.getEnd() else { return }
        guard let start = p.getStart() else { return }
        if position.x > end.x + r {
            position.x = start.x - r;
            position.y = start.y + (position.y-end.y);
        }
    }
    
}

