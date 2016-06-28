//
//  GameScene.swift
//  SushiNeko
//
//  Created by Alan Gao on 6/28/16.
//  Copyright (c) 2016 Alan Gao. All rights reserved.
//

import SpriteKit

/* Tracking enum that shows which side the chopstick is on */
enum Side {
    case Left, Right, None
}

class GameScene: SKScene {
    var sushiBasePiece: SushiPiece!
    var character: Character!
    
    var sushiTower: [SushiPiece] = []
    
    
    override func didMoveToView(view: SKView) {
        sushiBasePiece = self.childNodeWithName("sushiBasePiece") as! SushiPiece
        sushiBasePiece.connectChopsticks()
        
        character = self.childNodeWithName("character") as! Character
        
        
        self.addSushiPiece(.None)
        self.addSushiPiece(.Right)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

    }
   
    override func update(currentTime: CFTimeInterval) {

    }
    
//    func addRandomPieces(total: Int) {
//        while(total > 0) {
//            
//            
//        }
//    }
    
    func addSushiPiece(side: Side) {
        let newPiece = sushiBasePiece.copy() as! SushiPiece
        newPiece.connectChopsticks()
        
        let lastPiece = sushiTower.last
        
        /* Based on the last piece, we find the new Piece's 
           position and zPosition (zPosition is 1 greater
           than zPosition on bottom) */
        let lastPosition = lastPiece?.position ?? sushiBasePiece.position
        newPiece.position = lastPosition + CGPoint(x: 0, y: 55)
        
        let lastZPosition = lastPiece?.zPosition ?? sushiBasePiece.zPosition
        newPiece.zPosition = lastZPosition + 1
        
        newPiece.side = side
        
        addChild(newPiece)
        
        sushiTower.append(newPiece)
    }
}
