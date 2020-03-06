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
    
    
    var title1 = SKSpriteNode()
    var title2 = SKSpriteNode()
    var title3 = SKSpriteNode()
    var title4 = SKSpriteNode()
    var title5 = SKSpriteNode()
    
    var tittle3 = SKSpriteNode()
    var scoreButton = SKSpriteNode()
    var startButton = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        
        background = SKSpriteNode(imageNamed: "forest.png")
        background.setScale(0.9)
        background.position = CGPoint(x: self.frame.width/2, y: background.frame.height/1.5)
              self.addChild(background)
       
        
        title1 = SKSpriteNode(imageNamed: "Furry.png")
        title1.setScale(0.9)
        title1.position = CGPoint(x: self.frame.width/2 - 100, y: self.frame.height/2 + 300 )
        self.addChild(title1)
        
        title2 = SKSpriteNode(imageNamed: ",.png")
        title2.setScale(0.9)
        title2.position = CGPoint(x: self.frame.width/2 - 10, y: self.frame.height/2 + 330 )
        self.addChild(title2)
        
        title3 = SKSpriteNode(imageNamed: "s.png")
        title3.setScale(0.9)
        title3.zPosition = 2
        title3.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 + 300 )
        self.addChild(title3)
        
        title4 = SKSpriteNode(imageNamed: "Aerial.png")
        title4.setScale(0.9)
        title4.position = CGPoint(x: self.frame.width/2 + 100, y: self.frame.height/2 + 300 )
        self.addChild(title4)
        
        title5 = SKSpriteNode(imageNamed: "Fury.png")
        title5.setScale(0.9)
        title5.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 + 200 )
        self.addChild(title5)
        
        
        
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





