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
//let DPAD = UIButton.init(type:.system)
class GameScene: SKScene {
    struct ScreenSize {
      static let width        = UIScreen.main.bounds.size.width
      static let height       = UIScreen.main.bounds.size.height
      static let maxLength    = max(ScreenSize.width, ScreenSize.height)
      static let minLength    = min(ScreenSize.width, ScreenSize.height)
      static let size         = CGSize(width: ScreenSize.width, height: ScreenSize.height)
    }
    enum NodesZPosition: CGFloat {
      case background, hero, joystick
    }
     let velocityMultiplier: CGFloat = 0.12
    var TextureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    
    var TextureAtlasEnemy = SKTextureAtlas()
    var TextureArrayEnemy = [SKTexture]()
    
    var background = SKSpriteNode()
    var rabbitPlane = SKSpriteNode()
    var enemyPlane = SKSpriteNode()
    var enemyGroup = SKNode()
    var moveAndRemove = SKAction()
    
    
    
    
    
    
    
    
     lazy var analogJoystick: AnalogJoystick = {
         let js = AnalogJoystick(diameter: 100, colors: nil, images: (substrate: #imageLiteral(resourceName: "jSubstrate"), stick: #imageLiteral(resourceName: "jStick")))
         js.position = CGPoint(x: 100, y: 100)
        debugPrint("test1")
         js.zPosition = NodesZPosition.joystick.rawValue
         return js
       }()
    func setupJoystick() {
          addChild(analogJoystick)
     
          analogJoystick.trackingHandler = { [unowned self] data in
            self.rabbitPlane.position = CGPoint(
            x: self.rabbitPlane.position.x + (data.velocity.x * self.velocityMultiplier),
            y: self.rabbitPlane.position.y + (data.velocity.y * self.velocityMultiplier))
          }
      
    }
    override func didMove(to view: SKView) {
        setupJoystick()
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
        /*
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
        */
        /////////////////////////////////////////////////////////////
        
        for i in 0..<2 {
            background = SKSpriteNode(imageNamed: "gamebackground.png")
            background.anchorPoint = CGPoint(x: 0, y: 0)
            background.setScale(1)
            background.position = CGPoint(x: 0, y: CGFloat(i) * self.frame.height)
            background.name = "background"
            self.addChild(background)
            
        }
        
        
        
        
        TextureAtlas = SKTextureAtlas(named: "plane.atlas")
            for i in 0...1{
                
                let Name = "Plane\(i)"
                TextureArray.append(SKTexture(imageNamed: Name))
                
            }
            rabbitPlane = SKSpriteNode(imageNamed: "Plane0" )
            rabbitPlane.setScale(0.5)
            rabbitPlane.position = CGPoint(x:self.frame.width/2, y: self.frame.height/2 - 200)
            rabbitPlane.zPosition = 3
            rabbitPlane.run(SKAction.repeatForever(SKAction.animate(with: TextureArray, timePerFrame: 0.1, resize: true, restore: true)))
        
            self.addChild(rabbitPlane)
        
        
//        TextureAtlasEnemy = SKTextureAtlas(named: "enemy.atlas")
//            for i in 0...1{
//
//                let Name = "Enemy\(i)"
//                TextureArrayEnemy.append(SKTexture(imageNamed: Name))
//
//            }
//            enemyPlane = SKSpriteNode(imageNamed: "Enemy0" )
//            enemyPlane.setScale(0.5)
//            enemyPlane.position = CGPoint(x:self.frame.width/2, y: self.frame.height/2 + 200)
//            enemyPlane.zPosition = 2
//            enemyPlane.run(SKAction.repeatForever(SKAction.animate(with: TextureArrayEnemy, timePerFrame: 0.1, resize: true, restore: true)))
//
//            self.addChild(enemyPlane)
        
        
        
        
        
        
        
        
        
        
    }
    
    
    func enemySpawn() {
        
        
        
        
        TextureAtlasEnemy = SKTextureAtlas(named: "enemy.atlas")
            for i in 0...1{
                
                let Name = "Enemy\(i)"
                TextureArrayEnemy.append(SKTexture(imageNamed: Name))
                
            }
            enemyPlane = SKSpriteNode(imageNamed: "Enemy0" )
            enemyPlane.setScale(0.5)
            enemyPlane.position = CGPoint(x:self.frame.width/2, y: self.frame.height/2 + 600)
            enemyPlane.zPosition = 2
            enemyPlane.run(SKAction.repeatForever(SKAction.animate(with: TextureArrayEnemy, timePerFrame: 0.1, resize: true, restore: true)))
        self.addChild(enemyPlane)

        
        var randomPosition = CGFloat.random(min: -200, max: 200)
        enemyPlane.position.x = enemyPlane.position.x + randomPosition
        
        
        enemyPlane.run(moveAndRemove)
        
        
    }
    
    
    
    
    
    internal override func willMove(from view: SKView) {
        pauseButton.removeFromSuperview()
        attackButton.removeFromSuperview()
        specialButton.removeFromSuperview()
        //DPAD.removeFromSuperview()
    }
    @objc func pauseButtonAction(_ : UIButton){
       
   }
    @objc func attackButtonAction(_ : UIButton){
        
    }
      @objc func specialButtonAction(_ : UIButton){
          
      }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //scene?.view?.presentScene(OptionScene(size: self.frame.size))
        
        let spawn = SKAction.run({
            () in
            
            self.enemySpawn()
        })
        
        let delay = SKAction.wait(forDuration: 2.0)
        let spawnDelay = SKAction.sequence([spawn, delay])
        let spawnDelayForever = SKAction.repeatForever(spawnDelay)
        self.run(spawnDelayForever)
        
        let distance = CGFloat(self.frame.width * 3 + enemyPlane.frame.width)
        let moveEnemy = SKAction.moveBy(x: 0, y: -distance - 60, duration: TimeInterval(0.010 * distance ))
        let removeEnemy = SKAction.removeFromParent()
        moveAndRemove = SKAction.sequence([moveEnemy, removeEnemy])
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        enumerateChildNodes(withName: "background", using: ({
            (node, error) in
            
            var bg = node as! SKSpriteNode
            bg.position = CGPoint(x: bg.position.x, y: bg.position.y - 3)
            bg.setScale(1)
            if bg.position.y <= -bg.size.height {
                bg.position = CGPoint(x: bg.position.x, y: bg.position.y + bg.size.height * 2)
            }
        }))
    }
}
