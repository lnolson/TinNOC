//
//  ViewController.swift
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import Cocoa
import Tin


class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Static Wave Lines"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    
    override func update() {
        background(gray: 1.0)
        
        var angle = 0.0
        let angleVel = 0.1
        
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillDisable()
        
        pathBegin()
        var x = 0.0
        while x <= tin.width {
            let y = remap(value: sin(angle), start1: -1.0, stop1: 1.0, start2: 0.0, stop2: tin.height)
            pathVertex(x: x, y: y)
            angle += angleVel
            x += 5.0
        }
        pathEnd()
        
        view?.stopUpdates()
    }
}

