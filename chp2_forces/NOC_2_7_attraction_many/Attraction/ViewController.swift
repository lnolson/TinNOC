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
    
    var a: Attractor = Attractor()
    var movers: [Mover] = []
    
    
    
    override func setup() {
        for _ in 0 ..< 10 {
            let m = Mover(mass: TRandom.next(min: 0.1, max: 2.0), x: TRandom.next(max: Double(tin.size.width)), y: TRandom.next(max:Double(tin.size.height)))
            movers.append(m)
        }
    }
    
    
    override func update() {
        
        background(gray: 1.0)
        
        a.drag()
        a.hover(mx: tin.mouseX, my: tin.mouseY)
        a.display()
        
        for m in movers {
            let force = a.attract(mover: m)
            m.applyForce(force: force)
            m.update()
            m.display()
        }
        
    }
    
    func mousePressed() {
        a.clicked(mx: tin.mouseX, my: tin.mouseY)
    }
    
    func mouseReleased() {
        a.stopDragging()
    }
    
    
}

