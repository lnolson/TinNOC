//
//  ViewController.swift
//

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 1-7: Motion 101


import Cocoa
import Tin


class ViewController: TController {

    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Motion 101 Acceleration Array"
        
        makeView(width: 640.0, height: 360.0)
        
        let scene = Scene()
        
        present(scene: scene)
        
        tview.showStats = false
    }
    
    
}


class Scene: TScene {
    

    var movers: [Mover] = []
    
    
    override func setup() {
        for _ in 1...20 {
            movers.append( Mover() )
        }
    }
    
    override func update() {
        
        background(gray: 1.0)
        
        for mover in movers {
            mover.update()
            mover.display()
        }
        
    }
}

