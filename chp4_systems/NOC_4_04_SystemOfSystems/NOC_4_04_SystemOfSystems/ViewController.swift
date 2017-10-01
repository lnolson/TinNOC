//
//  ViewController.swift
//  NOC_8_01_Recursion
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
// Simple Particle System

// Particles are generated each cycle through draw(),
// fall with gravity and fade out over time
// A ParticleSystem object manages a variable size (ArrayList)
// list of particles.

import Cocoa
import Tin

class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        view.window?.title = "System of Systems"
        makeView(width: 640.0, height: 360.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    
    override func mouseUp(with event: NSEvent) {
        scene.mousePressed()
    }

}


class Scene: TScene {
    
    var systems: [ParticleSystem] = []
    var font = TFont(fontName: "Helvetica", ofSize: 16.0)
    
    override func setup() {
        font.horizontalAlignment = .left
    }
    
    override func update() {
        background(gray: 1.0)
        
        for ps in systems {
            ps.addParticle()
            ps.run()
        }
        
        fillColor(gray: 0.0)
        text(message: "click mouse to add particle systems", font: font, x: 10.0, y: 10.0)
    }
    
    
    func mousePressed() {
        let point = TVector2(x: tin.mouseX, y: tin.mouseY)
        let ps = ParticleSystem(number: 1, position: point)
        systems.append(ps)
    }
    
}

