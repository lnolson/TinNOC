//
//  ViewController.swift
//  Exercise_8_01_RecursionLines
//
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Simple Recursion

import Cocoa
import Tin

class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Recursion Lines"
        makeView(width: 1000, height: 800)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    override func update() {
        background(gray: 1.0)
        lineWidth(1)
        drawLines(x1: 100, y1: tin.midY, x2: tin.width - 100.0, y2: tin.midY)
        view?.stopUpdates()
    }
    
    
    func drawLines(x1: Double, y1: Double, x2: Double, y2: Double) {
        line(x1: x1, y1: y1, x2: x2, y2: y2)
        
        let dx = x2 - x1
        let dy = y2 - y1
        
        if dx == 0.0 && dy > 4.0 {
            drawLines(x1: x1 - dy/3, y1: y1, x2: x1 + dy/3, y2: y1)
            drawLines(x1: x1 - dy/3, y1: y2, x2: x1 + dy/3, y2: y2)
        }
        else if dy == 0.0 && dx > 4.0 {
            drawLines(x1: x1, y1: y1 - dx/3, x2: x1, y2: y1 + dx/3)
            drawLines(x1: x2, y1: y1 - dx/3, x2: x2, y2: y1 + dx/3)
        }
    }
    
}

