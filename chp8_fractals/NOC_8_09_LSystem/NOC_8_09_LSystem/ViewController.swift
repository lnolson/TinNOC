//
//  ViewController.swift
//  NOC_8_07_TreeStochastic_angleonly
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com




import Cocoa
import Tin

class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        view.window?.title = "L-System"
        makeView(width: 1000.0, height: 1000.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        scene.mousePressed()
    }

}


class Scene: TScene {
    
    var font = TFont(fontName: "Helvetica Neue", ofSize: 20)
    var lsys: LSystem!
    var turtle: Turtle!
    var counter: Int = 0
    
    override func setup() {
        font.horizontalAlignment = .left
        
        let rule = Rule(a: "F", b: "FF+[+F-F-F]-[-F+F+F]")
        let ruleset = [rule]
        lsys = LSystem(axiom: "F", r: ruleset)
        turtle = Turtle(s: lsys.getSentence(), l: tin.height/4, t: toRadians(degrees: 25))
    }
    
    
    override func update() {
        background(gray: 1.0)
        
        fillColor(gray: 0)
        text(message: "Click mouse to generate.", font: font, x: 10, y: 10)
        
        translate(dx: tin.midX, dy: 0)
        rotate(by: .pi/2)
        turtle.render()
        
        view?.stopUpdates()
    }
    
    
    func mousePressed() {
        view?.needsDisplay = true
        if counter < 5 {
            lsys.generate()
            turtle.setToDo(s: lsys.getSentence())
            turtle.changeLen(percent: 0.5)
            counter += 1
        }
    }
    
}

