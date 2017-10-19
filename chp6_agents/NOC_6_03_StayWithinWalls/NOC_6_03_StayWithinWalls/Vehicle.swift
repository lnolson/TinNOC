//
//  Vehicle.swift
//  NOC_6_02_Arrive
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
        velocity = TVector2(x: 15.0, y: 10.0)
        position = TVector2(x: x, y: y)
        r = 6.0
        maxspeed = 3.0
        maxforce = 0.15
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
    
    // A method that calculates a steering force towards a target
    // STEER = DESIRED MINUS VELOCITY
    func arrive(target: TVector2) {
        var desired = target - position
        let d = desired.magnitude
        if d < 100 {
            let m = remap(value: d, start1: 0, stop1: 100, start2: 0, stop2: maxspeed)
            desired.magnitude = m
        }
        else {
            desired.magnitude = maxspeed
        }
        
        var steer = desired - velocity
        steer.limit(mag: maxforce)
        apply(force: steer)
    }
    
    
    func boundaries(d: Double) {
        var v: TVector2? = nil
        
        if position.x < d {
            v = TVector2(x: maxspeed, y: velocity.y)
        }
        else if position.x > tin.width - d {
            v = TVector2(x: -maxspeed, y: velocity.y)
        }
        
        if position.y < d {
            v = TVector2(x: velocity.x, y: maxspeed)
        }
        else if position.y > tin.height - d {
            v = TVector2(x: velocity.x, y: -maxspeed)
        }
        
        if var desired = v {
            desired.normalize()
            desired = desired * maxspeed
            var steer = desired - velocity
            steer.limit(mag: maxforce)
            apply(force: steer)
        }
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

