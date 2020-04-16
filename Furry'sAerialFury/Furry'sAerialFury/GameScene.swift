//
//  GameScene.swift
//  Furry'sAerialFury
//
//  Created by graphic on 2020-03-06.
//  Copyright © 2020 graphic. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

struct PhysicsBodyType {
    static let rabbitPlane: UInt32 = 0x1 << 1
    static let enemyPlane: UInt32 = 0x1 << 2
    static let bullet: UInt32 = 0x1 << 3
    static let enemyBullet: UInt32 = 0x1 << 4
}



let pauseButton = UIButton.init(type:.system)
let attackButton = UIButton.init(type:.system)
let specialButton = UIButton.init(type:.system)
//let DPAD = UIButton.init(type:.system)

var playerShootSound = AVAudioPlayer()
var explosionSound = AVAudioPlayer()

class GameScene: SKScene, SKPhysicsContactDelegate {
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
    
    var TextureAtlasEExplosion = SKTextureAtlas()
    var TextureArrayEEnemy = [SKTexture]()
    var TextureAtlasPExplosion = SKTextureAtlas()
    var TextureArrayEPlayer = [SKTexture]()
    
    
    var background = SKSpriteNode()
    var rabbitPlane = SKSpriteNode()
    var enemyPlane = SKSpriteNode()
    var enemyGroup = SKNode()
    var moveAndRemove = SKAction()
    
    var score = Int()
    var scoreLabel = SKLabelNode()
    
    var death = Bool()
    var gameStart = Bool()
    var mainGame = SKLabelNode()
    
    var BGMaudio = AVAudioPlayer()
    var enemyExplosion = SKSpriteNode()
    var playerExplosion = SKSpriteNode()
    
    
    
    
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
        
        physicsWorld.contactDelegate = self
        
        setupJoystick()
        
         self.backgroundColor = SKColor.init(red: 0, green: 0, blue: 0, alpha: 0)
         mainGame = SKLabelNode(fontNamed: "Chalkduster")
         mainGame.text = "Press the screen to Start!"
         mainGame.zPosition = 3
         mainGame.fontSize = 20
         mainGame.position = CGPoint(x: frame.midX, y: frame.midY+300)
         addChild(mainGame)
         
         scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
         scoreLabel.text = "Score: " + "\(score)"
         scoreLabel.fontSize = 30
         scoreLabel.zPosition = 3
         scoreLabel.position = CGPoint(x: frame.midX+80, y: frame.midY+350)
         self.addChild(scoreLabel)
         
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
        
        let BGM = Bundle.main.path(forResource: "Floral Fury", ofType: "mp3")
        
