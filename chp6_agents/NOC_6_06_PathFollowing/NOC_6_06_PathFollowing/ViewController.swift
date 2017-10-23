//
//  ViewController.swift
//  NOC_6_06
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Path Following
// Via Reynolds: // http://www.red3d.com/cwr/steer/PathFollow.html



import Cocoa
import Tin

class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Path Following"
        
        makeView(width: 1280.0, height: 720.0)
        scene = Scene()
        present(scene: scene)
        
        scene.view?.showStats = false
    }
    
    
    override func mouseUp(with event: NSEvent) {
        scene.mousePressed()
    }

}


class Scene: TScene {
    
    var path: Path!
    
    var car1: Vehicle!
    var car2: Vehicle!
    
    static var debugDrawing = true
    
    override func setup() {
        newPath()
        
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
    
    
    func newPath() {
        // A path is a series of connected points
        // A more sophisticated path might be a curve
        path = Path()
        path.addPoint(x: -20.0, y: tin.midY)
        let x1 = random(min: 0, max: tin.midX)
        let y1 = random(min: 0, max: tin.height)
        path.addPoint(x: x1, y: y1)
        let x2 = random(min: tin.midX, max: tin.width)
        let y2 = random(min: 0, max: tin.height)
        path.addPoint(x: x2, y: y2)
        path.addPoint(x: tin.width+20, y: tin.midY)
    }
    
    
    func mousePressed() {
        newPath()
    }
    
    
    func keyPressed() {
        Scene.debugDrawing = !Scene.debugDrawing
    }
    
    
    static func debug() -> Bool {
        return debugDrawing
    }
}

