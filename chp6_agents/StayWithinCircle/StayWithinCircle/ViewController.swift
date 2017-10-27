//
//  ViewController.swift
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Stay Within Circle
// "Made-up" Steering behavior to stay within walls

import Cocoa
import Tin

class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        view.window?.title = "Stay Within Circle"
        makeView(width: 640.0, height: 360.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    
    override func keyUp(with event: NSEvent) {
        scene.view?.stopUpdates()
    }

}


class Scene: TScene {
    
    var v: Vehicle!
    var debug = true
    
    var circlePosition: TVector2!
    var circleRadius = 0.0
    
    override func setup() {
        v = Vehicle(x: tin.midX, y: tin.midY + tin.midY/2.0)
        
        circlePosition = TVector2(x: tin.midX, y: tin.midY)
        circleRadius = tin.midY - 25.0
    }
    
    
    override func update() {
        background(gray: 1.0)
        
        if debug {
            strokeColor(gray: 0.6862)
            fillDisable()
            ellipse(centerX: circlePosition.x, centerY: circlePosition.y, width: circleRadius*2.0, height: circleRadius*2.0)
        }
        v.boundaries(circlePosition: circlePosition, circleRadius: circleRadius)
        v.run()
    }
    
    
    func mousePressed() {
        debug = !debug
    }
}

