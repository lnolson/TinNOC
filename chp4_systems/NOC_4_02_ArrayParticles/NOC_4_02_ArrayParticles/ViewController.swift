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
        view.window?.title = "Array of Particles"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var particles: [Particle] = [Particle]()
    
    
    override func setup() {
    }
    
    override func update() {
        background(gray: 1.0)
        
        let p = Particle(location: TVector2(x: tin.midX, y: tin.height - 50.0))
        particles.insert(p, at: 0)
        
        for p in particles {
            p.run()
            if p.isDead() {
                if let i = particles.firstIndex(of: p) {
                    particles.remove(at: i)
                }
            }
        }
    
    }
    
}

