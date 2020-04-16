//
//  GameOverScreen.swift
//  Furry'sAerialFury
//
//  Created by user162295 on 3/11/20.
//  Copyright © 2020 graphic. All rights reserved.
//

import SpriteKit
import AVFoundation
let retryButton = UIButton.init(type:.system)
let mainMenuButton = UIButton.init(type:.system)


var sound = AVAudioPlayer()
var bunny = SKSpriteNode()
class GameOverScene: SKScene {
    
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        let gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
         gameOverLabel.text = "Game Over!"
         gameOverLabel.fontSize = 60
         gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY+300)
         addChild(gameOverLabel)
    
        retryButton.frame = CGRect(x: 110.0, y: 350.0, width: 200.0, height: 52.0)
        retryButton.setTitle("Retry", for: .normal)
        retryButton.layer.borderWidth = 5.0
        retryButton.layer.borderColor = UIColor.white.cgColor
        retryButton.backgroundColor = UIColor.black
        retryButton.titleLabel?.textColor = UIColor.white
        retryButton.tintColor = UIColor.white
        retryButton.layer.cornerRadius = 15.0
        retryButton.addTarget(self, action: #selector(retryButtonAction(_:)), for: .touchUpInside)
        self.view?.addSubview(retryButton)
        
        mainMenuButton.frame = CGRect(x: 110.0, y: 450.0, width: 200.0, height: 52.0)
        mainMenuButton.setTitle("Main Menu", for: .normal)
        mainMenuButton.layer.borderWidth = 5.0
        mainMenuButton.layer.borderColor = UIColor.white.cgColor
        mainMenuButton.backgroundColor = UIColor.black
        mainMenuButton.titleLabel?.textColor = UIColor.white
        mainMenuButton.tintColor = UIColor.white
        mainMenuButton.layer.cornerRadius = 15.0
        mainMenuButton.addTarget(self, action: #selector(mainMenuButtonAction(_:)), for: .touchUpInside)
        self.view?.addSubview(mainMenuButton)
        
        
        
        do {
            sound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Sad-trombone", ofType: "mp3")!))
        }
        catch {
            print(error)
        }
        
        sound.play()
        
        bunny = SKSpriteNode(imageNamed: "SadBunny.png")
        bunny.setScale(0.3)
        bunny.position = CGPoint(x: frame.midX, y: frame.maxY - 700)
        self.addChild(bunny)
        
        
        
    }
     internal override func willMove(from view: SKView) {
           retryButton.removeFromSuperview()
          
           mainMenuButton.removeFromSuperview()
       }
@objc func mainMenuButtonAction(_ : UIButton){
          scene?.view?.presentScene(MenuScene(size: self.frame.size))

}
@objc func retryButtonAction(_ : UIButton){
            scene?.view?.presentScene(GameScene(size: self.frame.size))

}
    
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scene?.view?.presentScene(MenuScene(size: self.frame.size))
    }
}
