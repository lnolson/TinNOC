//
//  ViewController.swift
//  Exercise_8_08_09_TreeArrayListLeaves
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Recursive Tree (w/ ArrayList)
// Nature of Code, Chapter 8

// Recursive branching "structure" without an explicitly recursive function
// Instead we have an ArrayList to hold onto N number of elements
// For every element in the ArrayList, we add 2 more elements, etc. (this is the recursion)


import Cocoa
import Tin

class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Tree Leaves"
        makeView(width: 800.0, height: 600.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var tree: [Branch] = []
    var leaves: [Leaf] = []
    
    
    override func setup() {
        // A branch has a starting position, a starting "velocity", and a starting "timer"
        let l = TVector2(x: tin.midX, y: 0.0)
        let v = TVector2(x: 0.0, y: 1.0)
        let b = Branch(l: l, v: v, n: 150.0)
        // Add to arraylist
        tree.append(b)
    }
    
    
    override func update() {
        background(gray: 1.0)
        
        if let context = NSGraphicsContext.current {
            let cg = context.cgContext
            cg.setLineCap(.round)
        }
        
        // Let's stop when the arraylist gets too big
        // For every branch in the arraylist
        var i = tree.count - 1
        while i >= 0 {
            // Get the branch, update and draw it
            let b = tree[i]
            b.update()
            b.render()
            // If it's ready to split
            if b.timeToBranch() {
                if tree.count < 1024 {
                    tree.append(b.branch(angle: 30))    // Add one going right
                    tree.append(b.branch(angle: -25))   // Add one going left
                }
                else {
                    leaves.append(Leaf(l: b.end))
                }
            }
            i -= 1
        }
        
        for leaf in leaves {
            leaf.display()
        }
    }
    
    

    
    
}

