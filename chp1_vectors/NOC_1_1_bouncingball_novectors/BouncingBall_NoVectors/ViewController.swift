//
//  ViewController.swift
//

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 1-1: Bouncing Ball, no vectors

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
    
    var x = 100.0
    var y = 100.0
    var xspeed = 2.5
    var yspeed = 2.0

    override func update() {
        
        background(gray: 1.0)
        
        // Add the current speed to the location.
        x = x + xspeed
        y = y + yspeed
        
        if x > Double(tin.size.width) || x < 0.0 {
            xspeed = xspeed * -1.0
        }
        if y > Double(tin.size.height) || y < 0.0 {
            yspeed = yspeed * -1.0
        }
        
        // Display circle at x location
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.5)
        ellipse(centerX: x, centerY: y, width: 48.0, height: 48.0)
    }
}

