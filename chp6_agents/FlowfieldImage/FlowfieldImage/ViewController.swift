//
//  ViewController.swift
//  FlowfieldImage
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Flow Field Following
// Via Reynolds: http://www.red3d.com/cwr/steer/FlowFollow.html




import Cocoa
import Tin

class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Flowfield Image"
        
        makeView(width: 500.0, height: 500.0)
        scene = Scene()
        present(scene: scene)
        
        scene.view?.showStats = false
    }
    
    
    override func mouseUp(with event: NSEvent) {
        scene.mousePressed()
    }
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        scene.mouseDragged()
    }
    
    override var acceptsFirstResponder: Bool { return true }
    
    
    override func keyUp(with event: NSEvent) {
        scene.keyPressed()
    }

}


class Scene: TScene {
    
    var debug = true
    var flowField: FlowField!
    var vehicles: [Vehicle] = []
    var font = TFont(fontName: "Helvetica Neue Condensed Black", ofSize: 16.0)
    var img = TImage(contentsOfFileInBundle: "face.jpg")

    
    override func setup() {
        if let img = img {
            print("loadPixels")
            img.loadPixels()
        }
        flowField = FlowField(r: 16, image: img!)
        // Make a whole bunch of vehicles with random maxspeed and maxforce values
//        for _ in 0 ..< 120 {
//            let p = TVector2(x: random(max: tin.width), y: random(max: tin.height))
//            let ms = random(min: 2.0, max: 5.0)
//            let mf = random(min: 0.1, max: 0.5)
//            let v = Vehicle(position: p, speed: ms, force: mf)
//            vehicles.append(v)
//        }
        
        font.horizontalAlignment = .left
        
    }
    
    
    override func update() {
        background(gray: 1.0)
        if let img = img {
            image(image: img, x: 0, y: 0)
        }
        
        if debug {
            flowField.display()
        }
        
        for v in vehicles {
            v.follow(flow: flowField)
            v.run()
        }
        
        fillColor(gray: 0.0)
        let msg = "Drag mouse to add vehicles."
        text(message: msg, font: font, x: 10.0, y: 10.0)
    }
    
    
    func mousePressed() {
        //flowField.setup()
    }
    
    
    func keyPressed() {
        debug = !debug
    }
    
    
    func mouseDragged() {
        let p = TVector2(x: tin.mouseX, y: tin.mouseY)
        let v = Vehicle(position: p, speed: 3.0, force: 0.3)
        vehicles.append(v)
    }
}

