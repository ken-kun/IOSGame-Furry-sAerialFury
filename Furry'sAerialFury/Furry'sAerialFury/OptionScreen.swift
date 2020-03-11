//
//  OptionScene.swift
//  Furry'sAerialFury
//
//  Created by Run Wu on 2020-03-06.
//  Copyright © 2020 graphic. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class OptionScene: SKScene {
    
    var background = SKSpriteNode()
    
    var slider = UISlider()
    var audio = AVAudioPlayer()
    
    
    
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
        
        slider = UISlider(frame: CGRect(x: self.frame.width/2 - 100, y: self.frame.height/2, width: 200, height: 20))
        
        view.addSubview(slider)
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "Music"
        label.fontSize = 45
        label.position = CGPoint(x: frame.midX, y: frame.midY + 50)
           
        addChild(label)
        
        let BGM = Bundle.main.path(forResource: "Floral Fury", ofType: "mp3")
        
        do {
            audio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: BGM!))
        }
        catch{
            print(error)
        }
        
        audio.play()
        slider.maximumValue = Float(audio.duration)
        
        
        
        ChangeAudioTime(sender: slider)
        
    }
  
    override func update(_ currentTime: TimeInterval) {
        audio.setVolume(slider.value, fadeDuration: 200)
        print(slider.value)
    }
    
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scene?.view?.presentScene(CreditScene(size: self.frame.size))
    }
    
    internal override func willMove(from view: SKView) {
        slider.removeFromSuperview()
        
    }
    
    func ChangeAudioTime(sender: AnyObject){
        audio.stop()
        audio.currentTime = TimeInterval(slider.value)
        audio.prepareToPlay()
        audio.play()
        
    }
    
    func updateSlider() {
        slider.value = Float(audio.currentTime)
        NSLog("Update")
    }
}
