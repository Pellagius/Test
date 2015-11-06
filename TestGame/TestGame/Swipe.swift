//
//  Swipe.swift
//  TestGame
//
//  Created by Media Production on 6/11/2015.
//  Copyright © 2015 Media Production. All rights reserved.
//

import UIKit
import SpriteKit

class Swipe: SKNode {
    
    var emitter : SKEmitterNode?
    var emitterLifeTime = CGFloat()
    var emitterLifeTimeRange = CGFloat()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(position:CGPoint, target:SKNode) {
        super.init()
        
        self.name = "swipe"
        self.position = position
        
        
        emitter = SKEmitterNode(fileNamed: "touchEmitter.sks")!
        emitter!.targetNode = target
        emitter!.zPosition = 0
        
        emitterLifeTime = emitter!.particleLifetime
        emitterLifeTimeRange = emitter!.particleLifetimeRange

        
        let tip : SKSpriteNode = SKSpriteNode(color: UIColor.clearColor(), size: CGSizeMake(25, 25))
        tip.zRotation = 0.785398163
        tip.zPosition = self.zPosition + 1
        self.addChild(tip)
        emitter!.zPosition = tip.zPosition + 1
        tip.addChild(emitter!)
        self.zRotation = 0
        self.setScale(0.6)
    }
}

