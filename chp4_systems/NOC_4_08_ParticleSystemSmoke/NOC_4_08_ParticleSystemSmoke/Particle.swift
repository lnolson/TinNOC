//
//  Particle.swift
//  NOC_4_01_SingleParticle
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


import Foundation
import Tin
import GameplayKit


var gaussian = GKGaussianDistribution(lowestValue: 0, highestValue: 10000)

func randomGaussian() -> Double {
    return Double(gaussian.nextUniform() - 0.5)
}


class Particle: Equatable {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var lifespan: Double
    var mass: Double
    var img: TImage?
    
    
    init(location: TVector2, image: TImage) {
        position = location
        let vx = randomGaussian() * 4.0
        let vy = randomGaussian() * 1.0 + 1.0
        velocity = TVector2(x: vx, y: vy)
        acceleration = TVector2(x: 0.0, y: 0.0)
        lifespan = 100.0
        mass = 1.0
        img = image
    }
    
    
    func run() {
        update()
        render()
    }
    
    
    func update() {
        velocity = velocity + acceleration
        position = position + velocity
        acceleration = acceleration * 0.0
        lifespan -= 2.5
    }
    
    
    func applyForce(force: TVector2) {
        acceleration = acceleration + force / mass
    }
    
    
    func render() {
        if let img = img {
            let a = lifespan / 255.0
            //fillColor(gray: 1.0)
            setAlpha(a)
            image(image: img, x: position.x - 16.0, y: position.y - 16.0)
            //strokeColor(gray: 1.0)
            //fillDisable()
            //rect(x: position.x, y: position.y, width: 32.0, height: 32.0)
        }
    }
    
    
    func isDead() -> Bool {
        if lifespan < 0.0 {
            return true
        }
        else {
            return false
        }
    }
    
    
    // Equatable
    
    // So... Apple docs say equatable != identity
    // nevertheless, giving this a try.
    static func == (lhs: Particle, rhs: Particle) -> Bool {
        return lhs === rhs
    }
    
}
