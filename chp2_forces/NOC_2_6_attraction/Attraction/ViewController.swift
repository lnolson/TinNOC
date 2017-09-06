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
        scene.mouseReleased()
    }
    
    
    override func mouseDown(with event: NSEvent) {
        scene.mousePressed()
    }
    
    
}


class Scene: TScene {
    
    var m: Mover = Mover(mass: 1.0, x: 400.0, y: 50.0)
    var a: Attractor = Attractor()
    
    
    
    override func setup() {
        
    }
    
    
    override func update() {
        
        background(gray: 1.0)
        
        let force = a.attract(mover: m)
        m.applyForce(force: force)
        m.update()
        
        a.drag()
        a.hover(mx: tin.mouseX, my: tin.mouseY)
        a.display()
        m.display()
        
    }
    
    
    func mousePressed() {
        a.clicked(mx: tin.mouseX, my: tin.mouseY)
    }
    
    func mouseReleased() {
        a.stopDragging()
    }
    
}

