//
//  Spring.swift
//  Exercise_3_16_springs
//
// Nature of Code 2011
// Daniel Shiffman
// Chapter 3: Oscillation

// Class to describe an anchor point that can connect to "Bob" objects via a spring
// Thank you: http://www.myphysicslab.com/spring2d.html


import Foundation
import Tin


class Spring {
    
    // Rest length and spring constant
    var len: Double
    var k: Double
    
    var a: Bob
    var b: Bob
    
    init(a: Bob, b: Bob, length: Double) {
        self.a = a
        self.b = b
        len = length
        k = 0.2
    }
    
    
    // Calculate spring force
    func update() {
        // Vector pointing from anchor to bob position
        var force = a.position - b.position
        // What is distance
        let d = force.magnitude
        // Stretch is difference between current distance and rest length
        let stretch = d - len;
        
        // Calculate force according to Hooke's Law
        // F = k * stretch
        force.normalize()
        force = force * (-1.0 * k * stretch)
        a.applyForce(force: force);
        force = force * -1.0
        b.applyForce(force: force)
    }
    
    
    func display() {
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        line(x1: a.position.x, y1: a.position.y, x2: b.position.x, y2: b.position.y)
    }
    
}
