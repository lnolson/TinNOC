//
//  ViewController.swift
//  NOC_8_06_SimpleLSystem
//
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// L-System
// Just demonstrating working with L-System strings
// No drawing


import Cocoa
import Tin

class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        view.window?.title = "Simple L-System"
        makeView(width: 400.0, height: 400.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        scene.mousePressed()
    }

}


class Scene: TScene {
    
    // Start with "A"
    var current: String = "A"
    // Number of  generations
    var count = 0
    
    var font = TFont(fontName: "Helvetica Neue", ofSize: 24)
    
    
    override func setup() {
        print("Generation \(count): \(current)")
    }
    
    override func update() {
        background(gray: 0.5)
        text(message: "Click mouse to generate", font: font, x: tin.midX, y: tin.midY)
        view?.stopUpdates()
    }
    
    
    func mousePressed() {
        var next = ""
        
        for c in current {
            if c == "A" {
                next.append("AB")
            }
            else if c == "B" {
                next.append("A")
            }
        }
        
        // The current String is now the next one
        current = next
        count += 1
        // Print to message console
        print("Generation \(count): \(current)")
    }
    
}

