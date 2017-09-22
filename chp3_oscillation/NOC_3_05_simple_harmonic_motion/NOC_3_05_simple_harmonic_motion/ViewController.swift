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
        view.window?.title = "Simple Harmonic Motion"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    
    
    override func setup() {

    }
    
    override func update() {
        background(gray: 1.0)
        
        let period = 120.0
        let amplitude = 300.0
        
        // Calculating horizontal position according to formula for simple harmonic motion
        let x = amplitude * sin(Double.pi * 2.0 * Double(tin.frameCount) / period)
        
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.5)
        translate(dx: tin.midX, dy: tin.midY)
        line(x1: 0.0, y1: 0.0, x2: x, y2: 0.0)
        ellipse(centerX: x, centerY: 0.0, width: 48.0, height: 48.0)
    }
}

