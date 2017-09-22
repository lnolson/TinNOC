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

    override func viewWillAppear() {
        view.window?.title = "Start here"
        makeView(width: 800.0, height: 400.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    let mover = Mover()
    
    override func setup() {

    }
    
    override func update() {
        background(gray: 0.5)
        
        mover.update()
        mover.checkEdges()
        mover.display()
    }
}

