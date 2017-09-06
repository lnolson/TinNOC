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
        view.window?.title = "Accept Reject"
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
        for _ in 0...19 {
            randomCounts.append(0)
        }
    }
    
    override func update() {
        background(gray: 1.0)
        
        // Pick a random number and increase the count
        let index = Int(acceptReject() * Double(randomCounts.count))
        randomCounts[index] += 1
        
        strokeColor(gray: 0.0)
        lineWidth(2.0)
        fillColor(gray: 0.5)
        let w = Double(tin.size.width) / Double(randomCounts.count)
        for x in 0..<randomCounts.count {
            rect(x: Double(x) * w, y: 0.0, width: w, height: Double(randomCounts[x]))
        }
    }
    
    // An algorithm for picking a random number based on monte carlo method
    // Here probability is determined by formula y = x
    func acceptReject() -> Double {
        // Have we found one yet
        var foundone = false
        var hack = 0  // let's count just so we don't get stuck in an infinite loop by accident
        while !foundone && hack < 10000 {
            // Pick two random numbers
            let r1 = TRandom.next(max: 1.0)
            let r2 = TRandom.next(max: 1.0)
            let y = r1 * r1     // y = x*x (change for different results)
            // If r2 is valid, we'll use this one
            if r2 < y {
                foundone = true
                return r1
            }
            hack += 1
        }
        return 0.0
    }
}

