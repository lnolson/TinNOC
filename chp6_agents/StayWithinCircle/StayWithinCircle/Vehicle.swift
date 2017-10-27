//
//  Vehicle.swift
//
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com



import Foundation
import Tin

class Vehicle {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var r: Double
    var maxforce: Double
    var maxspeed: Double
    
    
    init(x: Double, y: Double) {
        acceleration = TVector2()
        velocity = TVector2(x: 5.0, y: 0.0)
        position = TVector2(x: x, y: y)
        r = 3.0
        maxspeed = 3.0
        maxforce = 0.15
    }
    
    
    func run() {
        update()
        display()
    }
    
    
    func update() {
        velocity = velocity + acceleration
        velocity.limit(mag: maxspeed)
        position = position + velocity
        acceleration = acceleration * 0.0
    }
    
    
    func apply(force: TVector2) {
        acceleration = acceleration + force
    }
    
    
    func boundaries(circlePosition: TVector2, circleRadius: Double) {
        
        // Predict position 25 (arbitrary choice) frames ahead
        var predict = TVector2(x: velocity.x, y: velocity.y)
        predict = predict * 25.0
        let futurePosition = position + predict
        let distance = futurePosition.distance(v: circlePosition)
        
        if distance > circleRadius {

            var toCenter = circlePosition - position
            toCenter.normalize()
            toCenter = toCenter * velocity.magnitude
            var desired = velocity - toCenter
            desired.normalize()
            desired = desired * maxspeed
            
            var steer = desired - velocity
            steer.limit(mag: maxforce)
            
            // ? wha?
            steer = steer * -1.0
            apply(force: steer)
            
        }
        
        fillColor(red: 1, green: 0, blue: 0, alpha: 1)
        ellipse(centerX: futurePosition.x, centerY: futurePosition.y, width: 4, height: 4)
    }
    
    
    func seek(target: TVector2) {
        var desired = target - position
        desired.normalize()
        desired = desired * maxspeed
        
        var steer = desired - velocity
        steer.limit(mag: maxforce)
        
        apply(force: steer)
    }
    
    
    func display() {
        let theta = velocity.heading() + .pi / 2.0
        fillColor(gray: 0.5)
        strokeColor(gray: 0.0)
        lineWidth(1.0)
        pushState()
        translate(dx: position.x, dy: position.y)
        rotate(by: theta)
        pathBegin()
        pathVertex(x: 0.0, y: -r * 2.0)
        pathVertex(x: -r, y: r * 2.0)
        pathVertex(x:  r, y: r * 2.0)
        pathClose()
        pathEnd()
        popState()
    }
}

