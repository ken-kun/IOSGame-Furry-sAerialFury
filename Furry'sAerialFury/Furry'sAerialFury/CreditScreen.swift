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
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.init(red: 0, green: 0, blue: 0, alpha: 0)
       let winner = SKLabelNode(fontNamed: "Chalkduster")
        winner.text = "Credit!"
        winner.fontSize = 65
        winner.position = CGPoint(x: frame.midX, y: frame.midY)
           
        addChild(winner)
    
    }
  
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scene?.view?.presentScene(PauseScene(size: self.frame.size))
    }
}
