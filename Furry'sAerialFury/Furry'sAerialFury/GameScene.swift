//
//  GameScene.swift
//  Furry'sAerialFury
//
//  Created by graphic on 2020-03-06.
//  Copyright © 2020 graphic. All rights reserved.
//

import SpriteKit
import GameplayKit
let pauseButton = UIButton.init(type:.system)
let attackButton = UIButton.init(type:.system)
let specialButton = UIButton.init(type:.system)
let DPAD = UIButton.init(type:.system)
class GameScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.init(red: 0, green: 0, blue: 0, alpha: 0)
       let mainGame = SKLabelNode(fontNamed: "Chalkduster")
        mainGame.text = "Main Game!"
        mainGame.fontSize = 45
        mainGame.position = CGPoint(x: frame.midX, y: frame.midY+300)
        addChild(mainGame)
        
        let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: "
        scoreLabel.fontSize = 30
        scoreLabel.position = CGPoint(x: frame.midX+80, y: frame.midY+350)
        addChild(scoreLabel)
        
        pauseButton.frame = CGRect(x: 20.0, y: 50.0, width: 70.0, height: 50.0)
        pauseButton.setTitle("Pause", for: .normal)
        pauseButton.layer.borderWidth = 5.0
        pauseButton.layer.borderColor = UIColor.white.cgColor
        pauseButton.backgroundColor = UIColor.black
        pauseButton.titleLabel?.textColor = UIColor.white
        pauseButton.tintColor = UIColor.white
        pauseButton.layer.cornerRadius = 15.0
        pauseButton.addTarget(self, action: #selector(pauseButtonAction(_:)), for: .touchUpInside)
        self.view?.addSubview(pauseButton)
        
        attackButton.frame = CGRect(x: 270.0, y: 700.0, width: 70.0, height: 70.0)
        attackButton.setTitle("A", for: .normal)
        attackButton.layer.borderWidth = 5.0
        attackButton.layer.borderColor = UIColor.white.cgColor
        attackButton.backgroundColor = UIColor.black
        attackButton.titleLabel?.textColor = UIColor.white
        attackButton.tintColor = UIColor.white
        attackButton.layer.cornerRadius = attackButton.frame.size.width / 2
        attackButton.layer.masksToBounds = true
        attackButton.addTarget(self, action: #selector(attackButtonAction(_:)), for: .touchUpInside)
        self.view?.addSubview(attackButton)
        
        specialButton.frame = CGRect(x: 320.0, y: 650.0, width: 50.0, height: 50.0)
        specialButton.setTitle("S", for: .normal)
        specialButton.layer.borderWidth = 5.0
        specialButton.layer.borderColor = UIColor.white.cgColor
        specialButton.backgroundColor = UIColor.black
        specialButton.titleLabel?.textColor = UIColor.white
        specialButton.tintColor = UIColor.white
        specialButton.layer.cornerRadius = specialButton.frame.size.width / 2
        specialButton.layer.masksToBounds = true
        specialButton.addTarget(self, action: #selector(specialButtonAction(_:)), for: .touchUpInside)
        self.view?.addSubview(specialButton)
        
        DPAD.frame = CGRect(x: 50.0, y: 680.0, width: 100.0, height: 100.0)
        DPAD.setTitle("D-PAD", for: .normal)
        DPAD.layer.borderWidth = 5.0
        DPAD.layer.borderColor = UIColor.white.cgColor
        DPAD.backgroundColor = UIColor.black
        DPAD.titleLabel?.textColor = UIColor.white
        DPAD.tintColor = UIColor.white
        DPAD.layer.cornerRadius = DPAD.frame.size.width / 2
        DPAD.layer.masksToBounds = true
        DPAD.addTarget(self, action: #selector(specialButtonAction(_:)), for: .touchUpInside)
        self.view?.addSubview(DPAD)
    }
    internal override func willMove(from view: SKView) {
        pauseButton.removeFromSuperview()
        attackButton.removeFromSuperview()
        specialButton.removeFromSuperview()
        DPAD.removeFromSuperview()
    }
    @objc func pauseButtonAction(_ : UIButton){
       
   }
    @objc func attackButtonAction(_ : UIButton){
        
    }
      @objc func specialButtonAction(_ : UIButton){
          
      }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scene?.view?.presentScene(OptionScene(size: self.frame.size))
    }
}
