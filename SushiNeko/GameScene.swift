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

enum GameState {
    case Title, Ready, Playing, GameOver
}

class GameScene: SKScene {
    var sushiBasePiece: SushiPiece!
    var character: Character!
    var sushiTower: [SushiPiece] = []
    
    var gameState: GameState = .Title
    
    var playButton: MSButtonNode!
    
    
    override func didMoveToView(view: SKView) {
        sushiBasePiece = self.childNodeWithName("sushiBasePiece") as! SushiPiece
        sushiBasePiece.connectChopsticks()
        
        character = self.childNodeWithName("character") as! Character
        
        playButton = self.childNodeWithName("playButton") as! MSButtonNode
        
        playButton.selectedHandler = {
            self.gameState = .Ready
        }
        
        addSushiPiece(.None)
        addSushiPiece(.None)
        addRandomPieces(10)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(gameState == .Title || gameState == .GameOver) { return }
        
        if(gameState == .Ready) {
            gameState = .Playing
        }

        for touch in touches {
            let location = touch.locationInNode(self)
            
            if(location.x > (self.size.width / 2)) {
                character.side = .Right
            }
            else {
                character.side = .Left
            }
            
            let firstPiece = sushiTower.first as SushiPiece!
            
            if(character.side == firstPiece.side) {
                for node:SushiPiece in sushiTower {
                    node.runAction(SKAction.moveBy(CGVector(dx: 0, dy: -55), duration: 0.10))
                }
                
                gameOver()
                return
            }
            
            sushiTower.removeFirst()
            firstPiece.flip(character.side)
            
            addRandomPieces(1)
            
            for node:SushiPiece in sushiTower {
                /* Animate the sushi piece to go downwards */
                let shiftDownwards = SKAction.moveBy(CGVector(dx: 0, dy: -55), duration: 0.10)
                node.runAction(shiftDownwards)
                
                /* We don't want sushi pieces to block UI elements */
                node.zPosition -= 1
            }
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {

    }
    
    /* Uses the addSushiPiece method to generate a total number of random sushi pieces.
       There is a 45% EACH of generating a left or right sushi piece, and a 10% of generating
       a sushi piece with no branch. Code also prevents an impossible scenario from occuring (see 
       code for details) */
    func addRandomPieces(total: Int) {
        for _ in 1...total {
            let lastPiece = sushiTower.last as SushiPiece!
            
            if lastPiece.side != .None {
                /* If a sushi piece with a left branch is immediately followed by a sushi piece
                   with a right branch, then the player is faced with an impossible situation. */
                addSushiPiece(.None)
            }
            else {
                let rand = CGFloat.random(min: 0, max: 1.0)
                
                if(rand < 0.45) {
                    addSushiPiece(.Left)
                }
                else if(rand < 0.9) {
                    addSushiPiece(.Right)
                }
                else {
                    addSushiPiece(.None)
                }
            }
        }
    }
    
    
    func gameOver() {
        gameState = .GameOver
        
        for node:SushiPiece in sushiTower {
            node.runAction(SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 1.0, duration: 0.50))
        }
        
        character.runAction(SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: 1.0, duration: 0.50))
        
        playButton.selectedHandler = {
            let skView = self.view as SKView!
            let scene = GameScene(fileNamed: "GameScene") as GameScene!
            scene.scaleMode = .AspectFill
            skView.presentScene(scene)
        }
    }
    
    /* Adds sushi pieces to both the screen and the internal array
       storing all the pieces in the sushi tower */
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
