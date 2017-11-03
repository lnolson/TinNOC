//
//  ViewController.swift
//  
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
    var vehicles: [Vehicle] = []
    
    static var debugDrawing = false
    
    override func setup() {
        // Call a function to generate new Path object
        newPath()
        
        // We are now making random vehicles and storing them in an Array
        for _ in 1...120 {
            newVehicle(x: random(max: tin.width), y: random(max: tin.height))
        }
    }
    
    
    func newVehicle(x: Double, y: Double) {
        let maxspeed = random(min: 2.0, max: 4.0)
        let maxforce = 0.3
        let v = Vehicle(position: TVector2(x: x, y: y) , ms: maxspeed, mf: maxforce)
        vehicles.append(v)
    }
    
    
    override func update() {
        background(gray: 1.0)
        
        path.display()
        
        for v in vehicles {
            // Path following and separation are worked on in this function
            v.applyBehaviors(vehicles: vehicles, path: path)
            
            // Call the generic run method (update, borders, display, etc.)
            v.run()
        }

    }
    
    
    func newPath() {
        // A path is a series of connected points
        // A more sophisticated path might be a curve
        path = Path()
        let offset = 60.0
        path.addPoint(x: offset, y: tin.height - offset)
        path.addPoint(x: tin.width - offset, y: tin.height - offset)
        path.addPoint(x: tin.width - offset, y: offset)
        path.addPoint(x: tin.midX, y: offset * 3.0)
        path.addPoint(x: offset, y: offset)
    }
    
    
    func mousePressed() {
        newVehicle(x: tin.mouseX, y: tin.mouseY)
    }
    
    
    func keyPressed() {
        Scene.debugDrawing = !Scene.debugDrawing
    }
    
    
    static func debug() -> Bool {
        return debugDrawing
    }
}

