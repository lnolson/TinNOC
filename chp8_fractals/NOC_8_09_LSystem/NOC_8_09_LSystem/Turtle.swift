//
//  Turtle.swift
//  NOC_8_09_LSystem
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import Foundation
import Tin


class Turtle {
    
    var todo: String
    var len: Double
    var theta: Double
    
    
    init(s: String, l: Double, t: Double) {
        todo = s
        len = l
        theta = t
    }
    
    
    func render() {
        strokeColor(gray: 0, alpha: 0.3862)
        for c in todo {
            if c == "F" || c == "G" {
                line(x1: 0, y1: 0, x2: len, y2: 0)
                translate(dx: len, dy: 0)
            }
            else if c == "+" {
                rotate(by: -theta)
            }
            else if c == "-" {
                rotate(by: theta)
            }
            else if c == "[" {
                pushState()
            }
            else if c == "]" {
                popState()
            }
        }
    }
    
    
    func setLen(l: Double) {
        len = l
    }
    
    
    func changeLen(percent: Double) {
        len *= percent
    }
    
    
    func setToDo(s: String) {
        todo = s
    }
    
}
