//
//  ViewController.swift
//

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 2-2: Forces Many


import Cocoa
import Tin


class ViewController: TController {

    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Forces Many"
        
        makeView(width: 640.0, height: 360.0)
        
        let scene = Scene()
        
        present(scene: scene)
        
        tview.showStats = false
    }
    
    
}


class Scene: TScene {
    

    var movers: [Mover] = []
    
    
    override func setup() {
        let x = 0.0
        let y = tin.height
        for _ in 1...20 {
            let m = Mover(mass: random(min: 0.1, max: 4.0), x: x, y: y)
            movers.append( m )
        }
    }
    
    
    override func update() {
        
        background(gray: 1.0)
        
        let wind = TVector2(x: 0.01, y: 0.0)
        let gravity = TVector2(x: 0.0, y: -0.1)
        
        for mover in movers {
            mover.applyForce(force: wind)
            mover.applyForce(force: gravity)
            
            mover.update()
            mover.checkEdges()
            mover.display()
        }
        
    }
}

