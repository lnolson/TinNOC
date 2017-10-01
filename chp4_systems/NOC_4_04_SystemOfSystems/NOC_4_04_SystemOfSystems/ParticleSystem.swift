//
//  ParticleSystem.swift
//  NOC_4_03_ParticleSystemClass
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import Foundation
import Tin


class ParticleSystem {
    var particles: [Particle]
    var origin: TVector2
    
    init(number: Int, position: TVector2) {
        origin = position
        particles = []
        
        for _ in 1...number {
            addParticle()
        }
    }
    
    
    func addParticle() {
        let p = Particle(location: origin)
        particles.insert(p, at: 0)
    }
    
    
    func run() {
        for p in particles {
            p.run()
            if p.isDead() {
                if let i = particles.index(of: p) {
                    particles.remove(at: i)
                }
            }
        }
    }
    
    func dead() -> Bool {
        if particles.isEmpty {
            return true
        }
        else {
            return false
        }
    }
}
