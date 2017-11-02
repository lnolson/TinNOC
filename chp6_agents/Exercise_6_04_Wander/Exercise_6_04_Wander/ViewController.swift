//
//  ViewController.swift
//  Exercise_6_04_Wander
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


// Implements Craig Reynold's autonomous steering behaviors
// See: http://www.red3d.com/cwr/

import Cocoa
import Tin



var debug = true



class ViewController: TController {

    override func viewWillAppear() {
        super.viewWillAppear()
        view.window?.title = "Wander"
        makeView(width: 1000.0, height: 800.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var v: Vehicle!
    
    override func setup() {
        v = Vehicle(x: tin.midX, y: tin.midY)
    }
    
    
    override func update() {
        background(gray: 1.0)
        
        v.wander()
        v.run()
        
    }
}

