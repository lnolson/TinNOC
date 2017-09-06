//
//  ViewController.swift
//

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 2-1: Forces


import Cocoa
import Tin


class ViewController: TController {

    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Forces"
        
        makeView(width: 640.0, height: 360.0)
        
        let scene = Scene()
        
        present(scene: scene)
        
        tview.showStats = false
    }
    
    
}


class Scene: TScene {
    

    var mover = Mover()
    
    
    override func update() {
        
        background(gray: 1.0)
        
        let wind = TVector2(x: 0.01, y: 0.0)
        let gravity = TVector2(x: 0.0, y: -0.1)
        mover.applyForce(force: wind)
        mover.applyForce(force: gravity)
        
        mover.update()
        mover.checkEdges()
        mover.display()
        
    }
}

