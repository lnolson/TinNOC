//
//  ViewController.swift
//  NOC_10_01_SimplePerceptron
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Simple Perceptron Example
// See: http://en.wikipedia.org/wiki/Perceptron

// Code based on text "Artificial Intelligence", George Luger

import Cocoa
import Tin


class ViewController: TController {

    override func viewWillAppear() {
        super.viewWillAppear()
        view.window?.title = "Simple Perceptron"
        makeView(width: 640.0, height: 360.0)
        let scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }


}



class Scene: TScene {
    // A list of points we will use to "train" the perceptron
    var training: [Trainer] = []
    
    // A Perceptron object
    var ptron: Perceptron!
    
    // We will train the perceptron with one "Point" object at a time
    var count = 0
    
    // Coordinate space
    var xmin = -400.0
    var ymin = -100.0
    var xmax =  400.0
    var ymax =  100.0
    
    
    // The function to describe a line
    func f(x: Double) -> Double {
        return 0.4 * x + 1.0
    }
    
    
    override func setup() {
        // The perceptron has 3 inputs -- x, y, and bias
        // Second value is "Learning Constant"
        // Learning Constant is low just b/c it's fun to watch, this is not necessarily optimal
        ptron = Perceptron(n: 3, c: 0.00001)
        
        // Create a random set of training points and calculate the "known" answer
        for _ in 0 ..< 2000 {
            let x = random(min: xmin, max: xmax)
            let y = random(min: ymin, max: ymax)
            var answer = 1
            if y < f(x: x) {
                answer = -1
            }
            training.append(Trainer(x: x, y: y, answer: answer))
        }
    }
    
    
    override func update() {
        background(gray: 1.0)
        
        translate(dx: tin.midX, dy: tin.midY)
        
        // Draw the line
        lineWidth(4)
        strokeColor(gray: 0.5)
        var x1 = xmin
        var y1 = f(x: x1)
        var x2 = xmax
        var y2 = f(x: x2)
        line(x1: x1, y1: y1, x2: x2, y2: y2)
        
        // Draw the line based on the current weights
        // Formula is weights[0]*x + weights[1]*y + weights[2] = 0
        strokeColor(gray: 0)
        lineWidth(1)
        
        let weights = ptron.weights
        x1 = xmin
        y1 = (-weights[2] - weights[0]*x1)/weights[1]
        x2 = xmax
        y2 = (-weights[2] - weights[0]*x2)/weights[1]
        line(x1: x1, y1: y1, x2: x2, y2: y2)
        
        // Train the Perceptron with one "training" point at a time
        ptron.train(inputs: training[count].inputs, desired: training[count].answer)
        count = (count + 1) % training.count
        
        
        // Draw all the points based on what the Perceptron would "guess"
        // Does not use the "known" correct answer
        for i in 0 ..< count {
            strokeColor(gray: 0)
            lineWidth(1)
            fillColor(gray: 0.0)
            let guess = ptron.feedforward(inputs: training[i].inputs);
            if guess > 0 {
                fillDisable()
            }
            
            ellipse(centerX: training[i].inputs[0], centerY: training[i].inputs[1], width: 8, height: 8)
        }
    }
}

