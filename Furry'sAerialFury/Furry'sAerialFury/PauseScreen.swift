//
//  PauseScreen.swift
//  Furry'sAerialFury
//
//  Created by Run Wu on 2020-03-06.
//  Copyright © 2020 graphic. All rights reserved.
//

import SpriteKit
import GameplayKit
let restartButton = UIButton.init(type:.system)
let resumeButton = UIButton.init(type:.system)
let backToMainButton = UIButton.init(type:.system)
class PauseScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.init(red: 0, green: 0, blue: 0, alpha: 0)
       let pause = SKLabelNode(fontNamed: "Chalkduster")
        pause.text = "Pause!"
        pause.fontSize = 65
        pause.position = CGPoint(x: frame.midX, y: frame.midY+300)
        addChild(pause)
        
       
        restartButton.frame = CGRect(x: 110.0, y: 300.0, width: 200.0, height: 52.0)
        restartButton.setTitle("Resume", for: .normal)
        restartButton.layer.borderWidth = 5.0
        restartButton.layer.borderColor = UIColor.white.cgColor
        restartButton.backgroundColor = UIColor.black
        restartButton.titleLabel?.textColor = UIColor.white
        restartButton.tintColor = UIColor.white
        restartButton.layer.cornerRadius = 15.0
        restartButton.addTarget(self, action: #selector(restartButtonAction(_:)), for: .touchUpInside)
        self.view?.addSubview(restartButton)
     
         resumeButton.frame = CGRect(x: 110.0, y: 400.0, width: 200.0, height: 52.0)
         resumeButton.setTitle("Resume", for: .normal)
         resumeButton.layer.borderWidth = 5.0
         resumeButton.layer.borderColor = UIColor.white.cgColor
         resumeButton.backgroundColor = UIColor.black
         resumeButton.titleLabel?.textColor = UIColor.white
         resumeButton.tintColor = UIColor.white
         resumeButton.layer.cornerRadius = 15.0
         resumeButton.addTarget(self, action: #selector(resumeButtonAction(_:)), for: .touchUpInside)
         self.view?.addSubview(resumeButton)
        
       
        backToMainButton.frame = CGRect(x: 110.0, y: 500.0, width: 200.0, height: 52.0)
        backToMainButton.setTitle("Main Menu", for: .normal)
        backToMainButton.layer.borderWidth = 5.0
        backToMainButton.layer.borderColor = UIColor.white.cgColor
        backToMainButton.backgroundColor = UIColor.black
        backToMainButton.titleLabel?.textColor = UIColor.white
        backToMainButton.tintColor = UIColor.white
        backToMainButton.layer.cornerRadius = 15.0
        backToMainButton.addTarget(self, action: #selector(backToMainButtonAction(_:)), for: .touchUpInside)
        self.view?.addSubview(backToMainButton)
    }
    internal override func willMove(from view: SKView) {
        restartButton.removeFromSuperview()
        resumeButton.removeFromSuperview()
        backToMainButton.removeFromSuperview()
    }
    @objc func restartButtonAction(_ : UIButton){
        
    }
    @objc func resumeButtonAction(_ : UIButton){
          
    }
    @objc func backToMainButtonAction(_ : UIButton){
            
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scene?.view?.presentScene(GameOverScene(size: self.frame.size))
    }
}
