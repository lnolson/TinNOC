//
//  Rule.swift
//  NOC_8_09_LSystem
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// LSystem Rule class

import Foundation
import Tin


class Rule {
    var a: String
    var b: String
    
    
    init(a: String, b: String) {
        self.a = a
        self.b = b
    }
    
    
    func getA() -> String {
        return a
    }
    
    
    func getB() -> String {
        return b
    }
}
