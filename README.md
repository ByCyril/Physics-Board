# Physics-Board
#### Developed and Designed by Cyril

## Tutorial
### Setup
Create a GameScene Xcode Project and download the emoji files I have or you can use your own image for your nodes. 

### Step 1
Import CoreMotion and create a `CMMotionManager` property. This will allow us to use the accelerometer to create the physics effect.
Also create an array of `[SKSpriteNote]` which will allow us to hold current nodes in our screen for later use.

### Step 2
Setup your physics world in your SKScene. 
```
physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
```

Then after that, start the accelerometer updates

```
motionManager.startAccelerometerUpdates()
```

### Step 3
Create a function that will be used within the `touchesMoved(:_)` method
```
    func createNode(at position: CGPoint) {
//        This is for the emoji names.
//        You may not need it if you are using
//        a single image
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
        
//        add the newly created node to our nodes array.
        nodes.append(node)
    }
```
Then call this method in your touches moved by passing in the location of the touch.

### Step 4
We can create our `clearScene()` method because, why not :)
 ```
 func clearScene() {
        for node in nodes {
//            create the scaling affect
            let scale = SKAction.scale(by: 0, duration: 1.25)
            
//            remove the node from the parent
            let remove = SKAction.run {
                node.removeFromParent()
            }
            
//            create the rotation affect
            let rotationAngle: CGFloat = 2 * CGFloat.pi
            let rotate = SKAction.repeatForever(SKAction.rotate(byAngle: rotationAngle, duration: 0.35))
            
//            create a sequence where we run the scaling and removing affect
            let sequence = SKAction.sequence([scale, SKAction.wait(forDuration: 0.25), remove])
            
//            rotate the nodes and run it with the scaling and removing affect/
            node.run(rotate)
            node.run(sequence)
        }
        
//        then remove all references of the nodes
        nodes.removeAll()
    }
 ```
 
 ### Step 5 - Where the magic happens
 To create the physics affect, we want to use our `motionManager` to access the accelerometer data and use that to change the physics world gravity.
 
 We do this inside our `update(_:)` method
 ```
 guard let acc = motionManager.accelerometerData?.acceleration else { return }
        
let harshness: Double = 75
physicsWorld.gravity = CGVector(dx: acc.x * harshness, dy: acc.y * harshness)
 ```
 
 ### Step 6
 To call the `clearScene()` method, I did this inside the `GameViewController` class since the `motion` method for some reason does not trigger inside the scene
 ```
   override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {

        guard motion == .motionShake else { return }
        guard let skView = view as? SKView else { return }
        guard let scene = skView.scene as? GameScene else { return }
        scene.clearScene()
        
    }
 ```
 
 That's it, enjoy!
