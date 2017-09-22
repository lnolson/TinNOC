//
//  ViewController.swift
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import Cocoa
import Tin


class ViewController: TController {
    
    var scene: Scene!
    
    
    override func viewWillAppear() {
        view.window?.title = "Spring"
        makeView(width: 640.0, height: 360.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    
    override func mouseDown(with event: NSEvent) {
        scene.mousePressed()
    }
    
    
    override func mouseUp(with event: NSEvent) {
        scene.mouseReleased()
    }

}


class Scene: TScene {
    
    var bob: Bob!
    
    var spring: Spring!
    
    var font: TFont!
    
    
    override func setup() {
        spring = Spring(x: tin.midX, y: tin.height - 10.0, length: 100.0)
        bob = Bob(x: tin.midX, y: tin.height - 100.0)
        font = TFont(fontName: "Helvetica Neue Light", ofSize: 20.0)
        font.horizontalAlignment = .left
    }
    
    override func update() {
        background(gray: 1.0)
        
        // Apply a gravity force to the bob
        let gravity = TVector2(x: 0.0, y: -2.0)
        bob.applyForce(force: gravity)
        
        // Connect the bob to the spring (this calculates the force)
        spring.connect(b: bob)
        // Constrain spring distance between min and max
        spring.constrainLength(b: bob, minlen: 30.0, maxlen: 200.0)
        
        // Update bob
        bob.update()
        // If it's being dragged
        bob.drag(mx: tin.mouseX, my: tin.mouseY)
        
        // Draw everything
        // Draw a line between spring and bob
        spring.displayLine(b: bob)
        bob.display()
        spring.display()
        
        fillColor(gray: 0.0)
        text(message: "click on bob to drag", font: font, x: 10.0, y: 5.0)
    }
    
    
    func mousePressed() {
        bob.clicked(mx: tin.mouseX, my: tin.mouseY)
    }
    
    
    func mouseReleased() {
        bob.stopDragging()
    }
    
}

