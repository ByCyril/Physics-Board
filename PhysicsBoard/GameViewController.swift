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
        
        let scene = GameScene(size: view.frame.size)
        
        let skView = self.view as! SKView
        skView.ignoresSiblingOrder = true
        
        scene.scaleMode = .aspectFit
        skView.presentScene(scene)
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
