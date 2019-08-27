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
    
    
    init() {
        let x = random(max: tin.width)
        let y = random(max: tin.height)
        position = TVector2(x: x, y: y)
        velocity = TVector2(x: random(min: -2.0, max: 2.0), y: random(min: -2.0, max: 2.0))
    }
    
    
    func update() {
        position = position + velocity
    }
    
    
    func display() {
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.5)
        ellipse(centerX: position.x, centerY: position.y, width: 48.0, height: 48.0)
    }
    
    
    func checkEdges() {
        if position.x > tin.width {
            position.x = 0.0
        }
        else if position.x < 0.0 {
            position.x = tin.width
        }
        
        if position.y > tin.height {
            position.y = 0.0
        }
        else if position.y < 0.0 {
            position.y = tin.height
        }
    }
    
}
