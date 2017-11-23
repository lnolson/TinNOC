//
//  ViewController.swift
//  NOC_8_06_Tree_static
//
//
//
// Recursive Tree
// Daniel Shiffman <http://www.shiffman.net>
// Nature of Code, Chapter 8

// Renders a simple tree-like structure via recursion
// Branching angle calculated as a function of horizontal mouse position



import Cocoa
import Tin

class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        view.window?.title = "Tree static"
        makeView(width: 800.0, height: 800.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    override func setup() {
    }
    
    override func update() {
        background(gray: 1.0)
        translate(dx: tin.midX, dy: 0)
        strokeColor(gray: 0)
        branch(len: 240)
        view?.stopUpdates()
    }
    
    
    func branch(len: Double) {
        lineWidth(2)
        
        line(x1: 0, y1: 0, x2: 0, y2: len)
        // Move to the end of that line
        translate(dx: 0, dy: len)
        
        let newlen = len * 0.66
        // All recursive functions must have an exit condition!!!!
        // Here, ours is when the length of the branch is 2 pixels or less
        if newlen > 2 {
            pushState()
            rotate(by: .pi/5.0)
            branch(len: newlen)
            popState()
            
            pushState()
            rotate(by: -.pi/5.0)
            branch(len: newlen)
            popState()
        }
    }
    
}

