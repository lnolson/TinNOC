//
//  Trainer.swift
//  NOC_10_01_SimplePerceptron
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Simple Perceptron Example
// See: http://en.wikipedia.org/wiki/Perceptron

// A class to describe a training point
// Has an x and y, a "bias" (1) and known output
// Could also add a variable for "guess" but not required here

import Foundation
import Tin


class Trainer {
    var inputs: [Double]
    var answer: Int
    
    
    init(x: Double, y: Double, answer: Int) {
        inputs = [ x, y, 1.0 ]
        self.answer = answer
    }
}
