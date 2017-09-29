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
        tin.enableRestoreFromPrevious()
    }
    
    override func update() {
        if tin.frameCount < 2 {
            background(gray: 1.0)
        }
        
        if tin.mousePressed {
            strokeDisable()
            fillColor(gray: 1.0, alpha: 0.0196)
            rect(x: 0.0, y: 0.0, width: tin.width, height: tin.height)
            
            p.run()
            if p.isDead() {
                print("Particle dead!")
            }
        }
    }
    
}

