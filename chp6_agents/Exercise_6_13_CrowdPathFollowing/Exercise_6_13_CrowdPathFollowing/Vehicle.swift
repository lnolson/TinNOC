//
//  Vehicle.swift
// 
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
        r = 12.0
        maxspeed = ms
        maxforce = mf
        acceleration = TVector2()
        velocity = TVector2(x: maxspeed, y: 0.0)
    }
    
    
    func applyBehaviors(vehicles: [Vehicle], path: Path) {
        var f = follow(p: path)
        
        var s = separate(boids: vehicles)
        
        // Arbitrary weighting
        f = f * 3.0
        s = s * 1.0
        
        // Accumulate in acceleration
        apply(force: f)
        apply(force: s)
    }
    
    
    func run() {
        update()
        borders()
        display()
    }
    
    
    // This function implements Craig Reynolds' path following algorithm
    // http://www.red3d.com/cwr/steer/PathFollow.html
    func follow(p: Path) -> TVector2 {
        // Predict position 50 (arbitrary choice) frames ahead
        var predict = velocity
        predict.normalize()
        predict = predict * 25.0
        let predictpos = position + predict
        
        // Now we must find the normal to the path from the predicted position
        // We look at the normal for each line segment and pick out the closest one

        var normal: TVector2?
        var target: TVector2?
        var worldRecord = 1000000.0
        
        // Loop through all points of the path
        for i in 0 ..< p.points.count {
            // Look at a line segment
            var a = p.points[i]
            var b = p.points[(i+1)%p.points.count]
            
            // Get the normal point to that line
            var normalPoint = getNormalPoint(p: predictpos, a: a, b: b)
            
            // Check if normal is on line segment
            var dir = b - a
            
            // If it's not within the line segment, consider the normal to just be the end of the line segment (point b)
            //if (da + db > line.mag()+1) {
            if (normalPoint.x < min(a.x,b.x) || normalPoint.x > max(a.x,b.x) || normalPoint.y < min(a.y,b.y) || normalPoint.y > max(a.y,b.y)) {
                normalPoint = b
                // If we're at the end we really want the next line segment for looking ahead
                a = p.points[(i+1)%p.points.count]
                b = p.points[(i+2)%p.points.count]
                dir = b - a
            }
            
            // How far away are we from the path?
            let distance = predictpos.distance(v: normalPoint)
            // Did we beat the record and find the closest line segment?
            if distance < worldRecord {
                worldRecord = distance
                // If so the target we want to steer towards is the normal
                normal = normalPoint
                
                dir.normalize()
                // This is an oversimplification
                // Should be based on distance to path & velocity
                dir = dir * 25.0   // This could be based on velocity instead of just an arbitrary 10 pixels
                target = normalPoint + dir
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
        
        // Only if the distance is greater than the path's radius do we bother to steer
        if worldRecord > p.radius {
            if let target = target {
                return seek(target: target)
            }
        }
        return TVector2()
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
    
    
    // Separation
    // Method checks for nearby boids and steers away
    func separate(boids: [Vehicle]) -> TVector2 {
        let desiredseparation = r * 2.0
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
    
    
    // A method that calculates a steering force towards a target
    // STEER = DESIRED MINUS VELOCITY
    func seek(target: TVector2) -> TVector2 {
        var desired = target - position
        
        // If the magnitude of desired equals 0, skip out of here
        // (We could optimize this to check if x and y are 0 to avoid mag() square root
        if desired.magnitude == 0.0 {
            return TVector2()
        }
        
        desired.normalize()
        desired = desired * maxspeed
        
        var steer = desired - velocity
        steer.limit(mag: maxforce)
        
        return steer
    }
    
    
    // A method that calculates a steering force towards a target
    // STEER = DESIRED MINUS VELOCITY
    func arrive(target: TVector2) -> TVector2 {
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
        return steer
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
        fillColor(gray: 0.2941)
        strokeColor(gray: 0)
        pushState()
        translate(dx: position.x, dy: position.y)
        ellipse(centerX: 0, centerY: 0, width: r, height: r)
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
    
}

