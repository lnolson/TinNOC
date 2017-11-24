//
//  ViewController.swift
//  Figure_8_02_Mandelbrot
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// The Mandelbrot Set

// Simple rendering of the Mandelbrot set
// c = a + bi
// Iterate z = z^2 + c, i.e.
// z(0) = 0
// z(1) = 0*0 + c
// z(2) = c*c + c
// z(3) = (c*c + c) * (c*c + c) + c
// etc.

// c*c = (a+bi) * (a+bi) = a^2 - b^2 + 2abi

import Cocoa
import Tin

class ViewController: TController {

    override func viewWillAppear() {
        view.window?.title = "Mandelbrot"
        makeView(width: 864, height: 432)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    // Establish a range of values on the complex plane
    var xmin = -2.5
    var ymin = -1.0
    var w = 4.0
    var h = 2.0
    // A different range will allow us to "zoom" in or out on the fractal
    // double xmin = -1.5; double ymin = -.1; double wh = 0.15;
    
    override func update() {
        background(gray: 1.0)
        strokeDisable()
        
        // Maximum number of iterations for each point on the complex plane
        let maxiterations = 200
        
        // x goes from xmin to xmax
        let xmax = xmin + w;
        // y goes from ymin to ymax
        let ymax = ymin + h;
        
        // Calculate amount we increment x,y for each pixel
        let dx = (xmax - xmin) / (tin.width);
        let dy = (ymax - ymin) / (tin.height);
        
        // Start y
        var y = ymin;
        var j = 0
        while j < Int(tin.height) {
            // Start x
            var x = xmin
            var i = 0
            while i < Int(tin.width) {
                // Now we test, as we iterate z = z^2 + cm does z tend towards infinity?
                var a = x
                var b = y
                var n = 0
                while n < maxiterations {
                    let aa = a * a
                    let bb = b * b
                    let twoab = 2.0 * a * b
                    a = aa - bb + x
                    b = twoab + y
                    // Infinty in our finite world is simple, let's just consider it 16
                    if aa + bb > 16.0 {
                        break   // Bail
                    }
                    n += 1
                }
                
                // We color each pixel based on how long it takes to get to infinity
                // If we never got there, let's pick the color black
                //if (n == maxiterations) pixels[i+j*width] = color(0);
                //else pixels[i+j*width] = color(n*16 % 255);  // Gosh, we could make fancy colors here if we wanted
                if n == maxiterations {
                    fillColor(gray: 0)
                }
                else {
                    let c = n * 16 % 255
                    fillColor(gray: Double(c)/255.0)
                }
                rect(x: Double(i), y: Double(j), width: 1, height: 1)
                
                i += 1
                x += dx
            }
            
            j += 1
            y += dy
        }
        
        view?.stopUpdates()
    }
    
    
}

