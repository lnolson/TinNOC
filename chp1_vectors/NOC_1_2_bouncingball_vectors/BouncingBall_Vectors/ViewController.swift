//
//  ViewController.swift
//

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 1-2: Bouncing Ball, with PVector!

import Cocoa
import Tin


class ViewController: TController {

    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Bouncing Ball"
        
        makeView(width: 800.0, height: 200.0)
        
        let scene = Scene()
        
        present(scene: scene)
        
        tview.showStats = false
    }
    
    
}


class Scene: TScene {
    
    var position = TVector2(x: 100.0, y: 100.0)
    var velocity = TVector2(x: 2.5, y: 2.0)

    override func update() {
        
        background(gray: 1.0)
        
        // Add the current speed to the location.
        position = position + velocity
        
        if position.x > Double(tin.size.width) || position.x < 0.0 {
            velocity.x *= -1.0
        }
        if position.y > Double(tin.size.height) || position.y < 0.0 {
            velocity.y *= -1.0
        }
        
        // Display circle at x location
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.5)
        ellipse(centerX: position.x, centerY: position.y, width: 48.0, height: 48.0)
    }
}

