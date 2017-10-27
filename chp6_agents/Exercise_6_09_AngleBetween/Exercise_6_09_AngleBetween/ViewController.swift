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
        super.viewWillAppear()
        view.window?.title = "Angle Between"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var font = TFont(fontName: "Helvetica Neue Light", ofSize: 14.0)
    
    override func setup() {
        font.horizontalAlignment = .left
    }
    
    
    override func update() {
        background(gray: 1.0)
        
        // A "vector" (really a point) to store the mouse position and screen center position
        let mouseLoc = TVector2(x: tin.mouseX, y: tin.mouseY)
        let centerLoc = TVector2(x: tin.midX, y: tin.midY)
        
        // Aha, a vector to store the displacement between the mouse and center
        var v = mouseLoc - centerLoc
        v.normalize()
        v = v * 75.0
        
        let xaxis = TVector2(x: 75, y: 0)
        
        drawVector(v: v, pos: centerLoc, scayl: 1.0)
        drawVector(v: xaxis, pos: centerLoc, scayl: 1.0)
        
        let delta = v.angleBetween(b: xaxis)
        let deltaInDegrees = toDegrees(radians: delta)
        let msg = String(format: "%4.2f degrees\n%1.3f radians", arguments: [deltaInDegrees, delta])
        
        fillColor(gray: 0)
        text(message: msg, font: font, x: 10, y: 100)
    }
    
    
    func drawVector(v: TVector2, pos: TVector2, scayl: Double) {
        pushState()
        let arrowsize = 4.0
        // Translate to position to render vector
        translate(dx: pos.x, dy: pos.y)
        strokeColor(gray: 0.0, alpha: 0.3921)
        // Call vector heading function to get direction (note that pointing to the right is a heading of 0) and rotate
        rotate(by: v.heading())
        // Calculate length of vector & scale it to be bigger or smaller if necessary
        let len = v.magnitude * scayl
        // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
        line(x1: 0, y1: 0, x2: len, y2: 0)
        line(x1: len, y1: 0, x2: len-arrowsize, y2:  arrowsize/2.0)
        line(x1: len, y1: 0, x2: len-arrowsize, y2: -arrowsize/2.0)
        popState()
    }
    
}


extension TVector2 {
    
    func angleBetween(b: TVector2) -> Double {
        let alen = magnitude
        let blen = b.magnitude
        let a_dot_b = dot(v: b)
        return acos(a_dot_b / (alen * blen))
    }
}

