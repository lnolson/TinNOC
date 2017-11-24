//
//  LSystem.swift
//  NOC_8_09_LSystem
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// An LSystem has a starting sentence
// An a ruleset
// Each generation recursively replaces characteres in the sentence
// Based on the rulset

import Foundation
import Tin


class LSystem {
    var sentence: String        // The sentence (a String)
    var ruleset: [Rule]         // The ruleset (an array of Rule objects)
    var generation: Int         // Keeping track of the generation #
    
    
    init(axiom: String, r: [Rule]) {
        sentence = axiom
        ruleset = r
        generation = 0
    }
    
    
    // Generate the next generation
    func generate() {
        // An empty StringBuffer that we will fill
        var nextgen = ""
        
        // For every character in the sentence
        for c in sentence {
            let curr = "\(c)"
            // We will replace it with itself unless it matches one of our rules
            var replace = "\(c)"
            for rule in ruleset {
                let a = rule.getA()
                // if we match the Rule, get the replacement String out of the Rule
                if a == curr {
                    replace = rule.getB()
                    break
                }
            }
            // Append replacement String
            nextgen.append(replace)
        }
        // Replace sentence
        sentence = nextgen
        // Increment generation
        generation += 1
    }
    
    
    func getSentence() -> String {
        return sentence
    }
    
    
    func getGeneration() -> Int {
        return generation
    }
}
