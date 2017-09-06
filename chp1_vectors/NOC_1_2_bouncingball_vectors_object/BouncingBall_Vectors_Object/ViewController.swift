//
//  ViewController.swift
//

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 1-2: Bouncing Ball, with PVector!

import Cocoa
import Tin


class ViewController: TController {

    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Bouncing Ball"
        
        makeView(width: 800.0, height: 200.0)
        
        let scene = Scene()
        
        present(scene: scene)
        
        tview.showStats = false
    }
    
    
}


class Scene: TScene {
    
    var b = Ball()
    

    override func update() {
        
        background(gray: 1.0)
        
        b.update()
        b.display()
        
    }
}

