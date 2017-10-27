//
//  Flock.swift
//  Flocking
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Flock class
// Does very little, simply manages the Array of all the boids

import Cocoa
import Tin



class Flock {
    
    var boids: [Boid] = []
    
    
    func run() {
        for b in boids {
            b.run(boids: boids)
        }
    }
    
    
    func add(boid: Boid) {
        boids.append(boid)
    }
    
}
