//
//  Vehicle.swift
//  NOC_6_01_Seek
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Seek_Arrive

// The "Vehicle" class

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
        velocity = TVector2(x: 0.0, y: 0.0)
        position = TVector2(x: x, y: y)
        r = 6.0
        maxspeed = 4.0
        maxforce = 0.1
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
        Tin.rotate(by: theta)
        pathBegin()
        pathVertex(x: 0.0, y: -r * 2.0)
        pathVertex(x: -r, y: r * 2.0)
        pathVertex(x:  r, y: r * 2.0)
        pathClose()
        pathEnd()
        popState()
    }
}

