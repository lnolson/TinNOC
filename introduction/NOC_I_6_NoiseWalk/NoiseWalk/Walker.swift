//
//  Walker.swift
//  NoiseWalk
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
//

import Foundation
import Tin


class Walker {
    var position: TVector2!
    var noff: TVector2!
    
    
    init() {
        position = TVector2(x: tin.midX, y: tin.midY)
        noff = TVector2(x: TRandom.next(max: 1000.0), y: TRandom.next(max: 1000.0))
    }
    
    
    func walk() {
        position.x = remap(value: noise(x: noff.x, y: 0.0), start1: -1.0, stop1: 1.0, start2: 0.0, stop2: Double(tin.size.width))
        position.y = remap(value: noise(x: noff.y, y: 0.0), start1: -1.0, stop1: 1.0, start2: 0.0, stop2: Double(tin.size.height))
        
        noff = noff + TVector2(x: 0.01, y: 0.01)
    }
    
    func display() {
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.5)
        ellipse(centerX: position.x, centerY: position.y, width: 48.0, height: 48.0)
    }
}
