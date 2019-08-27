//
//  Ball.swift
//  BouncingBall_Vectors_Object
//

import Foundation
import Tin


class Ball {
    
    var position = TVector2(x: 100.0, y: 100.0)
    var velocity = TVector2(x: 2.5, y: 2.0)
    
    func update() {
        
        // Add the current speed to the location.
        position = position + velocity
        
        if position.x > tin.width || position.x < 0.0 {
            velocity.x *= -1.0
        }
        if position.y > tin.height || position.y < 0.0 {
            velocity.y *= -1.0
        }
        
    }
    
    
    func display() {
        // Display circle at x location
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.5)
        ellipse(centerX: position.x, centerY: position.y, width: 48.0, height: 48.0)
    }
    
}
