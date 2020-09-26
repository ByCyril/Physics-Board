//
//  GameViewController.swift
//  PhysicsBoard
//
//  Created by Cyril Garcia on 9/26/20.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .fill
//                scene.size = self.view.frame.size
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {

        guard motion == .motionShake else { return }
        guard let skView = view as? SKView else { return }
        guard let scene = skView.scene as? GameScene else { return }
        scene.clearScene()
        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
