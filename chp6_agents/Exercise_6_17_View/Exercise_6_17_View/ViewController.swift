//
//  ViewController.swift
//  Exercise_6_17_View
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

    var scene: Scene!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        view.window?.title = "View"
        makeView(width: 1000.0, height: 800.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        scene.addBoid(x: tin.mouseX, y: tin.mouseY)
    }

}


class Scene: TScene {
    
    var flock = Flock()
    
    override func setup() {
        for _ in 1...25 {
            let x = tin.midX + random(min: 0, max: 75)
            let y = tin.midY + random(min: 0, max: 75)
            let b = Boid(x: x, y: y)
            flock.add(boid: b)
        }
    }
    
    
    override func update() {
        background(gray: 1.0)
        
        flock.run()
        
    }
    
    
    func addBoid(x: Double, y: Double) {
        let b = Boid(x: x, y: y)
        flock.add(boid: b)
    }
}

