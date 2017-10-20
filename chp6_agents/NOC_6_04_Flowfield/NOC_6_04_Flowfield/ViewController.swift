//
//  ViewController.swift
//  NOC_6_04
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Flow Field Following
// Via Reynolds: http://www.red3d.com/cwr/steer/FlowFollow.html

// Using this variable to decide whether to draw all the stuff


import Cocoa
import Tin

class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Flowfield"
        
        makeView(width: 800.0, height: 400.0)
        scene = Scene()
        present(scene: scene)
        
        scene.view?.showStats = false
    }
    
    
    override func mouseUp(with event: NSEvent) {
        scene.mousePressed()
    }

}


class Scene: TScene {
    
    var debug = true
    var flowField: FlowField!
    var vehicles: [Vehicle] = []

    
    override func setup() {
        flowField = FlowField(r: 20)
        // Make a whole bunch of vehicles with random maxspeed and maxforce values
        for _ in 0 ..< 120 {
            let p = TVector2(x: random(max: tin.width), y: random(max: tin.height))
            let ms = random(min: 2.0, max: 5.0)
            let mf = random(min: 0.1, max: 0.5)
            let v = Vehicle(position: p, speed: ms, force: mf)
            vehicles.append(v)
        }
    }
    
    
    override func update() {
        background(gray: 1.0)
        
        if debug {
            flowField.display()
        }
        
        for v in vehicles {
            v.follow(flow: flowField)
            v.run()
        }
    
    }
    
    
    func mousePressed() {
        flowField.setup()
    }
}

