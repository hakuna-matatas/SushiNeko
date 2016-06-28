//
//  Character.swift
//  SushiNeko
//
//  Created by Alan Gao on 6/28/16.
//  Copyright © 2016 Alan Gao. All rights reserved.
//

import SpriteKit

class Character: SKSpriteNode {
    var side: Side = .Left {
        
        didSet {
            switch side {
            case .Left:
                xScale = 1
                position.x = 70
            case .Right:
                xScale = -1
                position.x = 252
            case .None:
                break;
            }
            
            let punch = SKAction(named: "Punch")
            runAction(punch!)
        }
    }
    
    
    /* Required Initializers */
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
