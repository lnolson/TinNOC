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
// Angular Acceleration = Pendulum Force / Mass = gravitational acceleration * sine(theta);

// Note this is an ideal world scenario with no tension in the
// pendulum arm, a more realistic formula might be:
// Angular Acceleration = (g / R) * sine(theta)

// For a more substantial explanation, visit:
// http://www.myphysicslab.com/pendulum1.html 

import Cocoa
import Tin


class ViewController: TController {
    var scene: Scene!
    
    override func viewWillAppear() {
        view.window?.title = "Pendulum"
        makeView(width: 640.0, height: 360.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    
    override func mouseDown(with event: NSEvent) {
        scene.mousePressed()
    }
    
    
    override func mouseUp(with event: NSEvent) {
        scene.mouseReleased()
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
    
    
    func mousePressed() {
        p.clicked(mx: tin.mouseX, my: tin.mouseY)
    }
    
    
    func mouseReleased() {
        p.stopDragging()
    }
}

