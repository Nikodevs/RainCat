//
//  BackgroundNodes.swift
//  RainCat
//
//  Created by Nick Kowalczyk on 5/17/17.
//  Copyright © 2017 Thirteen23. All rights reserved.
//

import Foundation
import SpriteKit

public class BackgroundNode : SKNode {
    
    public func setup(size : CGSize) {
        let yPos : CGFloat = size.height * 0.10
        let startPoint = CGPoint(x: 0, y: yPos)
        let endPoint = CGPoint(x: size.width, y: yPos)
        physicsBody = SKPhysicsBody(edgeFrom: startPoint, to: endPoint)
        physicsBody?.restitution = 0.3
    }
}
