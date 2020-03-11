//
//  OptionScene.swift
//  Furry'sAerialFury
//
//  Created by Run Wu on 2020-03-06.
//  Copyright © 2020 graphic. All rights reserved.
//

import SpriteKit
import GameplayKit

class OptionScene: SKScene {
    
    var background = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        background = SKSpriteNode(imageNamed: "forest")
        background.setScale(0.9)
        background.position =  CGPoint(x: self.frame.width/2 - 400, y: background.frame.height/1.5)
        addChild(background)
       let winner = SKLabelNode(fontNamed: "Chalkduster")
        winner.text = "Option!"
        winner.fontSize = 65
        winner.position = CGPoint(x: frame.midX, y: frame.midY + 300)
           
        addChild(winner)
    
    }
  
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scene?.view?.presentScene(CreditScene(size: self.frame.size))
    }
}
