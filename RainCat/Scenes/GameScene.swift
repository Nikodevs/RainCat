//
//  BackgroundNodes.swift
//  RainCat
//
//  Copyright © 2017 Thirteen23. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

  private var lastUpdateTime : TimeInterval = 0
  private var currentRainDropSpawnTime : TimeInterval = 0
  private var rainDropSpawnRate : TimeInterval = 0.5
  let raindropTexture = SKTexture(imageNamed: "rain_drop")
  private let backgroundNode = BackgroundNode()
    
  override func sceneDidLoad() {
    self.lastUpdateTime = 0
    backgroundNode.setup(size: size)
    addChild(backgroundNode)
  }


  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
spawnRaindrop()
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

  }

  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered

    // Initialize _lastUpdateTime if it has not already been
    if (self.lastUpdateTime == 0) {
      self.lastUpdateTime = currentTime
    }

    // Calculate time since last update
    let dt = currentTime - self.lastUpdateTime

    // Update the Spawn Timer
    currentRainDropSpawnTime += dt


    self.lastUpdateTime = currentTime
  }
    private func spawnRaindrop() {
        let raindrop = SKSpriteNode(texture: raindropTexture)
        raindrop.physicsBody = SKPhysicsBody(texture: raindropTexture, size: raindrop.size)
        raindrop.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        addChild(raindrop)
    }
}
