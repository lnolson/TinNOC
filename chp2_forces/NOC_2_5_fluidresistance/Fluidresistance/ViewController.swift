//
//  ViewController.swift
//

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Example 2-4: Forces No Friction


import Cocoa
import Tin


class ViewController: TController {

    let scene = Scene()
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        view.window?.title = "Fluid Resistance"
        
        makeView(width: 640.0, height: 360.0)
        
        present(scene: scene)
        
        tview.showStats = false
    }
    
    
    override func mouseUp(with event: NSEvent) {
        scene.reset()
    }
    
    
}


class Scene: TScene {
    

    var movers: [Mover] = []
    
    var liquid = Liquid()
    
    
    override func setup() {
        reset()
        
        liquid = Liquid(x: 0.0, y: 0.0, w: tin.width, h: tin.height / 2.0, c: 0.1)
    }
    
    
    override func update() {
        
        background(gray: 1.0)
        
        liquid.display()
        
        for mover in movers {
            
            if liquid.contains(m: mover) {
                let dragForce = liquid.drag(m: mover)
                mover.applyForce(force: dragForce)
            }
            
            let gravity = TVector2(x: 0.0, y: -0.1 * mover.mass)
            mover.applyForce(force: gravity)
            
            mover.update()
            mover.checkEdges()
            mover.display()
        }
        
    }
    
    
    func reset() {
        movers.removeAll()
        let y = tin.height
        for i in 1...5 {
            movers.append( Mover(mass: random(min: 0.5, max: 3.0), x: 40.0 + Double(i) * 70.0, y: y) )
        }
    }
}

