//
//  ViewController.swift
//  NOC_8_05_KochSimple
//
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Koch Snowflake

// Renders a simple fractal, the Koch snowflake
// Each recursive level drawn in sequence


import Cocoa
import Tin

class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Koch Snowflake"
        makeView(width: 800.0, height: 923.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var lines: [KochLine] = []
    
    
    override func setup() {
        let margin = 10.0
        let y1 = tin.height / 4.0 + margin
        let y2 = y1 + (tin.width * cos(toRadians(degrees: 30))) - margin * 2.0
        let x1 = 0.0 + margin
        let x2 = tin.width - margin
        let x3 = tin.midX
        
        let a = TVector2(x: x1, y: y1)
        let b = TVector2(x: x2, y: y1)
        let c = TVector2(x: x3, y: y2)
        
        // Starting with additional lines
        lines.append(KochLine(a: a, b: b))
        lines.append(KochLine(a: b, b: c))
        lines.append(KochLine(a: c, b: a))
        
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

