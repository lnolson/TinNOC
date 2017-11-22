//
//  ViewController.swift
//  NOC_8_02_Recursion
//
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Simple Recursion

import Cocoa
import Tin

class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Recursion"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    override func update() {
        background(gray: 1.0)
        
        drawCircle(x: tin.midX, y: tin.midY, r: 400)
        view?.stopUpdates()
    }
    
    
    func drawCircle(x: Double, y: Double, r: Double) {
        strokeColor(gray: 0)
        fillDisable()
        lineWidth(1)
        ellipse(centerX: x, centerY: y, width: r, height: r)
        if r > 8.0 {
            // Four circles! left right, up and down
            drawCircle(x: x + r/2.0, y: y, r: r/2)
            drawCircle(x: x - r/2.0, y: y, r: r/2)
            drawCircle(x: x, y: y + r/2.0, r: r/2)
            drawCircle(x: x, y: y - r/2.0, r: r/2)
        }
    }
    
}

