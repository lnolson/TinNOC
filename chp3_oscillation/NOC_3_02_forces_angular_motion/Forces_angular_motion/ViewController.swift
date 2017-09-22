//
//  ViewController.swift
//  Angular_motion
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import Cocoa
import Tin


class ViewController: TController {

    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Forces Angular Motion"
        
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        tview.showStats = false
    }

}


class Scene: TScene {
    
    var movers: [Mover] = []
    var a = Attractor()
    
    
    override func setup() {
        for _ in 1...20 {
            let mass = TRandom.next(min: 0.1, max: 2.0)
            let x = TRandom.next(max: Double(tin.size.width))
            let y = TRandom.next(max: Double(tin.size.height))
            let m = Mover(mass: mass, x: x, y: y)
            movers.append(m)
        }
    }
    
    override func update() {
        background(gray: 1.0)
        
        a.display()
        
        for mover in movers {
            let force = a.attract(mover: mover)
            mover.applyForce(force: force)
            mover.update()
            mover.display()
        }
    }
    
}

