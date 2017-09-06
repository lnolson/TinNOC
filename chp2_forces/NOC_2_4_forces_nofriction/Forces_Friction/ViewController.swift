//
//  ViewController.swift
//

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 2-4: Forces No Friction


import Cocoa
import Tin


class ViewController: TController {

    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Forces No Friction"
        
        makeView(width: 383.0, height: 200.0)
        
        let scene = Scene()
        
        present(scene: scene)
        
        tview.showStats = false
    }
    
    
}


class Scene: TScene {
    

    var movers: [Mover] = []
    
    
    override func setup() {
        let y = Double(tin.size.height)
        for _ in 1...5 {
            let x = TRandom.next(max: Double(tin.size.width))
            movers.append( Mover(mass: TRandom.next(min: 1.0, max: 4.0), x: x, y: y) )
        }
    }
    
    
    override func update() {
        
        background(gray: 1.0)
        
        let wind = TVector2(x: 0.01, y: 0.0)
        let c = 0.05
        
        for mover in movers {
            let gravity = TVector2(x: 0.0, y: -0.1 * mover.mass)
            
            var friction = mover.velocity
            friction = friction * -1.0
            friction.normalize()
            friction = friction * c
            
            //mover.applyForce(force: friction)
            
            mover.applyForce(force: wind)
            mover.applyForce(force: gravity)
            
            mover.update()
            mover.checkEdges()
            mover.display()
        }
        
    }
}

