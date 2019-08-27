//
//  ViewController.swift
//
//  The Nature of Code
//  Daniel Shiffman
//  http://natureofcode.com

//  Koch Curve

//  Renders a simple fractal, the Koch snowflake
//  Each recursive level drawn in sequence



import Cocoa
import Tin


class ViewController: TController {
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Koch snowflake"
        
        makeView(width: 1200.0, height: 480.0)
        let scene = Scene()
        present(scene: scene)
        
        tview.showStats = false
        tview.frameRate = 1
    }
    

}


class Scene: TScene {

    var fractal: KochFractal!
    

    override func setup() {
        fractal = KochFractal()
    }
    

    override func update() {
        background(gray: 1.0)
        
        
        fractal.render()
        
        fractal.nextLevel()
        
        if fractal.count > 5 {
            fractal.restart()
        }
        
    }
}



