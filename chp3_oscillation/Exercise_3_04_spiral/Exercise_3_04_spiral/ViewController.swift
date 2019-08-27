//
//  ViewController.swift
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


import Cocoa
import Tin


class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Spiral"
        makeView(width: 750.0, height: 200.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    override func viewDidAppear() {
        tin.enableRestoreFromPrevious()
    }

}


class Scene: TScene {
    
    // A Polar coordinate, radius now starts at 0 to spiral outwards
    var r = 0.0;
    var theta = 0.0;
    
    
    override func update() {
        if tin.frameCount == 1 {
            background(gray: 0.7)
        }
        
        // Polar to Cartesian conversion
        let x = r * cos(theta)
        let y = r * sin(theta)
        
        // Draw an ellipse at x,y
        strokeDisable()
        fillColor(gray: 0.0)
        // Adjust for center of window
        ellipse(centerX: x + tin.midX, centerY: y + tin.midY, width: 16.0, height: 16.0)
        
        // Increment the angle
        theta -= 0.01;
        
        // Increment the radius
        r += 0.05;
    }
}

