//
//  ViewController.swift
//  Angular_motion
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import Cocoa
import Tin


class ViewController: TController {

    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Angular Motion"
        
        makeView(width: 800.0, height: 200.0)
        let scene = Scene()
        present(scene: scene)
        tview.showStats = false
    }

}


class Scene: TScene {
    
    var angle = 0.0
    var aVelocity = 0.0
    var aAcceleration = 0.0001
    
    override func update() {
        background(gray: 1.0)
        fillColor(gray: 0.5)
        strokeColor(gray: 0.0)
        
        translate(dx: Double(tin.size.width)/2.0, dy: Double(tin.size.height)/2.0)
        rotate(by: angle)
        lineWidth(2.0)
        line(x1: -60.0, y1: 0.0, x2: 60.0, y2: 0.0)
        ellipse(centerX: 60.0, centerY: 0.0, width: 16.0, height: 16.0)
        ellipse(centerX: -60.0, centerY: 0.0, width: 16.0, height: 16.0)
        
        angle += aVelocity
        aVelocity += aAcceleration
        
    }
    
}

