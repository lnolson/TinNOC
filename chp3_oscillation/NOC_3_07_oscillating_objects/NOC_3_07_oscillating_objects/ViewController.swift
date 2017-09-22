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
        view.window?.title = "Oscillating Objects"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var oscillators: [Oscillator] = []
    
    override func setup() {
        for _ in 1...10 {
            let osc = Oscillator()
            oscillators.append(osc)
        }
    }
    
    override func update() {
        background(gray: 1.0)
        
        for osc in oscillators {
            osc.oscillate()
            osc.display()
        }
    }
}

