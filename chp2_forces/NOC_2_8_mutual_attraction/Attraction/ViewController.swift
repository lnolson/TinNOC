//
//  ViewController.swift
//

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 2-6: Attraction


import Cocoa
import Tin


class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Attraction"
        
        makeView(width: 640.0, height: 360.0)
        
        scene = Scene()
        present(scene: scene)
        
        tview.showStats = false
    }
    
    
    override func mouseUp(with event: NSEvent) {
    }
    
    
    override func mouseDown(with event: NSEvent) {
    }
    
    
}


class Scene: TScene {
    
    
    var movers: [Mover] = []
    
    
    
    override func setup() {
        for _ in 0 ..< 10 {
            let m = Mover(mass: random(min: 0.1, max: 2.0), x: random(max: tin.width), y: random(max: tin.height))
            movers.append(m)
        }
    }
    
    
    override func update() {
        
        background(gray: 1.0)
        
        for m1 in movers {
            for m2 in movers {
                if m1 !== m2 {
                    let force = m2.attract(mover: m1)
                    m1.applyForce(force: force)
                }
            }
            m1.update()
            m1.display()
        }
        
    }
    
    
    
    
}

