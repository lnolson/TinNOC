//
//  ViewController.swift
//

import Cocoa
import Tin


class ViewController: TController {
    
    var scene: Scene!
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Flocking"
        
        makeView(width: 640.0, height: 360.0)
        
        scene = Scene()
        present(scene: scene)
        
        tview.showStats = false
    }
    
    
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        print("mouse: \(tin.mouseX),\(tin.mouseY)")
        scene.addBoid(x: tin.mouseX, y: tin.mouseY)
    }
    
}


class Scene: TScene {
    
    var flock = Flock()
    
    
    override func setup() {
        for _ in 0 ..< 200 {
            let b = Boid(x: Double(tin.size.width) / 2.0, y: Double(tin.size.height) / 2.0)
            flock.add(boid: b)
        }
    }
    
    override func update() {
        
        background(gray: 0.5)
        flock.run()
        
    }
    
    func addBoid(x: Double, y: Double) {
        let b = Boid(x: x, y: y)
        flock.add(boid: b)
    }
    
}

