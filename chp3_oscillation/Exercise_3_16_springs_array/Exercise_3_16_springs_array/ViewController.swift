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
    
    var bobs: [Bob] = []
    
    var springs: [Spring] = []
    
    
    override func setup() {
        // Create objects at starting position
        // Note third argument in Spring constructor is "rest length"
        
        for i in 0 ..< 5 {
            let b = Bob(x: tin.midX, y: 40.0 + Double(i) * 40.0)
            b.dragable = true
            bobs.append(b)
        }
        
        for i in 0 ..< 4 {
            let s = Spring(a: bobs[i], b: bobs[i+1], length: 40.0)
            springs.append(s)
        }
    }
    
    override func update() {
        background(gray: 1.0)
        
        for spring in springs {
            spring.update()
            spring.display()
        }
        
        for bob in bobs {
            bob.update()
            bob.display()
            bob.drag(mx: tin.mouseX, my: tin.mouseY)
        }
    }
    
    func mousePressed() {
        for bob in bobs {
            bob.clicked(mx: tin.mouseX, my: tin.mouseY)
        }
    }
    
    
    func mouseReleased() {
        for bob in bobs {
            bob.stopDragging()
        }
    }
}

