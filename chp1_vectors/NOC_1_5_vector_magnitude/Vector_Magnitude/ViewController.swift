//
//  ViewController.swift
//

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 1-5: Vector magnitude

import Cocoa
import Tin


class ViewController: TController {

    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Vector Magnitude"
        
        makeView(width: 640.0, height: 360.0)
        
        let scene = Scene()
        
        present(scene: scene)
        
        tview.showStats = false
    }
    
    
}


class Scene: TScene {
    

    override func update() {
        
        background(gray: 1.0)
        
        var mouse = TVector2(x: tin.mouseX, y: tin.mouseY)
        let center = TVector2(x: tin.midX, y: tin.midY)
        
        mouse = mouse - center
        
        let m = mouse.magnitude
        fillColor(gray: 0.0)
        strokeDisable()
        rect(x: 0.0, y: 0.0, width: m, height: 50.0)
        
        translate(dx: tin.midX, dy: tin.midY)
        lineWidth(2.0)
        strokeColor(gray: 0.0)
        line(x1: 0.0, y1: 0.0, x2: mouse.x, y2: mouse.y)
        
    }
}

