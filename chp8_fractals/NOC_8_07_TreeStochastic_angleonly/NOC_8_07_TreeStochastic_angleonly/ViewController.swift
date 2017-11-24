//
//  ViewController.swift
//  NOC_8_07_TreeStochastic
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Stochastic Tree
// Renders a simple tree-like structure via recursion
// Angles and number of branches are random



import Cocoa
import Tin

class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        view.window?.title = "Stochastic Tree"
        makeView(width: 800.0, height: 800.0)
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
    
    var font = TFont(fontName: "Helvetica Neue", ofSize: 20)
    
    
    override func setup() {
        font.horizontalAlignment = .left
    }
    
    override func update() {
        background(gray: 1.0)
        newTree()
        text(message: "Click mouse to generate a new tree", font: font, x: 10, y: 10)
        view?.stopUpdates()
    }
    
    
    func newTree() {
        
        if let context = NSGraphicsContext.current {
            let cg = context.cgContext
            cg.setLineCap(.round)
        }
        
        fillColor(gray: 0)
        strokeColor(gray: 0)
        pushState()
        // Start the tree from the bottom of the screen
        translate(dx: tin.midX, dy: 0)
        // Start the recursive branching!
        branch(h: 240)
        popState()
    }
    
    
    func branch(h: Double) {
        // thickness of the branch is mapped to its length
        let sw = remap(value: h, start1: 2, stop1: 120, start2: 1, stop2: 5)
        lineWidth(sw)
        
        // Draw the actual branch
        line(x1: 0, y1: 0, x2: 0, y2: h)
        
        // Move along to end
        translate(dx: 0, dy: h)
        
        // Each branch will be 2/3rds the size of the previous one
        let newh = h * 0.66
        
        // All recursive functions must have an exit condition!!!!
        // Here, ours is when the length of the branch is 2 pixels or less
        if newh > 2 {
            // A random number of branches
            let n = Int(random(min: 1, max: 4))
            for _ in 0 ..< n {
                // Picking a random angle
                let theta = random(min: -.pi/2, max: .pi/2)
                pushState()
                rotate(by: theta)
                branch(h: newh)
                popState()
            }
        }
    }
    
    
    func mousePressed() {
        view?.needsDisplay = true
    }
    
}

