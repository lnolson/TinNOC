//
//  ViewController.swift
//  NOC_6_02_Arrive
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Seeking "vehicle" follows the mouse position

// Implements Craig Reynold's autonomous steering behaviors
// One vehicle "seeks"
// See: http://www.red3d.com/cwr/

import Cocoa
import Tin

class ViewController: TController {

    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Arrive"
        
        makeView(width: 800.0, height: 400.0)
        let scene = Scene()
        present(scene: scene)
        
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var v: Vehicle!
    
    override func setup() {
        v = Vehicle(x: tin.midX, y: tin.midY)
    }
    
    
    override func update() {
        background(gray: 1.0)
        
        let mouse = TVector2(x: tin.mouseX, y: tin.mouseY)
        
        fillColor(gray: 0.75)
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        ellipse(centerX: mouse.x, centerY: mouse.y, width: 48.0, height: 48.0)
        
        v.arrive(target: mouse)
        v.update()
        v.display()
        
    }
}

