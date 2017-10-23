//
//  ViewController.swift
//  NOC_6_05
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Path Following
// Path is a just a straight line in this example
// Via Reynolds: // http://www.red3d.com/cwr/steer/PathFollow.html



import Cocoa
import Tin

class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Path Following Simple"
        
        makeView(width: 1280.0, height: 720.0)
        scene = Scene()
        present(scene: scene)
        
        scene.view?.showStats = false
    }

}


class Scene: TScene {
    
    var path: Path!
    
    var car1: Vehicle!
    var car2: Vehicle!
    
    override func setup() {
        path = Path()
        
        // Each vehicle has different maxspeed and maxforce for demo purposes
        
        car1 = Vehicle(position: TVector2(x: 0, y: tin.midY), ms: 2.0, mf: 0.02)
        car2 = Vehicle(position: TVector2(x: 0, y: tin.midY), ms: 3.0, mf: 0.05)
    }
    
    
    override func update() {
        background(gray: 1.0)
        
        path.display()
        
        car1.follow(p: path)
        car2.follow(p: path)
        
        car1.run()
        car2.run()
        
        car1.borders(p: path)
        car2.borders(p: path)
        
    }
    
    
    static func debug() -> Bool {
        return true
    }
}

