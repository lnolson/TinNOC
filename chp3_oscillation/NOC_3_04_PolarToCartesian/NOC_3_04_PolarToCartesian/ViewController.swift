//
//  ViewController.swift
//  
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// PolarToCartesian
// Convert a polar coordinate (r,theta) to cartesian (x,y):
// x = r * cos(theta)
// y = r * sin(theta)

import Cocoa
import Tin


class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Polar to Cartesian"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var r = 0.0
    var theta = 0.0
    
    
    override func setup() {
        // Initialize all values
        r = tin.height * 0.45
        theta = 0.0
    }
    
    override func update() {
        background(gray: 1.0)
        
        // Translate the origin point to the center of the screen
        translate(dx: tin.midX, dy: tin.midY)
        
        // Convert polar to cartesian
        let x = r * cos(theta)
        let y = r * sin(theta)
        
        // Draw the ellipse at the cartesian coordinate
        fillColor(gray: 0.5)
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        line(x1: 0.0, y1: 0.0, x2: x, y2: y)
        ellipse(centerX: x, centerY: y, width: 48.0, height: 48.0)
        
        // Increase the angle over time
        theta += 0.02
    }
}

