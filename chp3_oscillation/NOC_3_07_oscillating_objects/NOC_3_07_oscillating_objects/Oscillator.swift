//
//  Oscillator.swift
//  NOC_3_07_oscillating_objects
//
//

import Foundation
import Tin

class Oscillator {
    var angle: TVector2
    var velocity: TVector2
    var amplitude: TVector2
    
    
    init() {
        angle = TVector2()
        velocity = TVector2(x: TRandom.next(min: -0.05, max: 0.05), y: TRandom.next(min: -0.05, max: 0.05))
        amplitude = TVector2(x: TRandom.next(min: 20.0, max: tin.width/2.0), y: TRandom.next(min: 20.0, max: tin.height/2.0))
    }
    
    
    func oscillate() {
        angle = angle + velocity
    }
    
    
    func display() {
        let x = sin(angle.x) * amplitude.x
        let y = sin(angle.y) * amplitude.y
        
        pushState()
        translate(dx: tin.midX, dy: tin.midY)
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.5, alpha: 0.5)
        line(x1: 0.0, y1: 0.0, x2: x, y2: y)
        ellipse(centerX: x, centerY: y, width: 32.0, height: 32.0)
        popState()
    }
}
