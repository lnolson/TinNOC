//
//  Walker.swift
//  RandomWalkTraditional
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
//

import Foundation
import Tin


class Walker {
    var x: Double
    var y: Double
    
    init() {
        x = tin.midX
        y = tin.midY
    }
    
    
    func step() {
        let choice = Int(TRandom.next(max: 4.0))
        
        if choice == 0 {
            x += 1.0
        }
        else if choice == 1 {
            x -= 1.0
        }
        else if choice == 2 {
            y += 1.0
        }
        else if choice == 3 {
            y -= 1.0
        }
        
        x = constrain(value: x, min: 0.0, max: Double(tin.size.width))
        y = constrain(value: y, min: 0.0, max: Double(tin.size.height))
    }
    
    func render() {
        strokeColor(gray: 0.0)
        lineWidth(1.0)
        fillDisable()
        ellipse(centerX: x, centerY: y, width: 5.0, height: 5.0)
    }
}
