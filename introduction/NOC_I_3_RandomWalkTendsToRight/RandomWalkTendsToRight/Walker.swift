//
//  Walker.swift
//  RandomWalkTendsToRight
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
        let r = TRandom.next(max: 1.0)
        // A 40% of moving to the right!
        if r < 0.4 {
            x += 1.0
        }
        else if r < 0.6 {
            x -= 1.0
        }
        else if r < 0.8 {
            y += 1.0
        }
        else {
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
