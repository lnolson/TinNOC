//
//  Attractor.swift
//  forces
//
//  Created by Loren Olson on 8/17/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import Tin


class Attractor {
    var mass: Double
    var G: Double
    var position: TVector2
    var dragging = false
    var rollover = false
    var dragOffset: TVector2
    
    init() {
        position = TVector2(x: tin.midX, y: tin.midY)
        mass = 20.0
        G = 1.0
        dragOffset = TVector2(x: 0.0, y: 0.0)
    }
    
    
    func attract(mover: Mover) -> TVector2 {
        var force = position - mover.position
        var d = force.magnitude
        d = constrain(value: d, min: 5.0, max: 25.0)
        force.normalize()
        let strength = (G * mass * mover.mass) / (d * d)
        force = force * strength
        return force
    }
    
    
    func display() {
        lineWidth(4.0)
        strokeColor(gray: 0.0)
        if dragging {
            fillColor(gray: 0.19)
        }
        else if rollover {
            fillColor(gray: 0.38)
        }
        else {
            fillColor(gray: 0.6, alpha: 0.75)
        }
        ellipse(centerX: position.x, centerY: position.y, width: mass * 2.0, height: mass * 2.0)
    }
    
    
    func clicked(mx: Double, my: Double) {
        let d = dist(x1: mx, y1: my, x2: position.x, y2: position.y)
        if d < mass {
            dragging = true
            dragOffset.x = position.x - mx
            dragOffset.y = position.y - my
        }
    }
    
    
    func hover(mx: Double, my: Double) {
        let d = dist(x1: mx, y1: my, x2: position.x, y2: position.y)
        if d < mass {
            rollover = true
        }
        else {
            rollover = false
        }
    }
    
    
    func stopDragging() {
        dragging = false
    }
    
    
    func drag() {
        if dragging {
            position.x = tin.mouseX + dragOffset.x
            position.y = tin.mouseY + dragOffset.y
        }
    }
    
}
