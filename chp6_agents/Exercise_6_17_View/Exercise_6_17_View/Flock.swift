//
//  Flock.swift
//  Exercise_6_17_View
//
//
// Flocking
// Daniel Shiffman <http://www.shiffman.net>
// The Nature of Code, Spring 2011

// Flock class
// Does very little, simply manages the ArrayList of all the boids

import Foundation
import Tin


class Flock {
    
    var boids: [Boid] = []
    
    
    func run() {
        for b in boids {
            b.col = TColor(red: 0.6862, green: 0.6862, blue: 0.6862, alpha: 1)
        }
        
        if let b1 = boids.first {
            b1.col = TColor(red: 0, green: 0, blue: 1, alpha: 1)
            b1.view(boids: boids)
        }
        
        for b in boids {
            b.flock(boids: boids)
        }
        
        for b in boids {
            b.run(boids: boids)
        }
    }
    
    
    func add(boid: Boid) {
        boids.append(boid)
    }
    
}

