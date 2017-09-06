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
import GameplayKit


class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Gaussian"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    //var randomizer = GKGaussianDistribution(lowestValue: 0, highestValue: 10000)
    var source: GKARC4RandomSource!
    var randomizer: GKGaussianDistribution!
    
    override func setup() {
        tin.enableRestoreFromPrevious()
        source = GKARC4RandomSource()
        randomizer = GKGaussianDistribution(lowestValue: -100000000, highestValue: 100000000)
    }
    
    override func update() {
        if tin.frameCount == 2 {
            background(gray: 1.0)
        }
        
        // Get a gaussian random number w/ mean of 0 and standard deviation of 1.0
        var xloc = Double(randomizer.nextInt()) / (100000000.0 / 4.0)
        
        let sd = 60.0                               // Define a standard deviation
        let mean = Double(tin.size.width) / 2.0     // Define a mean value (middle of screen along x-axis)
        xloc = (xloc * sd) + mean                   // Scale the gaussian random number by standard deviation
        
        fillColor(gray: 0.0, alpha: 0.0392)
        strokeDisable()
        ellipse(centerX: xloc, centerY: tin.midY, width: 16.0, height: 16.0)
    }
}

