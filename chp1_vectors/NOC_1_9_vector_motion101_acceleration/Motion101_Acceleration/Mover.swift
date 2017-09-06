//
//  Mover.swift
//  Motion101
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
//

import Foundation
import Tin


class Mover {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var topspeed: Double
    
    init() {
        let x = TRandom.next(max: Double(tin.size.width))
        let y = TRandom.next(max: Double(tin.size.height))
        position = TVector2(x: x, y: y)
        velocity = TVector2(x: 0.0, y: 0.0)
        acceleration = TVector2(x: 0.0, y: 0.0)
        topspeed = 6.0
    }
    
    
    func update() {
        acceleration = TVector2(x: TRandom.next(min: -1.0, max: 1.0), y: TRandom.next(min: -1.0, max: 1.0))
        acceleration = acceleration * TRandom.next(max: 2.0)
        
        velocity = velocity + acceleration
        velocity.limit(mag: topspeed)
        position = position + velocity
    }
    
    
    func display() {
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.5)
        ellipse(centerX: position.x, centerY: position.y, width: 48.0, height: 48.0)
    }
    
    
    func checkEdges() {
        if position.x > Double(tin.size.width) {
            position.x = 0.0
        }
        else if position.x < 0.0 {
            position.x = Double(tin.size.width)
        }
        
        if position.y > Double(tin.size.height) {
            position.y = 0.0
        }
        else if position.y < 0.0 {
            position.y = Double(tin.size.height)
        }
    }
    
}
