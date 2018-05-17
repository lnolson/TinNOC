//
//  Perceptron.swift
//  NOC_10_01_SimplePerceptron
//
//
// Daniel Shiffman
// The Nature of Code
// http://natureofcode.com

// Simple Perceptron Example
// See: http://en.wikipedia.org/wiki/Perceptron

// Perceptron Class

import Foundation
import Tin



class Perceptron {
    var weights: [Double]   // Array of weights for inputs
    var c: Double           // learning constant
    
    
    // Perceptron is created with n weights and learning constant c
    init(n: Int, c: Double) {
        weights = []
        
        // Start with random weights
        for _ in 1...n {
            let value = random(min: -1, max: 1)
            weights.append(value)
        }
        
        self.c = c
    }
    
    
    // Function to train the Perceptron
    // Weights are adjusted based on "desired" answer.
    func train(inputs: [Double], desired: Int) {
        // Guess the result
        let guess = feedforward(inputs: inputs);
        // Compute the factor for changing the weight based on the error
        // Error = desired output - guessed output
        // Note this can only be 0, -2, or 2
        // Multiply by learning constant
        let error = desired - guess
        // Adjust weights based on weightChange * input
        for i in 0 ..< weights.count {
            weights[i] += c * Double(error) * inputs[i];
        }
    }
    
    
    // Guess -1 or 1 based on input values
    func feedforward(inputs: [Double]) -> Int {
        // Sum all values
        var sum = 0.0
        for i in 0 ..< weights.count {
            sum += inputs[i] * weights[i]
        }
        return activate(sum: sum)
    }
    
    
    func activate(sum: Double) -> Int {
        if sum > 0.0 {
            return 1
        }
        else {
            return -1
        }
    }
}
