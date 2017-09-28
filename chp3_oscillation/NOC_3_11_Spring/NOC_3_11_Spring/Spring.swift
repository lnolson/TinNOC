//
//  Spring.swift
//  NOC_3_11_Spring
//
// Nature of Code 2011
// Daniel Shiffman
// Chapter 3: Oscillation

// Class to describe an anchor point that can connect to "Bob" objects via a spring
// Thank you: http://www.myphysicslab.com/spring2d.html


import Foundation
import Tin


class Spring {
    var anchor: TVector2
    
    // Rest length and spring constant
    var len: Double
    var k: Double
    
    
    init(x: Double, y: Double, length: Double) {
        anchor = TVector2(x: x, y: y)
        len = length
        k = 0.4
    }
    
    
    func connect(b: Bob) {
        // Vector pointing from anchor to bob position
        var force = b.position - anchor
        // What is distance
        let d = force.magnitude
        // Stretch is difference between current distance and rest length
        let stretch = d - len;
        
        // Calculate force according to Hooke's Law
        // F = k * stretch
        force.normalize()
        force = force * (-1.0 * k * stretch)
        b.applyForce(force: force)
    }
    
    
    // Constrain the distance between bob and anchor between min and max
    func constrainLength(b: Bob, minlen: Double, maxlen: Double) {
        var dir = b.position - anchor
        let d = dir.magnitude
        // Is it too short?
        if (d < minlen) {
            dir.normalize()
            dir = dir * minlen
            // Reset position and stop from moving (not realistic physics)
            b.position = anchor + dir
            b.velocity = b.velocity * 0.0
        }
        else if (d > maxlen) {   // Is it too long?
            dir.normalize()
            dir = dir * maxlen
            // Reset position and stop from moving (not realistic physics)
            b.position = anchor + dir
            b.velocity = b.velocity * 0.0
        }
    }
    
    
    func display() {
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.6268)
        rect(x: anchor.x - 5.0, y: anchor.y - 5.0, width: 10.0, height: 10.0)
    }
    
    
    func displayLine(b: Bob) {
        lineWidth(2.0)
        strokeColor(gray: 0.0)
        line(x1: b.position.x, y1: b.position.y, x2: anchor.x, y2: anchor.y)
    }
}
