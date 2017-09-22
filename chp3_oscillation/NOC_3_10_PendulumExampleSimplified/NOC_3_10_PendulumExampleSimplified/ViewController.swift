//
//  ViewController.swift
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Pendulum

// A simple pendulum simulation
// Given a pendulum with an angle theta (0 being the pendulum at rest) and a radius r
// we can use sine to calculate the angular component of the gravitational force.

// Gravity Force = Mass * Gravitational Constant;
// Pendulum Force = Gravity Force * sine(theta)
// Angular Acceleration = Pendulum Force / Mass = Gravitational Constant * sine(theta);

// Note this is an ideal world scenario with no tension in the
// pendulum arm, a more realistic formula might be:
// Angular Acceleration = (G / R) * sine(theta)

// For a more substantial explanation, visit:
// http://www.myphysicslab.com/pendulum1.html

import Cocoa
import Tin


class ViewController: TController {
    var scene: Scene!
    
    override func viewWillAppear() {
        view.window?.title = "Pendulum Simplified"
        makeView(width: 640.0, height: 360.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var p: Pendulum!
    
    override func setup() {
        let point = TVector2(x: tin.midX, y: tin.height)
        p = Pendulum(origin: point, r: 175.0)
    }
    
    override func update() {
        background(gray: 1.0)
        
        p.go()
    }
    
}

