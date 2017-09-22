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
        view.window?.title = "Wave"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var startAngle = 0.0
    var angleVel = 0.23
    
    
    override func update() {
        background(gray: 1.0)
        
        startAngle += 0.015
        var angle = startAngle
        
        var x = 0.0
        while x <= tin.width {
            let y = remap(value: sin(angle), start1: -1.0, stop1: 1.0, start2: 0.0, stop2: tin.height)
            strokeColor(gray: 0.0)
            fillColor(gray: 0.0, alpha: 0.1960)
            lineWidth(2.0)
            ellipse(centerX: x, centerY: y, width: 48.0, height: 48.0)
            angle += angleVel
            
            x += 24.0
        }
    }
}

