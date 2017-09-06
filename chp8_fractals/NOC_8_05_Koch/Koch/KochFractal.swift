//
//  KochFractal.swift
//  Koch
//
//

import Cocoa
import Tin


class KochFractal {
    var start: TVector2
    var end: TVector2
    var lines: [KochLine]
    var count: Int
    
    init() {
        start = TVector2(x: 0.0, y: 20.0)
        end = TVector2(x: Double(tin.size.width), y: 20.0)
        lines = []
        count = 0
        restart()
    }
    
    
    func restart() {
        count = 0
        lines.removeAll()
        lines.append(KochLine(start: start, end: end))
    }
    
    
    func nextLevel() {
        lines = iterate(before: lines)
        count += 1
    }
    
    
    
    func render() {
        for line in lines {
            line.display()
        }
    }
    
    
    // This is where the **MAGIC** happens
    // Step 1: Create an empty arraylist
    // Step 2: For every line currently in the arraylist
    //   - calculate 4 line segments based on Koch algorithm
    //   - add all 4 line segments into the new arraylist
    // Step 3: Return the new arraylist and it becomes the list of line segments for the structure
  
    func iterate(before: [KochLine]) -> [KochLine] {
        var now: [KochLine] = []
        for line in before {
            // Calculate 5 koch PVectors (done for us by the line object)
            let a = line.start()
            let b = line.kochleft()
            let c = line.kochmiddle()
            let d = line.kochright()
            let e = line.end()
            
            // Make line segments between all the PVectors and add them
            now.append(KochLine(start: a, end: b))
            now.append(KochLine(start: b, end: c))
            now.append(KochLine(start: c, end: d))
            now.append(KochLine(start: d, end: e))
        }
        return now
    }
}
