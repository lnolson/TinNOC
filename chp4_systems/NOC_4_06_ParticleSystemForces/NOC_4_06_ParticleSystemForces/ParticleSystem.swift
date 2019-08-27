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
    
    init(position: TVector2) {
        origin = position
        particles = []
    }
    
    
    func addParticle() {
        let p = Particle(location: origin)
        particles.insert(p, at: 0)
    }
    
    
    func applyForce(force: TVector2) {
        for p in particles {
            p.applyForce(force: force)
        }
    }
    
    
    func run() {
        for p in particles {
            p.run()
            if p.isDead() {
                if let i = particles.firstIndex(of: p) {
                    particles.remove(at: i)
                }
            }
        }
    }
}
