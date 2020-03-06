//
//  MainMenu.swift
//  Furry'sAerialFury
//
//  Created by graphic on 2020-03-06.
//  Copyright © 2020 graphic. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MenuScene: SKScene, SKPhysicsContactDelegate  {
    
    //TODO: - Use this to create a menu scene
    
    //TODO: - Add a main menu and play button
    
    
    var background = SKSpriteNode()
    var ground = SKSpriteNode()
    var flappyNode = SKSpriteNode()
    var birdNode = SKSpriteNode()
    var Bird = SKSpriteNode()
    var TextureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    
    var scoreButton = SKSpriteNode()
    var startButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        
        background = SKSpriteNode(imageNamed: "background.png")
        background.setScale(3)
        background.position = CGPoint(x: self.frame.width/2, y: background.frame.height/1.5)
              self.addChild(background)
       
        
        
        
        startButton = SKSpriteNode(imageNamed: "Start.png")
        scoreButton = SKSpriteNode(imageNamed: "Score.png")
        
        startButton.position = CGPoint(x: self.frame.width/2 - 100, y: self.frame.height/2 - 250)
        startButton.setScale(3)
        startButton.zPosition = 6
        self.addChild(startButton)
        
        scoreButton.position = CGPoint(x: self.frame.width/2 + 100, y: self.frame.height/2 - 250)
        scoreButton.setScale(3)
        scoreButton.zPosition = 6
        self.addChild(scoreButton)
        
        
        
    }
    
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            //TODO: - Create a transition
            
            let location = touch.location(in: self)
            
            
            
            if(startButton.contains(location)){
                
                scene?.view?.presentScene(GameScene(size: self.frame.size))
            }
        }
    }
}





