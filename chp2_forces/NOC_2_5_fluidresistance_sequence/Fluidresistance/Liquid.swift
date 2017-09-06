//
//  Liquid.swift
//  forces
//
//  Created by Loren Olson on 7/21/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import Tin


class Liquid {
    // Rectangle that defines the area of Liquid
    var x: Double
    var y: Double
    var w: Double
    var h: Double
    
    // Coefficient of drag
    var c: Double
    
    
    init(x: Double, y: Double, w: Double, h: Double, c: Double) {
        self.x = x
        self.y = y
        self.w = w
        self.h = h
        self.c = c
    }
    
    
    convenience init() {
        self.init(x: 0.0, y: 0.0, w: 100.0, h: 100.0, c: 0.0)
    }
    
    
    // Is the Mover in the Liquid?
    func contains(m: Mover) -> Bool {
        let l = m.position
        return l.x > x && l.x < x + w && l.y > y && l.y < y + h
    }
    
    
    // Calculate drag force
    func drag(m: Mover) -> TVector2 {
        // Magnitude is cofficent * speed squared
        let speed = m.velocity.magnitude
        let dragMagnitude = c * speed * speed
        
        // Direction is inverse of velocity
        var dragForce = m.velocity
        dragForce = dragForce * -1.0
        
        // Scale according to magnitude
        dragForce.normalize()
        dragForce = dragForce * dragMagnitude
        return dragForce
    }
    
    
    func display() {
        strokeDisable()
        fillColor(gray: 0.1960)
        rect(x: x, y: y, width: w, height: h)
    }
    
    
}
