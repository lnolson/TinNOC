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
        view.window?.title = "Particle System Forces Repeller"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var ps: ParticleSystem!
    var repeller: Repeller!
    
    override func setup() {
        ps = ParticleSystem(position: TVector2(x: tin.midX, y: tin.height - 50.0))
        repeller = Repeller(x: tin.midX - 20.0, y: tin.midY)
    }
    
    override func update() {
        background(gray: 1.0)
        ps.addParticle()
        
        let gravity = TVector2(x: 0.0, y: -0.1)
        ps.applyForce(force: gravity)
        
        ps.applyRepeller(r: repeller)
        
        repeller.display()
        ps.run()
    
    }
    
}

