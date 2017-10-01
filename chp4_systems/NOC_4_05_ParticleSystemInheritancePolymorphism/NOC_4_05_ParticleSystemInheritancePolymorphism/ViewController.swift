//
//  ViewController.swift
//  NOC_8_05_ParticleSystemInheritancePolymorphism
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


import Cocoa
import Tin

class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        view.window?.title = "Inheritance Polymorphism"
        makeView(width: 640.0, height: 360.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    
    override func mouseUp(with event: NSEvent) {
    }

}


class Scene: TScene {
    
    var ps: ParticleSystem!
    
    override func setup() {
        ps = ParticleSystem(position: TVector2(x: tin.midX, y: tin.height - 50.0))
    }
    
    override func update() {
        background(gray: 1.0)
        
        ps.addParticle()
        ps.run()
        
        
    }
    
    

    
}

