//
//  ViewController.swift
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import Cocoa
import Tin


class ViewController: TController {

    var scene: Scene!
    
    override func viewWillAppear() {
        view.window?.title = "Cannon"
        makeView(width: 640.0, height: 360.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    override func keyDown(with event: NSEvent) {
        interpretKeyEvents([event])
    }
    
    override func moveRight(_ sender: Any?) {
        scene.down()
    }
    
    override func moveLeft(_ sender: Any?) {
        scene.up()
    }
    
    override func insertText(_ insertString: Any) {
        let str = insertString as! String
        if str == " " {
            scene.fire()
        }
    }

}


class Scene: TScene {
    
    // All of this stuff should go into a Cannon class
    var angle = Double.pi / 4.0
    var position = TVector2(x: 50.0, y: 60.0)
    var shot = false
    
    var ball: CannonBall!
    
    override func setup() {
        ball = CannonBall(x: position.x, y: position.y)
    }
    
    override func update() {
        background(gray: 1.0)
        
        pushState()
        translate(dx: position.x, dy: position.y)
        rotate(by: angle)
        rect(x: 0.0, y: -5.0, width: 50.0, height: 10.0)
        popState()
        
        if shot {
            let gravity = TVector2(x: 0.0, y: -0.2)
            ball.applyForce(force: gravity)
            ball.update()
        }
        ball.display()
        
        if ball.position.y < 0.0 {
            ball = CannonBall(x: position.x, y: position.y)
            shot = false
        }
    }
    
    func down() {
        angle -= 0.1
    }
    
    
    func up() {
        angle += 0.1
    }
    
    
    func fire() {
        shot = true
        var force = TVector2(angle: angle)
        force = force * 10.0
        ball.applyForce(force: force)
    }
}

