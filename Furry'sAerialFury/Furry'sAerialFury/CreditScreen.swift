//
//  CreditScreen.swift
//  Furry'sAerialFury
//
//  Created by Run Wu on 2020-03-06.
//  Copyright © 2020 graphic. All rights reserved.
//

import SpriteKit
import GameplayKit

class CreditScene: SKScene {
    
    
    var background = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        
         background = SKSpriteNode(imageNamed: "forest")
               background.setScale(0.9)
               background.position =  CGPoint(x: self.frame.width/2 + 600, y: background.frame.height/1.5)
               addChild(background)
        
              let winner = SKLabelNode(fontNamed: "Chalkduster")
               winner.text = "Credits!"
               winner.fontSize = 65
               winner.position = CGPoint(x: frame.midX, y: frame.midY + 300)
               addChild(winner)
        
        
        let Label = SKLabelNode(fontNamed: "Chalkduster")
        Label.text = "Developed By:"
        Label.fontSize = 50
        Label.position = CGPoint(x: frame.midX, y: frame.midY + 200)
        addChild(Label)
        
        let name = SKLabelNode(fontNamed: "Chalkduster")
        name.text = "Kevin"
        name.fontSize = 50
        name.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(name)
        
        let name2 = SKLabelNode(fontNamed: "Chalkduster")
        name2.text = "Hercules"
        name2.fontSize = 50
        name2.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(name2)
        
        let name3 = SKLabelNode(fontNamed: "Chalkduster")
        name3.text = "Run Wu"
        name3.fontSize = 50
        name3.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        addChild(name3)
        
        let name4 = SKLabelNode(fontNamed: "Chalkduster")
        name4.text = "Chen"
        name4.fontSize = 50
        name4.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        addChild(name4)
    
    }
  
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scene?.view?.presentScene(PauseScene(size: self.frame.size))
    }
}
