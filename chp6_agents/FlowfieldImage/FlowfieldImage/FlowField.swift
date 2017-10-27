//
//  FlowField.swift
//  
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Flow Field Following

import Foundation
import Tin


class FlowField {
    // A flow field is a two dimensional array of PVectors
    var field: [[TVector2]]
    var cols: Int
    var rows: Int
    // How large is each "cell" of the flow field
    var resolution: Int
    var img: TImage
    
    
    init(r: Int, image: TImage) {
        resolution = r
        // Determine the number of columns and rows based on sketch's width and height
        cols = Int(tin.width) / resolution
        rows = Int(tin.height) / resolution
        field = Array(repeating: Array(repeating: TVector2(), count: rows) , count: cols)
        img = image
        setup()
    }
    
    
    // In Shiffman, this function is called init. Since that has a special meaning
    // in Swift, I have changed the name to setup.
    func setup() {
        let randxoff = random(min: -100.0, max: 100.0)
        let randyoff = random(min: -100.0, max: 100.0)
        var xoff = randxoff
        for i in 0 ..< cols {
            var yoff = randyoff
            for j in 0 ..< rows {
                let x = i * resolution
                let y = j * resolution
                let clr = img.color(atX: x, y: y)
                let theta = remap(value: clr.brightness(), start1: 0.0, stop1: 1.0, start2: 0.0, stop2: Double.pi * 2.0)
                field[i][j] = TVector2(x: cos(theta), y: sin(theta))
                yoff += 0.1
            }
            xoff += 0.1
        }
    }
    
    
    func display() {
        lineWidth(1.0)
        for i in 0 ..< cols {
            for j in 0 ..< rows {
                drawVector(v: field[i][j], x: Double(i * resolution), y: Double(j * resolution), scayl: Double(resolution - 2))
            }
        }
    }
    
    
    // Renders a vector object 'v' as an arrow and a position 'x,y'
    func drawVector(v: TVector2, x: Double, y: Double, scayl: Double) {
        pushState()
        let arrowsize = 4.0
        // Translate to position to render vector
        translate(dx: x, dy: y)
        strokeColor(gray: 0.0, alpha: 0.3921)
        // Call vector heading function to get direction (note that pointing to the right is a heading of 0) and rotate
        rotate(by: v.heading())
        // Calculate length of vector & scale it to be bigger or smaller if necessary
        let len = v.magnitude * scayl
        // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
        line(x1: 0, y1: 0, x2: len, y2: 0)
        line(x1: len, y1: 0, x2: len-arrowsize, y2:  arrowsize/2.0)
        line(x1: len, y1: 0, x2: len-arrowsize, y2: -arrowsize/2.0)
        popState()
    }
    
    
    func lookup(lookup: TVector2) -> TVector2 {
        let column = Int(constrain(value: lookup.x/Double(resolution), min: 0, max: Double(cols-1)))
        let row = Int(constrain(value: lookup.y/Double(resolution), min: 0, max: Double(rows-1)))
        return field[column][row]
    }
}
