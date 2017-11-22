//
//  ViewController.swift
//  NOC_8_02_Recursion
//
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Cantor Set
// Renders a simple fractal, the Cantor Set

import Cocoa
import Tin

class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Cantor Set"
        makeView(width: 800.0, height: 200.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    override func update() {
        background(gray: 1.0)
        
        cantor(x: 35, y: tin.height - 10.0, len: 730)
        view?.stopUpdates()
    }
    
    
    func cantor(x: Double, y: Double, len: Double) {
        let h = 30.0
        
        // recursive exit condition
        if len >= 1.0 {
            // Draw line (as rectangle to make it easier to see
            strokeDisable()
            fillColor(gray: 0)
            rect(x: x, y: y, width: len, height: h/3)
            
            // Go down to next y position
            let nexty = y - h
            
            // Draw 2 more lines 1/3rd the length (without the middle section)
            cantor(x: x, y: nexty, len: len/3)
            cantor(x: x+len*2/3, y: nexty, len: len/3)
        }
    }
    
}

