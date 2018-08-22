//
//  ViewController.swift
//  RandomWalkTendsToRight
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
//

import Cocoa
import Tin


class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Random Walk Tends To Right"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var w = Walker()
    
    override func setup() {
        tin.enableRestoreFromPrevious()
    }
    
    override func update() {
        if tin.frameCount <= 2 {
            background(gray: 1.0)
        }
        
        w.step()
        w.render()
    }
}

