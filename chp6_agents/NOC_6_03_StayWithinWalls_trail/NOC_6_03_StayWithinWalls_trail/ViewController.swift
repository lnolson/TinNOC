//
//  ViewController.swift
//  NOC_6_03
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Stay Within Walls
// "Made-up" Steering behavior to stay within walls


import Cocoa
import Tin

class ViewController: TController {

    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Stay Within Walls"
        
        makeView(width: 800.0, height: 400.0)
        let scene = Scene()
        present(scene: scene)
        
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var v: Vehicle!
    var debug = true
    var d = 25.0
    
    override func setup() {
        v = Vehicle(x: tin.midX, y: tin.midY)
    }
    
    
    override func update() {
        background(gray: 1.0)
        
        if debug {
            strokeColor(gray: 0.7)
            fillDisable()
            rect(x: d, y: d, width: tin.width - 2 * d, height: tin.height - 2 * d)
        }
        
        
        v.boundaries(d: d)
        v.update()
        v.display()
        
    }
}

