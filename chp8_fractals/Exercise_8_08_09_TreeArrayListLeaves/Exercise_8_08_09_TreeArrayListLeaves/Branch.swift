//
//  Branch.swift
//  Exercise_8_08_09_TreeArrayListLeaves
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Recursive Tree (w/ ArrayList)

// A class for one branch in the system
//

import Foundation
import Tin


class Branch {
    // Each has a position, velocity, and timer
    // We could implement this same idea with different data

    var start: TVector2
    var end: TVector2
    var vel: TVector2
    var timer: Double
    var timerstart: Double
    var growing: Bool
    
    
    init(l: TVector2, v: TVector2, n: Double) {
        start = l
        end = l
        vel = v
        timerstart = n
        timer = timerstart
        growing = true
    }
    
    
    // Move position
    func update() {
        if growing {
            end = end + vel
        }
    }
    
    
    // Draw a dot at position
    func render() {
        strokeColor(gray: 0)
        line(x1: start.x, y1: start.y, x2: end.x, y2: end.y)
    }
    
    
    // Did the timer run out?
    func timeToBranch() -> Bool {
        timer -= 1.0
        if timer < 0.0 && growing {
            growing = false
            return true
        }
        else {
            return false
        }
    }
    
    
    // Create a new branch at the current position, but change direction by a given angle
    func branch(angle: Double) -> Branch {
        // What is my current heading
        var theta = vel.heading()
        // What is my current speed
        let mag = vel.magnitude
        // Turn me
        theta += toRadians(degrees: angle)
        // Look, polar coordinates to cartesian!!
        let newvel = TVector2(x: mag * cos(theta), y: mag * sin(theta))
        // Return a new Branch
        return Branch(l: end, v: newvel, n: timerstart * 0.66)
    }
}
