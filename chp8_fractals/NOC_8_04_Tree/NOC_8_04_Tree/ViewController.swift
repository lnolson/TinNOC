//
//  ViewController.swift
//  NOC_8_02_Recursion
//
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Recursive Tree
// Renders a simple tree-like structure via recursion
// Branching angle calculated as a function of horizontal mouse position

import Cocoa
import Tin

class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Tree"
        makeView(width: 600.0, height: 400.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var theta = 0.0
    
    override func update() {
        background(gray: 1.0)
        
        // Let's pick an angle 0 to 90 degrees based on the mouse position
        theta = remap(value: tin.mouseX, start1: 0, stop1: tin.width, start2: 0, stop2: .pi/2.0)
        
        // Start the tree from the bottom of the screen
        translate(dx: tin.midX, dy: 0)
        strokeColor(gray: 0)
        branch(len: 120)
    }
    
    
    func branch(len: Double) {
        // Each branch will be 2/3rds the size of the previous one
        
        let sw = remap(value: len, start1: 2, stop1: 120, start2: 1, stop2: 10)
        lineWidth(sw)
        
        line(x1: 0, y1: 0, x2: 0, y2: len)
        // Move to the end of that line
        translate(dx: 0, dy: len)
        
        let newlen = len * 0.66
        // All recursive functions must have an exit condition!!!!
        // Here, ours is when the length of the branch is 2 pixels or less
        if newlen > 2 {
            pushState()
            rotate(by: theta)
            branch(len: newlen)
            popState()
            
            pushState()
            rotate(by: -theta)
            branch(len: newlen)
            popState()
        }
    }
    
    
}