        do {
            BGMaudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: BGM!))
        }
        catch{
            print(error)
        }
        
        
        BGMaudio.play()
        
        
        
        createScene()

        
    }
    
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        score = 0
        death = false
        gameStart = false
        BGMaudio.play()
    }
    
    func createScene(){
        
        physicsWorld.contactDelegate = self
        
         TextureAtlas = SKTextureAtlas(named: "plane.atlas")
             for i in 0...1{
                 
                 let Name = "Plane\(i)"
                 TextureArray.append(SKTexture(imageNamed: Name))
                 
             }
             rabbitPlane = SKSpriteNode(imageNamed: "Plane0" )
             rabbitPlane.setScale(0.5)
             rabbitPlane.position = CGPoint(x:self.frame.width/2, y: self.frame.height/2 - 200)
             rabbitPlane.zPosition = 3
             rabbitPlane.physicsBody = SKPhysicsBody(rectangleOf: rabbitPlane.size )
             rabbitPlane.physicsBody?.categoryBitMask = PhysicsBodyType.rabbitPlane
             rabbitPlane.physicsBody?.collisionBitMask = PhysicsBodyType.enemyBullet | PhysicsBodyType.enemyPlane
             rabbitPlane.physicsBody?.contactTestBitMask = PhysicsBodyType.enemyBullet | PhysicsBodyType.enemyPlane
             rabbitPlane.physicsBody?.affectedByGravity = false
             rabbitPlane.physicsBody?.isDynamic = true;
             rabbitPlane.run(SKAction.repeatForever(SKAction.animate(with: TextureArray, timePerFrame: 0.1, resize: true, restore: true)))
         
             self.addChild(rabbitPlane)
         
         
         
         
         
         
         
         
         

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if(firstBody.categoryBitMask == PhysicsBodyType.enemyPlane && secondBody.categoryBitMask == PhysicsBodyType.rabbitPlane || firstBody.categoryBitMask == PhysicsBodyType.rabbitPlane && secondBody.categoryBitMask == PhysicsBodyType.enemyPlane)
        {
            collisionBoom(rabbitPlane: secondBody.node as! SKSpriteNode , enemyPlane: firstBody.node as! SKSpriteNode)
            
            self.run(SKAction.wait(forDuration: 2)){
                self.scene?.view?.presentScene(GameOverScene(size: self.frame.size))
            }
            
            do {
                explosionSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Explosion", ofType: "mp3")!))
            }
            catch {
                print(error)
            }
            
            explosionSound.play()
            BGMaudio.stop()

            
            
        }
        
        if(firstBody.categoryBitMask == PhysicsBodyType.enemyPlane && secondBody.categoryBitMask == PhysicsBodyType.bullet || firstBody.categoryBitMask == PhysicsBodyType.bullet && secondBody.categoryBitMask == PhysicsBodyType.enemyPlane)
        {
            
            scoreLabel.text = "Score: " + "\(score)"
            scoreLabel.zPosition = 3
            print("Player Bulley hit")
            print(score)
            
            enemyBoom(bullet: firstBody.node as! SKSpriteNode, enemyPlane: secondBody.node as! SKSpriteNode)
            
            do {
                explosionSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Explosion", ofType: "mp3")!))
            }
            catch {
                print(error)
            }
            
            explosionSound.play()
            
            
            
        }
        
        if(firstBody.categoryBitMask == PhysicsBodyType.rabbitPlane && secondBody.categoryBitMask == PhysicsBodyType.enemyBullet || firstBody.categoryBitMask == PhysicsBodyType.enemyBullet && secondBody.categoryBitMask == PhysicsBodyType.rabbitPlane)
        {
            //isPaused = true
            //print("Enemy Bullet hit")
            
            playerBoom(enemyBullet: secondBody.node as! SKSpriteNode, rabbitPlane: firstBody.node as! SKSpriteNode)
            
            //isPaused = true
            
            self.run(SKAction.wait(forDuration: 2)){
                self.scene?.view?.presentScene(GameOverScene(size: self.frame.size))
            }
            
            
            do {
                explosionSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Explosion", ofType: "mp3")!))
            }
            catch {
                print(error)
            }
            
            explosionSound.play()
            BGMaudio.stop()
            
        }
        

        
        
    }
    
    func collisionBoom(rabbitPlane: SKSpriteNode, enemyPlane: SKSpriteNode){
        
        enemyExplosion = SKSpriteNode(imageNamed: "Explotion1.png")
        enemyExplosion.setScale(1)
        enemyExplosion.zPosition = 3
        enemyExplosion.position = CGPoint(x: enemyPlane.position.x, y: enemyPlane.position.y)
        self.addChild(enemyExplosion)
    
        TextureAtlasEExplosion = SKTextureAtlas(named: "EnemyExplosion.atlas")
        for i in 1...3{
            
            let Name = "Explotion\(i)"
            TextureArrayEEnemy.append(SKTexture(imageNamed: Name))
            
        }
        
        playerExplosion = SKSpriteNode(imageNamed: "Explotion4.png")
        playerExplosion.setScale(1)
        playerExplosion.zPosition = 3
        playerExplosion.position = CGPoint(x: rabbitPlane.position.x, y: rabbitPlane.position.y)
               self.addChild(playerExplosion)
               
        TextureAtlasPExplosion = SKTextureAtlas(named: "PlayerExplosion.atlas")
               for i in 4...8{
                   
                   let Name = "Explotion\(i)"
                   TextureArrayEPlayer.append(SKTexture(imageNamed: Name))
                
                   
        }
               
        
        rabbitPlane.removeFromParent()
        enemyPlane.removeFromParent()
        
        enemyExplosion.run(SKAction.animate(with: TextureArrayEEnemy, timePerFrame: 0.1, resize: true, restore: true))
        
        playerExplosion.run(SKAction.animate(with: TextureArrayEPlayer, timePerFrame: 0.1, resize: true, restore: true))
        
        self.run(SKAction.wait(forDuration: 1)){
            self.enemyExplosion.removeFromParent()
        }
        
        self.run(SKAction.wait(forDuration: 1)){
            self.playerExplosion.removeFromParent()
        }
        
        
        
    }
    
    
    func enemyBoom(bullet: SKSpriteNode, enemyPlane: SKSpriteNode){
        
        enemyExplosion = SKSpriteNode(imageNamed: "Explotion1.png")
        enemyExplosion.setScale(1)
        enemyExplosion.zPosition = 3
        enemyExplosion.position = CGPoint(x: enemyPlane.position.x, y: enemyPlane.position.y)
        self.addChild(enemyExplosion)
        
        TextureAtlasEExplosion = SKTextureAtlas(named: "EnemyExplosion.atlas")
        for i in 1...3{
            
            let Name = "Explotion\(i)"
            TextureArrayEEnemy.append(SKTexture(imageNamed: Name))
            
        }
        
        
       
        bullet.removeFromParent()
        enemyPlane.removeFromParent()
        
        enemyExplosion.run(SKAction.animate(with: TextureArrayEEnemy, timePerFrame: 0.1, resize: true, restore: true))
        
        
        
        self.run(SKAction.wait(forDuration: 1)){
            self.enemyExplosion.removeFromParent()
        }
        
        
        
        
        score += 1
    }
    
    func playerBoom(enemyBullet: SKSpriteNode, rabbitPlane: SKSpriteNode){
        playerExplosion = SKSpriteNode(imageNamed: "Explotion4.png")
        playerExplosion.setScale(1)
        playerExplosion.zPosition = 3
        playerExplosion.position = CGPoint(x: rabbitPlane.position.x, y: rabbitPlane.position.y)
        self.addChild(playerExplosion)
        
        TextureAtlasPExplosion = SKTextureAtlas(named: "PlayerExplosion.atlas")
        for i in 4...8{
            
            let Name = "Explotion\(i)"
            TextureArrayEPlayer.append(SKTexture(imageNamed: Name))
            
        }
        
        enemyBullet.removeFromParent()
        rabbitPlane.removeFromParent()
        
        playerExplosion.run(SKAction.animate(with: TextureArrayEPlayer, timePerFrame: 0.1, resize: true, restore: true))
        
        self.run(SKAction.wait(forDuration: 1)){
            self.playerExplosion.removeFromParent()
        }
        
        
    }
    
    
    
    
    
    func enemyFireBullet(){
        
        
        let enemyBullet = SKSpriteNode(imageNamed: "EnemyBullet")
        enemyBullet.position = enemyPlane.position
        enemyBullet.position.y += 5
        enemyBullet.zPosition = 3
        
        enemyBullet.physicsBody = SKPhysicsBody(rectangleOf: enemyBullet.size)
        enemyBullet.physicsBody?.categoryBitMask = PhysicsBodyType.enemyBullet
        enemyBullet.physicsBody?.collisionBitMask = PhysicsBodyType.rabbitPlane
        enemyBullet.physicsBody?.contactTestBitMask = PhysicsBodyType.rabbitPlane
        enemyBullet.physicsBody?.isDynamic = true
        enemyBullet.physicsBody?.affectedByGravity = false
        enemyBullet.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(enemyBullet)
        
        var enemyActionArray = [SKAction]()
        
        enemyActionArray.append(SKAction.move(to: CGPoint(x: enemyPlane.position.x, y: -self.frame.size.height + 10), duration: 8))
        enemyActionArray.append(SKAction.removeFromParent())
        
        enemyBullet.run(SKAction.sequence(enemyActionArray))
        
        
        
        
        
        
        
    }
    
    func fireBullet(){
        
        //self.run(SKAction.playSoundFileNamed(<#T##soundFile: String##String#>, waitForCompletion: <#T##Bool#>))
        
        let bullet = SKSpriteNode(imageNamed: "PlayerBullet")
        bullet.position = rabbitPlane.position
        bullet.position.y += 5
        bullet.zPosition = 3
        
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody?.categoryBitMask = PhysicsBodyType.bullet
        bullet.physicsBody?.collisionBitMask = PhysicsBodyType.enemyPlane
        bullet.physicsBody?.contactTestBitMask = PhysicsBodyType.enemyPlane
        bullet.physicsBody?.isDynamic = true
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(bullet)
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: rabbitPlane.position.x, y: self.frame.size.height + 10), duration: 1.3))
        actionArray.append(SKAction.removeFromParent())
        
        bullet.run(SKAction.sequence(actionArray))
        
        
        
        
        
        
        
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
            enemyPlane.zPosition = 3
        
            enemyPlane.physicsBody = SKPhysicsBody(rectangleOf: enemyPlane.size )
            enemyPlane.physicsBody?.categoryBitMask = PhysicsBodyType.enemyPlane
            enemyPlane.physicsBody?.collisionBitMask = PhysicsBodyType.bullet | PhysicsBodyType.rabbitPlane
            enemyPlane.physicsBody?.contactTestBitMask = PhysicsBodyType.bullet | PhysicsBodyType.rabbitPlane
            enemyPlane.physicsBody?.affectedByGravity = false
            enemyPlane.physicsBody?.isDynamic = true;
            enemyPlane.run(SKAction.repeatForever(SKAction.animate(with: TextureArrayEnemy, timePerFrame: 0.1, resize: true, restore: true)))
        self.addChild(enemyPlane)

        
        let randomPosition = CGFloat.random(min: -200, max: 200)
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
       isPaused = true
        scene?.view?.presentScene(PauseScene(size: self.frame.size))
   }
    @objc func attackButtonAction(_ : UIButton){
        
        fireBullet()
        
        do {
            playerShootSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Shoot", ofType: "mp3")!))
        }
        catch {
            print(error)
        }
        
        playerShootSound.play()
        
    }
      @objc func specialButtonAction(_ : UIButton){
          
      }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //scene?.view?.presentScene(OptionScene(size: self.frame.size))
        
        //enemyFireBullet()
        
        mainGame.text = " "
        
        if(gameStart) == false {
            
            gameStart = true
            
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
            
            
            let Bulletspawn = SKAction.run({
                () in
                
                self.enemyFireBullet()
                
            })
            
            let timeDelay = SKAction.wait(forDuration: 2.0)
            let spawnBulletDelay = SKAction.sequence([Bulletspawn, timeDelay])
            let spawnForever = SKAction.repeatForever(spawnBulletDelay)
            self.run(spawnForever)
            
        }
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
