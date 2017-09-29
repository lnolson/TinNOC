//
//  ViewController.swift
//  NOC_8_01_Recursion
//
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

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
        
        drawCircle(x: tin.midX, y: tin.midY, r: tin.width)
        view?.stopUpdates()
    }
    
    
    func drawCircle(x: Double, y: Double, r: Double) {
        ellipse(centerX: x, centerY: y, width: r, height: r)
        if r > 2.0 {
            let smaller = r * 0.75
            drawCircle(x: x, y: y, r: smaller)
        }
    }
    
}

