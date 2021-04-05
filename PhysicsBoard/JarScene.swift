//
//  JarScene.swift
//  PhysicsBoard
//
//  Created by Cyril Garcia on 4/5/21.
//

import SpriteKit
import GameplayKit
import CoreMotion

class JarScene: SKScene {
    
    private var tipItems: [SKSpriteNode] = []
    private let motionManager: CMMotionManager = CMMotionManager()
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .black
        anchorPoint = CGPoint(x: 0, y: 0)
        
//        I'm assuming the tip jar is a perfect square
        physicsBody = SKPhysicsBody(circleOfRadius: frame.height / 2)
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        
        motionManager.startAccelerometerUpdates()
    }
    
//    Seems like you have different tip types so you could pass
//    some kind of enum in this function
    func addTip() {

//        create the tip item
        let tip = SKSpriteNode(imageNamed: "image_type")
        tip.size = CGSize(width: 30, height: 30)
        
//        We will add the tip item from the top of the tip jar
        tip.position = CGPoint(x: 0, y: frame.width / 2)
        
        tip.physicsBody = SKPhysicsBody(circleOfRadius: tip.size.width / 2)
        tip.physicsBody?.restitution = 0.5
        tip.physicsBody?.friction = 0.2
        tip.physicsBody?.allowsRotation = true
        tip.physicsBody?.isDynamic = true
        scene?.addChild(tip)
        tipItems.append(tip)
        
    }
    
    func clearTipJar() {
        
        tipItems.forEach { (node) in
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
        
        tipItems.removeAll()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        guard let acc = motionManager.accelerometerData?.acceleration else { return }
        
        let harshness: Double = 50
        physicsWorld.gravity = CGVector(dx: acc.x * harshness, dy: acc.y * harshness)
        
    }
    
}
