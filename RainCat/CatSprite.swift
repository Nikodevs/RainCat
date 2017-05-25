//
//  CatSprite.swift
//  RainCat
//
//  Created by period2 on 5/25/17.
//  Copyright © 2017 Thirteen23. All rights reserved.
//

import Foundation
import SpriteKit

public class CatSprite : SKSpriteNode {
    public static func newInstance() -> CatSprite {
        let catSprite = CatSprite(imageNamed: "cat_one")
        
        catSprite.zPosition = 5
        catSprite.physicsBody = SKPhysicsBody(circleOfRadius: catSprite.size.width / 2)
        
        return catSprite
    }
    
    public func update(deltaTime : TimeInterval) {
        
    }
}
