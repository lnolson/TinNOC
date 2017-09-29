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
        view.window?.title = "Single Particle"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var p: Particle!
    
    
    override func setup() {
        let point = TVector2(x: tin.midX, y: tin.height - 20.0)
        p = Particle(location: point)
    }
    
    override func update() {
        background(gray: 1.0)
        
        p.run()
        if p.isDead() {
            let point = TVector2(x: tin.midX, y: tin.height - 20.0)
            p = Particle(location: point)
        }
    }
    
}

