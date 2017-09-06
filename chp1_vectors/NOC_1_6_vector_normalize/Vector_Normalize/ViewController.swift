//
//  ViewController.swift
//

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 1-6: Vector normalize
// Demonstration of normalizing a vector.
// Normalizing a vector sets its length to 1.

import Cocoa
import Tin


class ViewController: TController {

    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Vector Normalize"
        
        makeView(width: 640.0, height: 360.0)
        
        let scene = Scene()
        
        present(scene: scene)
        
        tview.showStats = false
    }
    
    
}


class Scene: TScene {
    

    override func update() {
        
        background(gray: 1.0)
        
        var mouse = TVector2(x: tin.mouseX, y: tin.mouseY)
        let center = TVector2(x: tin.midX, y: tin.midY)
        
        // Subtract center from mouse which results in a vector that points from center to mouse
        mouse = mouse - center
        
        // Normalize the vector
        mouse.normalize()
        
        // Multiply its length by 150
        // We do this because with a length of 1, the vector is too small to really see.
        mouse = mouse * 150.0
        
        // Draw the resulting vector at the center of the view.
        translate(dx: tin.midX, dy: tin.midY)
        lineWidth(2.0)
        strokeColor(gray: 0.0)
        line(x1: 0.0, y1: 0.0, x2: mouse.x, y2: mouse.y)
        
    }
}

