//
//  ViewController.swift
//  NOC_6_07_Separation
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


// Separation
// Via Reynolds: http://www.red3d.com/cwr/steer/

import Cocoa
import Tin

class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        super.viewWillAppear()
        view.window?.title = "Separation"
        makeView(width: 640.0, height: 360.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        scene.mouseDragged()
    }

}


class Scene: TScene {
    
    var vehicles: [Vehicle] = []
    var font = TFont(fontName: "Helvetica Neue Light", ofSize: 14.0)
    
    override func setup() {
        for _ in 1...100 {
            let x = random(max: tin.width)
            let y = random(max: tin.height)
            let v = Vehicle(x: x, y: y)
            vehicles.append(v)
        }
        font.horizontalAlignment = .left
    }
    
    
    override func update() {
        background(gray: 1.0)
        
        for v in vehicles {
            v.separate(vehicles: vehicles)
            v.update()
            v.borders()
            v.display()
        }
        
        fillColor(gray: 0)
        text(message: "Drag the mouse to generate new vehicles", font: font, x: 10.0, y: 10.0)
    }
    
    
    func mouseDragged() {
        let v = Vehicle(x: tin.mouseX, y: tin.mouseY)
        vehicles.append(v)
    }
}

