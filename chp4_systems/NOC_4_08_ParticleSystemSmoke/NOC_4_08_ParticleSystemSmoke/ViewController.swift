//
//  ViewController.swift
//  NOC_8_07_Recursion
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
        view.window?.title = "Particle System Smoke"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var ps: ParticleSystem!
    
    override func setup() {
        if let image = TImage(contentsOfFileInBundle: "texture.png") {
            ps = ParticleSystem(num: 0, position: TVector2(x: tin.midX, y: 75.0), img: image)
        }
    }
    
    override func update() {
        background(gray: 0.0)
        ps.addParticle()
        
        //let gravity = TVector2(x: 0.0, y: -0.1)
        //ps.applyForce(force: gravity)
        
        let dx = remap(value: tin.mouseX, start1: 0.0, stop1: tin.width, start2: -0.2, stop2: 0.2)
        let wind = TVector2(x: dx, y: 0.0)
        ps.applyForce(force: wind)
        
        
        ps.run()
        for _ in 0 ... 1 {
            ps.addParticle()
        }
    
    }
    
}

