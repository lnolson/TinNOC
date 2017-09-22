//
//  ViewController.swift
//  Blank
//
//

import Cocoa
import Tin


class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Polar to Cartesian trail"
        makeView(width: 800.0, height: 200.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    override func viewDidAppear() {
        tin.enableRestoreFromPrevious()
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
        if tin.frameCount <= 2 {
            background(gray: 1.0)
        }
        
        strokeDisable()
        fillColor(gray: 1.0, alpha: 0.0196)
        rect(x: 0.0, y: 0.0, width: tin.width, height: tin.height)
        
        pushState()
        
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
        
        popState()
    }
}


