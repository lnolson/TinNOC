//
//  Leaf.swift
//  Exercise_8_08_09_TreeArrayListLeaves
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Recursive Tree (w/ ArrayList)

// A class for a leaf that gets placed at the end of
// the last branches

import Foundation
import Tin


class Leaf {
    var pos: TVector2
    
    
    init(l: TVector2) {
        pos = l
    }
    
    
    func display() {
        strokeDisable()
        fillColor(gray: 0.1960, alpha: 0.3921)
        ellipse(centerX: pos.x, centerY: pos.y, width: 4, height: 4)
    }
}
