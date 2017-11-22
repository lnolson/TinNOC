//
//  ViewController.swift
//  NOC_8_05_KochSimple
//
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Koch Curve
// Renders a simple fractal, the Koch snowflake
// Each recursive level drawn in sequence


import Cocoa
import Tin

class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Koch Simple"
        makeView(width: 766.0, height: 400.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var lines: [KochLine] = []
    
    
    override func setup() {
        let start = TVector2(x: 0, y: 50)
        let end = TVector2(x: tin.width, y: 50)
        lines.append(KochLine(a: start, b: end))
        
        for _ in 1...5 {
            generate()
        }
    }
    
    override func update() {
        background(gray: 1.0)
        
        lineWidth(1)
        for l in lines {
            l.display()
        }
    }
    
    
    func generate() {
        var next: [KochLine] = []
        for l in lines {
             // Calculate 5 koch PVectors (done for us by the line object)
            let a = l.kochA()
            let b = l.kochB()
            let c = l.kochC()
            let d = l.kochD()
            let e = l.kochE()
            // Make line segments between all the PVectors and add them
            next.append(KochLine(a: a, b: b))
            next.append(KochLine(a: b, b: c))
            next.append(KochLine(a: c, b: d))
            next.append(KochLine(a: d, b: e))
        }
        lines = next
    }
    
}

