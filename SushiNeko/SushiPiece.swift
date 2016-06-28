//
//  SushiPiece.swift
//  SushiNeko
//
//  Created by Alan Gao on 6/28/16.
//  Copyright © 2016 Alan Gao. All rights reserved.
//

import SpriteKit

class SushiPiece: SKSpriteNode {
    var rightChopstick: SKSpriteNode!
    var leftChopstick: SKSpriteNode!
    
    /* The type of sushi */
    var side: Side = .None {
        
        didSet {
            switch side {
            case .Left:
                leftChopstick.hidden = false
            case .Right:
                rightChopstick.hidden = false
            case .None:
                rightChopstick.hidden = true
                leftChopstick.hidden = true
            }
        }
        
    }
    
    func connectChopsticks() {
        rightChopstick = childNodeWithName("rightChopstick") as! SKSpriteNode
        leftChopstick = childNodeWithName("leftChopstick") as! SKSpriteNode
        side = .None
    }
    
    func flip(side: Side) {
        var actionName: String = ""
        
        if side == .Left {
            actionName = "SushiFlipRight"
        }
        else {
            actionName = "SushiFlipLeft"
        }
        
        let flip = SKAction(named: actionName)!
        let remove = SKAction.removeFromParent()
        
        let sequence = SKAction.sequence([flip, remove])
        runAction(sequence)
    }
    
    /* Required initializers */
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
