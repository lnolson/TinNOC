//
//  ViewController.swift
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Demonstration of Craig Reynolds' "Flocking" behavior
// See: http://www.red3d.com/cwr/
// Rules: Cohesion, Separation, Alignment

// Click mouse to add boids into the system

import Cocoa
import Tin


class ViewController: TController {
    
    var scene: Scene!
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        view.window?.title = "Flocking"
        makeView(width: 900.0, height: 480.0)
        scene = Scene()
        present(scene: scene)
        tview.showStats = false
    }
    
    
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        scene.addBoid(x: tin.mouseX, y: tin.mouseY)
    }
    
}


class Scene: TScene {
    
    var flock = Flock()
    var font = TFont(fontName: "Helvetica Neue Light", ofSize: 14.0)
    
    override func setup() {
        for _ in 1...200 {
            let b = Boid(x: Double(tin.size.width) / 2.0, y: Double(tin.size.height) / 2.0)
            flock.add(boid: b)
        }
        font.horizontalAlignment = .left
    }
    
    override func update() {
        background(gray: 0.5)
        flock.run()
        
        fillColor(gray: 0.0)
        text(message: "Drag the mouse to generate new boids", font: font, x: 10.0, y: 10.0)
    }
    
    func addBoid(x: Double, y: Double) {
        let b = Boid(x: x, y: y)
        flock.add(boid: b)
    }
    
}

