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
    var img: TImage
    
    init(num: Int, position: TVector2, img: TImage) {
        origin = position
        particles = []
        self.img = img
        var i = 0
        while i < num {
            let p = Particle(location: origin, image: img)
            particles.append(p)
            i += 1
        }
    }
    
    
    func addParticle() {
        let p = Particle(location: origin, image: img)
        particles.insert(p, at: 0)
    }
    
    
    func applyForce(force: TVector2) {
        for p in particles {
            p.applyForce(force: force)
        }
    }
    
    
    func applyRepeller(r: Repeller) {
        for p in particles {
            let force = r.repel(p: p)
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
