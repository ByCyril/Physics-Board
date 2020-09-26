//
//  GameScene.swift
//  PhysicsBoard
//
//  Created by Cyril Garcia on 9/26/20.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    var nodes = [SKSpriteNode]()
    let motionManager = CMMotionManager()
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .black
        anchorPoint = CGPoint(x: 0, y: 0)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
        motionManager.startAccelerometerUpdates()
    }
  
    func createNode(at position: CGPoint) {
        let i = Int.random(in: 1...85)

//        create the node
        let node = SKSpriteNode(imageNamed: "emoji\(i)")
        node.size = CGSize(width: 50, height: 50)
        node.position = position
        
//        add the physics body
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.restitution = 0.5
        node.physicsBody?.friction = 0.2
        node.physicsBody?.allowsRotation = true
        node.physicsBody?.isDynamic = true
        scene?.addChild(node)
        nodes.append(node)
    }
    
    func clearScene() {
        for node in nodes {
            let scale = SKAction.scale(by: 0, duration: 1.25)
            let remove = SKAction.run {
                node.removeFromParent()
            }
            let rotationAngle: CGFloat = 2 * CGFloat.pi
            
            let rotate = SKAction.repeatForever(SKAction.rotate(byAngle: rotationAngle, duration: 0.35))
            let sequence = SKAction.sequence([scale, SKAction.wait(forDuration: 0.25), remove])
            node.run(rotate)
            node.run(sequence)
        }
        
        nodes.removeAll()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        createNode(at: location)
    }
    
    override func update(_ currentTime: TimeInterval) {
//        Where the magic happens
        
        guard let acc = motionManager.accelerometerData?.acceleration else { return }
        
        let padding: Double = 75
        physicsWorld.gravity = CGVector(dx: acc.x * padding, dy: acc.y * padding)
        
    }
}
