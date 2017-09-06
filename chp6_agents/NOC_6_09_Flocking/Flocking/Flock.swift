//
//  Flock.swift
//  Flocking
//
//
//  Translation from The Nature of Code, Daniel Shiffman
//  Ch 6. Flocking

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
