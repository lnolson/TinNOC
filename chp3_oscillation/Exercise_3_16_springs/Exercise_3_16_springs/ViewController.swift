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
        view.window?.title = "Springs"
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
    
    var b1: Bob!
    var b2: Bob!
    var b3: Bob!
    
    var s1: Spring!
    var s2: Spring!
    var s3: Spring!
    
    
    override func setup() {
        // Create objects at starting position
        // Note third argument in Spring constructor is "rest length"
        
        b1 = Bob(x: tin.midX, y: 100.0)
        b2 = Bob(x: tin.midX, y: 200.0)
        b3 = Bob(x: tin.midX, y: 300.0)
        
        b1.dragable = true
        
        s1 = Spring(a: b1, b: b2, length: 100.0)
        s2 = Spring(a: b2, b: b3, length: 100.0)
        s3 = Spring(a: b1, b: b3, length: 100.0)
    }
    
    override func update() {
        background(gray: 1.0)
        
        s1.update()
        s2.update()
        s3.update()
        
        s1.display()
        s2.display()
        s3.display()
        
        b1.update()
        b2.update()
        b3.update()
        
        b1.display()
        b2.display()
        b3.display()
        
        b1.drag(mx: tin.mouseX, my: tin.mouseY)
    }
    
    func mousePressed() {
        b1.clicked(mx: tin.mouseX, my: tin.mouseY)
    }
    
    
    func mouseReleased() {
        b1.stopDragging()
    }
}

