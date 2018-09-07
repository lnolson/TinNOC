//
//  ViewController.swift
//  RandomDistribution
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
//

import Cocoa
import Tin


class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Random Distribution"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    // An array to keep track of how often random numbers are picked
    var randomCounts: [Int] = []
    
    override func setup() {
        for _ in 0...99 {
            randomCounts.append(0)
        }
    }
    
    override func update() {
        background(gray: 1.0)
        
        // Pick a random number and increase the count
        let index = Int(random(min: 0.0, max: Double(randomCounts.count)))
        randomCounts[index] += 1
        
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.5)
        let w = Double(tin.size.width) / Double(randomCounts.count)
        for x in 0..<randomCounts.count {
            rect(x: Double(x) * w, y: 0.0, width: w, height: Double(randomCounts[x]))
        }
    }
}

