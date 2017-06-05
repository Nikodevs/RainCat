//
//  BackgroundNodes.swift
//  RainCat
//
//  Created by Marc Vandehey on 8/29/16.
//  Copyright © 2017 Thirteen23. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    private var lastUpdateTime : TimeInterval = 0
    private var currentRainDropSpawnTime : TimeInterval = 0
    private var rainDropSpawnRate : TimeInterval = 6
    let raindropTexture = SKTexture(imageNamed: "rain_drop")
    private let umbrellaNode = UmbrellaSprite.newInstance()
    private var catNode : CatSprite!
    private let backgroundNode = BackgroundNode()
    
    
  override func sceneDidLoad() {
    self.lastUpdateTime = 0
    backgroundNode.setup(size: size)
    var worldFrame = frame
    worldFrame.origin.x -= 100
    worldFrame.origin.y -= 100
    worldFrame.size.height += 200
    worldFrame.size.width += 200
    
    self.physicsWorld.contactDelegate = self
    
    self.physicsBody = SKPhysicsBody(edgeLoopFrom: worldFrame)
    self.physicsBody?.categoryBitMask = WorldCategory
    addChild(backgroundNode)
    
    umbrellaNode.updatePosition(point: CGPoint(x: frame.midX, y: frame.midY))
    umbrellaNode.zPosition = 4
    addChild(umbrellaNode)
    
    spawnCat()
  }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
        if let point = touchPoint {
            umbrellaNode.setDestination(destination: point)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
        if let point = touchPoint {
            umbrellaNode.setDestination(destination: point)
        }
    }
    
  override func update(_ currentTime: TimeInterval) {
    spawnRaindrop()
    let dt = currentTime - self.lastUpdateTime
    // Called before each frame is rendered

    // Initialize _lastUpdateTime if it has not already been initialized
    if (self.lastUpdateTime == 0) {
      self.lastUpdateTime = currentTime
    }
        // Update the spawn timer
        currentRainDropSpawnTime += dt
        
        if currentRainDropSpawnTime > rainDropSpawnRate {
            currentRainDropSpawnTime = 0
            spawnRaindrop()
        }
        umbrellaNode.update(deltaTime: dt)

    // Calculate time since last update
    

    // Update the Spawn Timer
    currentRainDropSpawnTime += dt

    self.lastUpdateTime = currentTime
    }
    
    func spawnCat() {
        if let currentCat = catNode, children.contains(currentCat) {
            catNode.removeFromParent()
            catNode.removeAllActions()
            catNode.physicsBody = nil
        }
        
        catNode = CatSprite.newInstance()
        catNode.position = CGPoint(x: umbrellaNode.position.x, y: umbrellaNode.position.y - 30)
        
        addChild(catNode)
    }

    private func spawnRaindrop() {
        let raindrop = SKSpriteNode(texture: raindropTexture)
        raindrop.physicsBody = SKPhysicsBody(texture: raindropTexture, size: raindrop.size)
        let xPosition =
            CGFloat(arc4random()).truncatingRemainder(dividingBy: size.width)
        let yPosition = size.height + raindrop.size.height
        
        raindrop.position = CGPoint(x: xPosition, y: yPosition)
        
        raindrop.physicsBody?.categoryBitMask = RainDropCategory
        raindrop.physicsBody?.contactTestBitMask = FloorCategory | WorldCategory
        raindrop.zPosition = 2
        addChild(raindrop)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
    if (contact.bodyA.categoryBitMask == RainDropCategory) {
    contact.bodyA.node?.physicsBody?.collisionBitMask = 0
    } else if (contact.bodyB.categoryBitMask == RainDropCategory) {
    contact.bodyB.node?.physicsBody?.collisionBitMask = 0
    }
    
    if contact.bodyA.categoryBitMask == CatCategory || contact.bodyB.categoryBitMask == CatCategory {
    handleCatCollision(contact: contact)
    
    return
    }
    
    if contact.bodyA.categoryBitMask == WorldCategory {
    contact.bodyB.node?.removeFromParent()
    contact.bodyB.node?.physicsBody = nil
    contact.bodyB.node?.removeAllActions()
    } else if contact.bodyB.categoryBitMask == WorldCategory {
    contact.bodyA.node?.removeFromParent()
    contact.bodyA.node?.physicsBody = nil
    contact.bodyA.node?.removeAllActions()
    }
    }
    
    func handleCatCollision(contact: SKPhysicsContact) {
        var otherBody : SKPhysicsBody
        
        if contact.bodyA.categoryBitMask == CatCategory {
            otherBody = contact.bodyB
        } else {
            otherBody = contact.bodyA
        }
        
        switch otherBody.categoryBitMask {
        case RainDropCategory:
            print("rain hit the cat")
        case WorldCategory:
            spawnCat()
        default:
            print("Something hit the cat")
        }
    }
    
}
