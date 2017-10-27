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
        view.window?.title = "Simple Scalar Projection"
        makeView(width: 600.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    
    
    override func setup() {
        
    }
    
    
    override func update() {
        background(gray: 1.0)
        
        let a = TVector2(x: 50, y: 50)
        let b = TVector2(x: 550, y: 310)
        let mouse = TVector2(x: tin.mouseX, y: tin.mouseY)
        
        strokeColor(gray: 0)
        lineWidth(2)
        line(x1: a.x, y1: a.y, x2: b.x, y2: b.y)
        line(x1: a.x, y1: a.y, x2: mouse.x, y2: mouse.y)
        fillColor(gray: 0)
        ellipse(centerX: a.x, centerY: a.y, width: 8, height: 8)
        ellipse(centerX: b.x, centerY: b.y, width: 8, height: 8)
        ellipse(centerX: mouse.x, centerY: mouse.y, width: 8, height: 8)
        
        let norm = scalarProjection(p: mouse, a: a, b: b)
        lineWidth(1)
        strokeColor(gray: 0.1960)
        line(x1: mouse.x, y1: mouse.y, x2: norm.x, y2: norm.y)
        
        strokeDisable()
        fillColor(red: 1, green: 0, blue: 0, alpha: 1)
        ellipse(centerX: norm.x, centerY: norm.y, width: 16, height: 16)
    }
    
    func scalarProjection(p: TVector2, a: TVector2, b: TVector2) -> TVector2 {
        let ap = p - a
        var ab = b - a
        ab.normalize()
        ab = ab * ap.dot(v: ab)
        let normalPoint = a + ab
        return normalPoint
    }
}

