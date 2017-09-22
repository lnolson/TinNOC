//
//  ViewController.swift
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Additive Wave
// Create a more complex wave by adding two waves together.

// Maybe better for this answer to be OOP???

import Cocoa
import Tin


class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Additive Wave"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    // How far apart should each horizontal position be spaced.
    let xspacing = 8
    
    // Width of entire wave.
    var w = 0
    
    // Total # of waves to add together.
    let maxwaves = 5
    
    var theta = 0.0
    
    // Height of wave
    var amplitude: [Double] = []
    
    // Value for incrementing X, to be calculated as a function of period and xspacing
    var dx: [Double] = []
    
    // Using an array to store height values for the wave (not entirely necessary)
    var yvalues: [Double] = []
    
    override func setup() {
        w = Int(tin.width) + 16
        
        for _ in 0 ..< maxwaves {
            let a = TRandom.next(min: 10.0, max: 30.0)
            amplitude.append(a)
            
            let period = TRandom.next(min: 100.0, max: 300.0)
            let inc = (Double.pi * 2.0 / period) * Double(xspacing)
            dx.append(inc)
        }
        
        let n = w / xspacing
        for _ in 0 ..< n {
            yvalues.append(0.0)
        }
    }
    
    
    override func update() {
        background(gray: 0.0)
        
        calcWave()
        renderWave()
    }
    
    
    func calcWave() {
        // Increment theta (try different values for 'angular velocity' here
        theta += 0.02
        
        // Set all height values to zero
        for i in 0 ..< yvalues.count {
            yvalues[i] = 0.0
        }
        
        // Accumulate wave height values
        for j in 0 ..< maxwaves {
            var x = theta
            for i in 0 ..< yvalues.count {
                // Every other wave is cosine instead of sine
                if j % 2 == 0 {
                    yvalues[i] += sin(x) * amplitude[j]
                }
                else {
                    yvalues[i] += cos(x) * amplitude[j]
                }
                x += dx[j]
            }
        }
    }
    
    
    func renderWave() {
        // A simple way to draw the wave with an ellipse at each position
        strokeDisable()
        fillColor(gray: 1.0, alpha: 0.1960)
        for x in 0 ..< yvalues.count {
            ellipse(centerX: Double(x * xspacing), centerY: tin.midY + yvalues[x], width: 16.0, height: 16.0)
        }
    }
    
}

