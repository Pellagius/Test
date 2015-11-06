//
//  TSBookOfEarthClanHouseTestGame.swift
//  TradeSamuraiBooks
//
//  Created by Media Production on 28/10/2015.
//  Copyright © 2015 Trade Samurai. All rights reserved.
//

import Foundation
import SpriteKit
import CoreGraphics
import AVFoundation

class TSBookOfEarthClanHouseTestGame :  SKScene, SKPhysicsContactDelegate
{
    
    
 
    
    enum playerState
    {
        case ground
        case jumping
        case falling
        case attacking
        case hanging
    }
    enum TSBookOfEarthClanHouseTestGameStatus
    {
        case Show
        case Practice
        case PracticeWin1
        case PracticeWin2
        case InfoQuestion
        case InfoAnswer
        case RisingIntro
        case Rising
        case RisingEnd
        case FallingIntro
        case Falling
    }
    
    enum speechSize
    {
        case one
        case two
        case three
    }
    
    
    var status : TSBookOfEarthClanHouseTestGameStatus = .Show
    
    var state : playerState = .ground
    
    var speechLines : speechSize = .one
    
    var playable : Bool = false
    var answerShown : Bool = false
    
    var sfxArray = [String]()
    
    var backgroundMusicPlayer = AVAudioPlayer!()
    
    //gesture definitions
    
    var touchEmitter : SKEmitterNode = SKEmitterNode()
    var touchNode : Swipe?
    var touchStart : CGPoint = CGPoint()
    var touchBeginning : CGPoint = CGPoint()
    
    
    //contentArray
    var contentIndex = 0
    var contentArray : Array<Dictionary<String, AnyObject>> = []
    
    //speech
    var speechBubble : SKSpriteNode = SKSpriteNode()
    var speechLabel1 : SKLabelNode = SKLabelNode()
    var speechLabel2 : SKLabelNode = SKLabelNode()
    var speechLabel3 : SKLabelNode = SKLabelNode()
    var speechLabel4 : SKLabelNode = SKLabelNode()
    var speechLabel1Pos : CGPoint = CGPoint()
    var speechLabel2Pos : CGPoint = CGPoint()
    var speechLabel3Pos : CGPoint = CGPoint()
    var speechLabel4Pos : CGPoint = CGPoint()
    
    var speechArray = [SKNode]()

    
    //info
    var infoBox : SKSpriteNode = SKSpriteNode()
    var importLabel : SKLabelNode = SKLabelNode()
    var importLabel1 : SKLabelNode = SKLabelNode()
    var importLabel2 : SKLabelNode = SKLabelNode()
    var importLabel3 : SKLabelNode = SKLabelNode()
    var importLabel4 : SKLabelNode = SKLabelNode()
    var exportLabel : SKLabelNode = SKLabelNode()
    var exportLabel1 : SKLabelNode = SKLabelNode()
    var exportLabel2 : SKLabelNode = SKLabelNode()
    var exportLabel3 : SKLabelNode = SKLabelNode()
    var exportLabel4 : SKLabelNode = SKLabelNode()
    var questionLabel1 : SKLabelNode = SKLabelNode()
    var questionLabel2 : SKLabelNode = SKLabelNode()
    var questionLabel3 : SKLabelNode = SKLabelNode()
    var questionLabel4 : SKLabelNode = SKLabelNode()
    var manButton : SKSpriteNode = SKSpriteNode()
    var comButton : SKSpriteNode = SKSpriteNode()
    var comButtonLabel : SKLabelNode = SKLabelNode()
    var manButtonLabel : SKLabelNode = SKLabelNode()
    
    var infoNodeArray = [SKNode]()
    
    //graph sprites
    var greenGraph : SKSpriteNode = SKSpriteNode()
    var redGraph : SKSpriteNode = SKSpriteNode()
    var redBar : SKSpriteNode = SKSpriteNode()
    var greenBar : SKSpriteNode = SKSpriteNode()
    var flag : SKSpriteNode = SKSpriteNode()
    var flag2 : SKSpriteNode = SKSpriteNode()
    
    //graph labels
    var priceLabel1 : SKLabelNode = SKLabelNode()
    var priceLabel2 : SKLabelNode = SKLabelNode()
    var yenLabel : SKLabelNode = SKLabelNode()
    var currLabel : SKLabelNode = SKLabelNode()
    var commLabel : SKLabelNode = SKLabelNode()
    var countryLabel : SKLabelNode = SKLabelNode()
    var countryLabel2 : SKLabelNode = SKLabelNode()
    
    var graphNodeArray = [SKNode]()
    
    //Time since last frame
    var lastUpdateTime  : NSTimeInterval = 0
    var elapsedTime     : NSTimeInterval = 0
    var dt              : NSTimeInterval = 0
    
    //Slashing game
    var player : SKSpriteNode = SKSpriteNode()
    var playerSpawn : CGPoint = CGPoint()
    var gold : SKSpriteNode = SKSpriteNode()
    var car : SKSpriteNode = SKSpriteNode()
    var silicon : SKSpriteNode = SKSpriteNode()
    var computer : SKSpriteNode = SKSpriteNode()
    var steel : SKSpriteNode = SKSpriteNode()
    var platform : SKSpriteNode = SKSpriteNode()
    var leftSpawn : CGPoint = CGPoint()
    var rightSpawn : CGPoint = CGPoint()
    var practiceCount : Int = 0
    var spawnChance : CGFloat = 50.0
    var prevTargetVector : CGVector = CGVector()
    var spawnTime : NSTimeInterval = 3.0
    var timeToDecrement : NSTimeInterval = NSTimeInterval()
    var spawnTimeDecrement : NSTimeInterval = 2.0
    var playerHurt : Bool = false
    
    var goodsArray = [SKSpriteNode]()
    var finalBarSize : CGFloat = CGFloat()
    
    //Textures
    let playerAttack : SKTexture = SKTexture(imageNamed: "ninjaAttack.png")
    let playerIdle : SKTexture = SKTexture(imageNamed: "playerSamurai.png")
    let playerJump : SKTexture = SKTexture(imageNamed: "ninjaJump.png")
    let playerHang : SKTexture = SKTexture(imageNamed: "ninjaHang.png")
    let platformTexture   : SKTexture = SKTexture(imageNamed: "tex_final_japFloor.png")
    let goldTexture : SKTexture = SKTexture(imageNamed: "GoldBars.png")
    let carTexture : SKTexture = SKTexture(imageNamed: "car.png")
    let siliconTexture : SKTexture = SKTexture(imageNamed: "silicon.png")
    let computerTexture : SKTexture = SKTexture(imageNamed: "computer.png")
    let steelTexture : SKTexture = SKTexture(imageNamed: "steel.png")
    let currencyGraphTexture : SKTexture = SKTexture(imageNamed: "CurrencyGraph.png")
    let currencyBarTexture : SKTexture = SKTexture(imageNamed: "CurrencyBar.png")
    let commodityGraphTexture : SKTexture = SKTexture(imageNamed: "CommodityGraph.png")
    let commodityBarTexture : SKTexture = SKTexture(imageNamed: "CommodityBar.png")
    
    
    //Layers
    var gameLayer : SKNode = SKNode()
    var hudLayer : SKNode = SKNode()
    var backgroundLayer : SKNode = SKNode()
    
    //Physics
    var border :SKPhysicsBody = SKPhysicsBody()
    var playerPhysicsBody : SKPhysicsBody = SKPhysicsBody()
    var goldPhysicsBody : SKPhysicsBody = SKPhysicsBody()
    var carPhysicsBody : SKPhysicsBody = SKPhysicsBody()
    var iconPhysicsBody : SKPhysicsBody = SKPhysicsBody()
    var platformPhysicsBody : SKPhysicsBody = SKPhysicsBody()
    var borderMask : UInt32 = UInt32()
    var playerMask : UInt32 = UInt32()
    var platformMask : UInt32 = UInt32()
    var goldMask : UInt32 = UInt32()
    var carMask : UInt32 = UInt32()
    var iconMask : UInt32 = UInt32()
    
    let playerStandardMass : CGFloat = 1.5
    let playerBoostedMass : CGFloat = 5
    
    
    let gravityForce : CGFloat = -15.0
    let jumpingForce : CGFloat = 5000.0

    //Bar Graphs
    let currencyGraph : SKSpriteNode = SKSpriteNode()
    let commodityGraph : SKSpriteNode = SKSpriteNode()
    let currencyBar : SKSpriteNode = SKSpriteNode()
    let commodityBar : SKSpriteNode = SKSpriteNode()
    
    
    var background  : SKSpriteNode = SKSpriteNode()
    var sideBar  : SKSpriteNode = SKSpriteNode()
    
    override func didMoveToView(view: SKView)
    {
        super.didMoveToView(view)
        physicsWorld.contactDelegate = self
        playMusic("BGM_Prototype.mp3")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupLayers()
        setupMusic()
        setupPlayer()
        self.name = "scene"
        setupContent()
        setupPhysicsBodies()
    }
    
    func setupLayers()
    {
        gameLayer = findSKNode("gameLayer", node: gameLayer)
        hudLayer = findSKNode("hudLayer", node: hudLayer)
        backgroundLayer = findSKNode("backgroundLayer", node: backgroundLayer)
        backgroundLayer.zPosition = background.zPosition + 1
       
    }
    
    func setupMusic()
    {
        sfxArray = (["SFX_fatality.mp3", "SFX_finish.mp3", "SFX_flawless.mp3"])
    }
    
    func setupPlayer()
    {
        player = SKSpriteNode(texture: playerIdle, color: UIColor.clearColor(), size: playerIdle.size())
        gameLayer.addChild(player)
        player.name = "player"
        playerSpawn = CGPoint(x: frame.width / 2, y: frame.height / 6 )
        player.zPosition = gameLayer.zPosition + 50
        player.position = playerSpawn
        
       //swipe effect
        touchStart = CGPoint.zero
        touchNode = Swipe(position: position, target: hudLayer)
        
    }
    
    func setupContent()
    {
        platform = SKSpriteNode(texture: platformTexture, color: UIColor.clearColor(), size: platformTexture.size())
        gameLayer.addChild(platform)
        platform.name = "platform"
        platform.zPosition = player.zPosition - 2
        platform.position = CGPoint(x: frame.width/2, y: 100.0)
        platform.xScale *= 1.5

        leftSpawn = CGPoint(x: -300, y: frame.height/4)
        rightSpawn = CGPoint(x: frame.width + 300, y: frame.height/4)
      
        
        setupGraphs()
        
        gold = SKSpriteNode(texture: goldTexture, color: UIColor.clearColor(), size: goldTexture.size())
        car = SKSpriteNode(texture: carTexture, color: UIColor.clearColor(), size: carTexture.size())
        silicon = SKSpriteNode(texture: siliconTexture, color: UIColor.clearColor(), size: siliconTexture.size())
        computer = SKSpriteNode(texture: computerTexture, color: UIColor.clearColor(), size: computerTexture.size())
        steel = SKSpriteNode(texture: steelTexture, color: UIColor.clearColor(), size: steelTexture.size())
        
        //icons
        

        
        gold.scaleAsPoint = car.scaleAsPoint
        silicon.scaleAsPoint = car.scaleAsPoint
        steel.scaleAsPoint = car.scaleAsPoint
        computer.scaleAsPoint = car.scaleAsPoint
        gold.name = "gold_com"
        car.name = "car_man"
        silicon.name = "silicon_com"
        computer.name = "computer_man"
        steel.name = "steel_com"
        
        for node in [car, gold, silicon, steel, computer]
        {
            node.zPosition = 40
            node.runAction(SKAction.scaleBy(0.75, duration: 0.0))
            goodsArray.append(node)
        }

        //background
        background = findSKSpriteNode("Background", node: background)

        
        //graphs
        setupGraphContent()
        
        setupInfoBoxContent()
        
        setupSpeechContent()
        
        background.zPosition = 0
        sideBar.zPosition = -1
    }
    
    func setupGraphs()
    {
        currencyBar.texture = currencyBarTexture
        currencyGraph.texture = currencyGraphTexture
        commodityBar.texture = commodityBarTexture
        commodityGraph.texture = commodityGraphTexture
        
        currencyBar.name = "currencyBar"
        currencyGraph.name = "currencyGraph"
        commodityBar.name = "commodityBar"
        commodityGraph.name = "commodityGraph"
    }
    
    func setupPhysicsBodies()
    {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: gravityForce)
        
        let goldRect = CGSize(width: goldTexture.size().width, height: goldTexture.size().height)
        let carRect = CGSize(width: carTexture.size().width, height: carTexture.size().height)
        let platformRect = CGSize(width: frame.width, height: frame.height/7)
        
        playerPhysicsBody = SKPhysicsBody(circleOfRadius: playerIdle.size().width/2)
        goldPhysicsBody = SKPhysicsBody(rectangleOfSize: goldRect)
        carPhysicsBody = SKPhysicsBody(rectangleOfSize: carRect)
        platformPhysicsBody = SKPhysicsBody(rectangleOfSize: platformRect)
        iconPhysicsBody = SKPhysicsBody(circleOfRadius: 150)
        
        //borderBox
        border = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody = border
        border.friction = 0.0
        
        //Dont want Samurai to bounce too much!
        playerPhysicsBody.restitution = 0.0
        playerPhysicsBody.allowsRotation = false
        
        //Player and Platform
        playerPhysicsBody.mass = 1
        platformPhysicsBody.restitution = 0.0
        platformPhysicsBody.mass = 100000
        platformPhysicsBody.resting = true
        platformPhysicsBody.dynamic = false
        platformPhysicsBody.affectedByGravity = false
        
        //Icons
        iconPhysicsBody.mass = 1
        iconPhysicsBody.allowsRotation = false
        iconPhysicsBody.dynamic = true
        
        //Bitmasks
        borderMask = 0x1 << 0
        playerMask = 0x1 << 1
        platformMask = 0x1 << 2
        iconMask = 0x1 << 3
        
        
        playerPhysicsBody.categoryBitMask = playerMask
        playerPhysicsBody.collisionBitMask = platformMask
        playerPhysicsBody.contactTestBitMask = platformMask & borderMask
        border.contactTestBitMask = playerMask
        platformPhysicsBody.categoryBitMask = platformMask
        platformPhysicsBody.contactTestBitMask = playerMask
        platformPhysicsBody.collisionBitMask = iconMask
        iconPhysicsBody.categoryBitMask = iconMask
//        carPhysicsBody.categoryBitMask = carMask
//        goldPhysicsBody.categoryBitMask = goldMask
//        carPhysicsBody.contactTestBitMask = playerMask
//        goldPhysicsBody.contactTestBitMask = playerMask
        iconPhysicsBody.contactTestBitMask = playerMask
//        carPhysicsBody.collisionBitMask = goldMask & playerMask & platformMask & borderMask
//        goldPhysicsBody.collisionBitMask = carMask & playerMask & platformMask & borderMask
        iconPhysicsBody.collisionBitMask = iconMask & playerMask & borderMask
        
        //Set physics bodies
        player.physicsBody = playerPhysicsBody
        platform.physicsBody = platformPhysicsBody
        
//        car.physicsBody = carPhysicsBody
//        gold.physicsBody = goldPhysicsBody
    }

    
    func setupGraphContent()
    {
        countryLabel = findSKLabelNode("countryLabel", node: countryLabel)
        yenLabel = findSKLabelNode("yenLabel", node: yenLabel)
        flag = findSKSpriteNode("flagNode", node: flag)
        priceLabel1 = findSKLabelNode("priceLabel1", node: priceLabel1)
        priceLabel2 = findSKLabelNode("priceLabel2", node: priceLabel2)
        redBar = findSKSpriteNode("redBar", node: redBar)
        greenBar = findSKSpriteNode("greenBar", node: greenBar)
        currLabel = findSKLabelNode("currLabel", node: currLabel)
        commLabel = findSKLabelNode("commLabel", node: commLabel)
        greenGraph = findSKSpriteNode("greenGraph", node: greenGraph)
        redGraph = findSKSpriteNode("redGraph", node: redGraph)
        
        for node in [countryLabel, yenLabel, flag, priceLabel1, priceLabel2, redBar, greenBar,
            currLabel, commLabel, greenGraph, redGraph]
        {
            graphNodeArray.append(node)
            if let n = node as? SKLabelNode
            {
                n.fontName = "Gill Sans Bold 26.0"
                n.zPosition = backgroundLayer.zPosition + 1
                n.fontColor = SKColor.blueColor()
            }
        }
        
        finalBarSize = redBar.size.height
        hideGraphs()
    }

    func setupInfoBoxContent()
    {
        infoBox = findSKSpriteNode("infoBox", node: infoBox)
        flag2 = findSKSpriteNode("flagNode2", node: flag2)
        countryLabel2 = findSKLabelNode("countryLabel2", node: countryLabel2)
        yenLabel = findSKLabelNode("yenLabel", node: yenLabel)
        importLabel = findSKLabelNode("importLabel", node: importLabel)
        importLabel1 = findSKLabelNode("importLabel1", node: importLabel1)
        importLabel2 = findSKLabelNode("importLabel2", node: importLabel2)
        importLabel3 = findSKLabelNode("importLabel3", node: importLabel3)
        importLabel4 = findSKLabelNode("importLabel4", node: importLabel4)
        exportLabel = findSKLabelNode("exportLabel", node: exportLabel)
        exportLabel1 = findSKLabelNode("exportLabel1", node: exportLabel1)
        exportLabel2 = findSKLabelNode("exportLabel2", node: exportLabel2)
        exportLabel3 = findSKLabelNode("exportLabel3", node: exportLabel3)
        exportLabel4 = findSKLabelNode("exportLabel4", node: exportLabel4)
        manButton = findSKSpriteNode("manButton", node: manButton)
        comButton = findSKSpriteNode("comButton", node: comButton)
        manButtonLabel = findSKLabelNode("manButtonLabel", node: manButtonLabel)
        comButtonLabel = findSKLabelNode("comButtonLabel", node: comButtonLabel)
        questionLabel1 = findSKLabelNode("questionLabel1", node: questionLabel1)
        questionLabel2 = findSKLabelNode("questionLabel2", node: questionLabel2)
        questionLabel3 = findSKLabelNode("questionLabel3", node: questionLabel3)
        questionLabel4 = findSKLabelNode("questionLabel4", node: questionLabel4)
        
        for node in [flag2, countryLabel2, yenLabel, infoBox, importLabel, importLabel1, importLabel2,
            importLabel3, importLabel4, exportLabel, exportLabel1, exportLabel2,
            exportLabel3, exportLabel4, manButton, comButton, manButtonLabel, comButtonLabel, questionLabel1,
            questionLabel2, questionLabel3, questionLabel4]
        {
            if let n = node as? SKLabelNode
            {
                n.fontName = "Gill Sans Bold 26.0"
                n.fontColor = SKColor.whiteColor()
                let name = node.name!
                if (name.hasPrefix("import") || name.hasPrefix("export"))
                {
                    n.horizontalAlignmentMode = .Left
                }
                
            }
            node.zPosition = infoBox.zPosition + 1
            infoNodeArray.append(node)
        }
        
        hideInfoBox()
    }
    
    func setupSpeechContent()
    {
        speechBubble = findSKSpriteNode("speechBubble", node: speechBubble)
    
        speechLabel1 = findSKLabelNode("speechLabel1", node: speechLabel1)
        speechLabel1Pos = speechLabel1.position
        speechLabel2 = findSKLabelNode("speechLabel2", node: speechLabel2)
        speechLabel2Pos = speechLabel2.position
        speechLabel3 = findSKLabelNode("speechLabel3", node: speechLabel3)
        speechLabel3Pos = speechLabel3.position
        speechLabel4 = findSKLabelNode("speechLabel4", node: speechLabel4)
        speechLabel4Pos = speechLabel4.position
        
        speechBubble.hidden = true
        for node in [speechBubble, speechLabel1, speechLabel2, speechLabel3, speechLabel4]
        {
            speechArray.append(node)
        }
        
        for node in speechBubble.children
        {
            if let n = node as? SKLabelNode
            {
                n.fontName = "Gill Sans Bold 26.0"
                n.fontSize *= 1.5
                n.zPosition = speechBubble.zPosition + 1
                n.text = ""
                n.hidden = true
                n.fontColor = SKColor.whiteColor()
            }
            
        }
    }
    
    func debugNode(node : SKNode)
    {
        print("THE NODE IS: \(node)")
        print("THE ALPHA IS : \(node.alpha)")
        print("THE HIDDEN IS :\(node.hidden)")
    }
    
    
    func showSpeech()
    {

        for node in speechArray
        {
            node.hidden = false
        }
    }
    
    func hideSpeech() {

        resetSpeechLabels()
        for node in speechArray
        {
            if let n = node as? SKLabelNode
            {
                n.text = ""
            }
        }
       speechBubble.hidden = true
    }
    
    func speechHidden() -> Bool
    {
        return speechBubble.hidden
    }
    
    func isInfoHidden() -> Bool
    {
        return infoBox.hidden
    }
    
    func setSpeech(numLines : Int, text : [String])
    {
        
        for node in speechArray
        {
            node.removeAllActions()
        }
        
        let moveLine1 = SKAction.moveTo(CGPointMake(speechLabel1Pos.x, (speechLabel2Pos.y - ((speechLabel2Pos.y - speechLabel3Pos.y) / 2))), duration: 0.0)
        
        //numLines2
        let numLines2_line1 = SKAction.moveTo(speechLabel2Pos, duration: 0.0)
        let numLines2_line2 = SKAction.moveTo(speechLabel3Pos, duration: 0.0)
        
        
        //numLines3
        let numLines3_line1 = SKAction.moveTo(CGPointMake(speechLabel1Pos.x, (speechLabel1Pos.y - ((speechLabel1Pos.y - speechLabel2Pos.y) / 2))), duration: 0.0)
        let numLines3_line2 = moveLine1
        let numLines3_line3 = SKAction.moveTo(CGPointMake(speechLabel1Pos.x, (speechLabel3Pos.y - ((speechLabel3Pos.y - speechLabel4Pos.y) / 2))), duration: 0.0)

        switch(numLines)
        {
        case 1:
            speechArray[numLines].runAction(moveLine1)
            break
        case 2:
            speechArray[numLines-1].runAction(numLines2_line1)
            speechArray[numLines].runAction(numLines2_line2)
            break
        case 3:
            speechArray[numLines-2].runAction(numLines3_line1)
            speechArray[numLines-1].runAction(numLines3_line2)
            speechArray[numLines].runAction(numLines3_line3)
            break
        default: break
        }
        
        for index in 0...(numLines - 1)
        {
            if let node = speechArray[index+1] as? SKLabelNode
            {
                node.text = text[index]
            }
        }
    }

    func resetSpeechLabels()
    {
        speechLabel1.position = speechLabel1Pos
        speechLabel2.position = speechLabel2Pos
        speechLabel3.position = speechLabel3Pos
        speechLabel4.position = speechLabel4Pos
    }
    
    func hideInfoBox()
    {
        for node in infoNodeArray
        {
            node.hidden = true
        }
    }
    
    func hideGraphs()
    {
        for node in graphNodeArray
        {
            node.hidden = true
        }
    }
    
    func showInfoBox()
    {
        for node in infoNodeArray
        {
            node.hidden = false
        }
    }
    
    func showGraphs()
    {
        for node in graphNodeArray
        {
            node.hidden = false
        }
    }
    
    func isGraphsHidden() -> Bool
    {
        return greenGraph.hidden
    }
    
    func hideInfoLabels(value : Bool)
    {
        for node in infoNodeArray
        {
            if let n = node as? SKLabelNode
            {
               
                if n != countryLabel2 && n != yenLabel && n != questionLabel1 &&
                   n != questionLabel2 && n != questionLabel3 &&
                   n != questionLabel4
                {
                     n.hidden = value
                }
            }
            
            if let n = node as? SKSpriteNode
            {
                if n == manButton || n == comButton
                {
                    n.hidden = value
                }
            }
        }
    }
    
    func hideQuestionLabels(value : Bool)
    {
        for node in infoNodeArray
        {
            if let n = node as? SKLabelNode
            {
                if  n == questionLabel1 ||
                    n == questionLabel2 ||
                    n == questionLabel3 ||
                    n == questionLabel4
                {
//                    if(value == true)
//                    {
//                        print("HIDING QUESTIONS")
//                    }
//                    else
//                    {
//                        print("SHOWING QUESTIONS")
//                    }
                    n.hidden = value
                }
            }
        }
    }
    
    func isImportsExportsHidden() -> Bool
    {
        return importLabel.hidden
    }
    
    
    func findSKNode(string : String , node : SKNode, hide : Bool = true) -> SKNode {
        var label = node
        if let x = childNodeWithName("//\(string)")
        {
            label = x
        }
        return label
    }
    
    func findSKSpriteNode(string : String , node : SKSpriteNode, hide : Bool = true) -> SKSpriteNode {
        var sprite = node
        if let x = childNodeWithName("//\(string)") as? SKSpriteNode {
            sprite = x

        }
        return sprite
    }
    
    func findSKLabelNode(string : String , node : SKLabelNode, hide : Bool = true) -> SKLabelNode {
        var label = node
        if let x = childNodeWithName("//\(string)") as? SKLabelNode {
            label = x
        }
        return label
    }
    
    func findSKShapeNode(string : String , node : SKShapeNode, hide : Bool = true) -> SKShapeNode {
        var label = node
        if let x = childNodeWithName("//\(string)") as? SKShapeNode {
            label = x
        }
        return label
    }
    
    //BOSS
    override func update(currentTime: NSTimeInterval)
    {
        super.update(currentTime)
        //print("THE CURRENT STATE IS: \(state)")
        
        dt             = lastUpdateTime > 0 ? currentTime - lastUpdateTime : 0
        lastUpdateTime = currentTime
        elapsedTime    = elapsedTime + dt
        
        if(playable)
        {
            processPlayerInput()
        }
        
        switch(status)
        {
        case .Show:
            if(speechHidden())
            {
                showIntroduction()
            }
            break
        case .Practice:
            if(!playable)
            {
                
                spawnChance = 50
                showPractice()
            }
            break
        case .PracticeWin1:
            if(speechHidden())
            {
                showPracticeWin1()
            }
            break
        case .PracticeWin2:
            if(speechHidden())
            {

                showPracticeWin2()
            }
            break
        case .InfoQuestion:
            if (isInfoHidden() || answerShown)
            {
                answerShown = false
                showInfoQuestion()
            }
            break
        case .InfoAnswer:
            if (isImportsExportsHidden() && !answerShown)
            {
                showInfoImportsExports()
            }
        case .RisingIntro:
            if(speechHidden())
            {
                showRisingIntro()
            }
           break
        case .Rising:
            if(isGraphsHidden())
            {
                print("GETTING HERE")
                spawnTimeDecrement = 2.0
                spawnTime = 5.0
                spawnChance = 40
                showGraphs()
            }
            break
        case .RisingEnd:
            if(speechHidden())
            {
                showRisingEnd()
            }
        case .FallingIntro:
            if(speechHidden())
            {
                print("GETTING HERE")
                spawnTime = 5.0
                spawnChance = 60
                showFallingIntro()
            }
            break
        default: break
        }
    }
    
    
    func calculateSpawnRate()
    {
        print("THE SPAWNTIME IS : \(spawnTime)")
            switch(spawnTime)
            {
            case 0.5...0.9:
                spawnTimeDecrement = 0.2
                break
            case 1...1.4:
                spawnTimeDecrement = 0.4
                break
            case 1.5...2.5:
                spawnTimeDecrement = 0.8
                break
            default: break
            }
            print("THE SPAWN TIME IS NEXT OVER HERE IS:\(spawnTime)")
            spawnTime -= spawnTimeDecrement
            if spawnTime <= 0.5
            {
                spawnTime = 0.2
            }
    }
    
    func showFallingIntro()
    {
        let array = (["Now the supply of commodities has risen as high as possible",
            "the price of commodities will begin to fall again.",
            "Notice what happens to the value of the Yen as the Commodities price falls!",
            "This time - ONLY SLASH MANUFACTURING GOODS!!!!"])
        setSpeech(4, text: array)
        showSpeech()
    }
    
    func showRisingIntro()
    {
        let array = (["Ok, next we are going to look at how the value of commodities",
            "affects the value of Japan's Yen. Make sure to only slash commodities!",
            "Notice what happens to the value of the Yen as the Commodities price rises!",
            ""])
        setSpeech(3, text: array)
        showSpeech()
    }
    
    func showRisingEnd()
    {
        let array = (["Uh oh!!! You could not keep the value of Yen up!!",
            "Fear not young apprentice, against MARKET FORCES, not even I can stand for long.",
            "What is important here is that with the RISING price of COMMODITIES",
            "a MANUFACTURING economy's currency will FALL in proportion."])
        setSpeech(4, text: array)
        showSpeech()
    }
    
    func showPracticeWin1()
    {
        let array = (["Excellent! Commodities are those items",
                     "that are turned into Manufactured goods!",
                      "",
                      ""])
        setSpeech(2, text: array)
        showSpeech()
        
        
    }
    
    func showPracticeWin2()
    {
        let array = (["Now, lets take a look at our first country - Japan",
                      "",
                      "",
                      ""])
        setSpeech(1, text: array)
        showSpeech()
    }
    
    
    func showIntroduction()
    {
        let array = (["Welcome! Now we will learn about Commodites,",
                      "and how their fluctuating price affects currency",
                      "around the globe!",
                      ""])
        setSpeech(3, text: array)
        showSpeech()
    }
    
    func showPractice()
    {
        let array = (["You will soon see two types of goods enter the screen!!",
            "One is a commodity, the other is a manufactured good. Touch the screen to make",
            "the samurai slash them! Be sure to only slash the COMMODITIES!",
            "Get 3 in a row to show you know what a COMMODITY GOOD ACTUALLY IS!"])
        setSpeech(4, text: array)
        showSpeech()
    }
    
    func showInfoQuestion()
    {
        showInfoBox()
        hideInfoLabels(true)
        questionLabel1.text = "Touch the screen to reveal the types of imports and exports"
        questionLabel2.text = "that Japan deals in. Study them and then answer as to whether"
        questionLabel3.text = "you think Japans economy is driven by manufacturing or commodites?"
        questionLabel4.text = ""
        hideQuestionLabels(false)
        
    }
    
    func showInfoImportsExports()
    {
        hideQuestionLabels(true)
        importLabel1.text = "Silicon"
        importLabel2.text = "Steel"
        importLabel3.text = "Gold"
        importLabel4.text = ""
        
        exportLabel1.text = "Cars"
        exportLabel2.text = "Computers"
        exportLabel3.text = "Audio/Visual Equipment"
        exportLabel4.text = ""
        hideInfoLabels(false)
        
    }

    func processPlayerInput()
    {
        
        showSwipeEffect()
        if(state != .attacking)
        {
            if(elapsedTime > spawnTime)
            {
                elapsedTime = 0.0
                spawnIcon()
            }
        }
        
        switch(state)
        {
        case .ground:
            player.alpha = 1.0
            setPlayerTexture(playerIdle)
            playerPhysicsBody.velocity.dx = 0
            player.zRotation = 0
            break
        case .jumping:
            if playerPhysicsBody.velocity.dx > 0.0
            {
                player.xScale = 1
            }
            else
            {
                player.xScale = -1
            }
            player.zRotation = 0
            playerPhysicsBody.affectedByGravity = true
            playerPhysicsBody.velocity.dy *= 0.92
            playerPhysicsBody.velocity.dx *= 0.96
            if(playerPhysicsBody.velocity.dy < 0.0)
            {
                state = .falling
            }
            setPlayerTexture(playerJump)
            break
        case .falling:
            if playerPhysicsBody.velocity.dx > 0.0
            {
                player.xScale = 1
            }
            else
            {
                player.xScale = -1
            }
            player.zRotation = 0
            playerPhysicsBody.velocity.dy *= 1.1
            playerPhysicsBody.affectedByGravity = true
            setPlayerTexture(playerJump)
            
            break
        case .attacking:
            break
        case .hanging:
            playerPhysicsBody.affectedByGravity = false
            playerPhysicsBody.velocity = CGVector.zero
            break
        }
    }
    
    
    func showSwipeEffect()
    {
        if (touchNode != nil)
        {
            let newPos = CGPoint(x: touchNode!.position.x + touchStart.x, y: touchNode!.position.y + touchStart.y)
            touchNode!.position = newPos
           
            touchStart = CGPoint.zero
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {

        super.touchesBegan(touches, withEvent: event)
        
        if (touches.count > 1)
        {
            return
        }
            let touch = touches.first!
            let touchLocation = touch.locationInNode(self)
        
        
        if (playable)
        {
            placeTouchNode(touchLocation)
        }
    
        
            //print("THE STATUS IS : \(status)")
            switch(status)
            {
            case .Show:
                if !speechHidden()
                {
                    hideSpeech()
                    status = .Practice
                }
                break
            case .Practice:
                if !speechHidden()
                {
                    hideSpeech()
                    playable = true
                }
                break
            case .PracticeWin1:
                if(!speechHidden())
                {
                    hideSpeech()
                    status = .PracticeWin2
                }
                break
            case .PracticeWin2:
                if(!speechHidden())
                {
                    hideSpeech()
                    status = .InfoQuestion
                }
                break
            case .InfoQuestion:
                if(!isInfoHidden())
                {
                    status = .InfoAnswer
                }
                break
            case .InfoAnswer:
                for node in self.nodesAtPoint(touchLocation)
                {
                    let name  = node.name
                    if (name == "comButton" && !answerShown)
                    {
                        print("COMMIITY BUTTON")
                        showWrongAnswer()
                        answerShown = true
                    }
                    else if (name == "manButton" && !answerShown)
                    {
                        print("MANUFACTURING BUTTON")
                        showRightAnswer()
                        answerShown = true
                        break
                    }
                    else if (answerShown)
                    {
                        status = .RisingIntro
                        hideInfoBox()
                    }
                }
                break
            case .RisingIntro:
                if (!speechHidden())
                {
                    hideSpeech()
                    status = .Rising
                    playable = true
                }
            case .RisingEnd:
                if (!speechHidden())
                {
                    hideSpeech()
                    status = .FallingIntro
                }
            case .FallingIntro:
                if (!speechHidden())
                {
                    hideSpeech()
                    status = .Falling
                    spawnTime = 5.0
                    playable = true
                }
            default: break
            }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if(playable)
        {
            let touch = touches.first!
            let currentPoint = touch.locationInNode(self)
            let prevPoint = touch.previousLocationInNode(self)
            
            touchStart = CGPoint(x: currentPoint.x - prevPoint.x, y: currentPoint.y - prevPoint.y)
            touchBeginning = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if(playable)
        {
            touchNode!.emitter?.numParticlesToEmit = 250
            let timeToWait = NSTimeInterval(touchNode!.emitterLifeTime + (touchNode?.emitterLifeTimeRange)!/2)

            runAction(SKAction.sequence([SKAction.waitForDuration(timeToWait), SKAction.runBlock()
                {
                    self.removeTouchNode()
                }]))
            
            let touch = touches.first!
            let currentPoint = touch.locationInNode(self)
            let x = currentPoint.x - ((currentPoint.x - touchBeginning.x)/2)
            let y = currentPoint.y - ((currentPoint.y - touchBeginning.y)/2)
            let point = CGPointMake(x, y)
            jump(point)
        }
    }
    
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?)
    {
        if(playable)
        {
            touchNode!.emitter?.numParticlesToEmit = 250
            let timeToWait = NSTimeInterval(touchNode!.emitterLifeTime + (touchNode?.emitterLifeTimeRange)!/2)
            print("THE TIME IS : \(timeToWait)")
            runAction(SKAction.sequence([SKAction.waitForDuration(timeToWait), SKAction.runBlock()
                {
                    self.removeTouchNode()
                }]))
        }

    }
    
    func showWrongAnswer()
    {
        hideInfoLabels(true)
        questionLabel1.text = "Try Again! Remember what kind of goods Commidities are."
        questionLabel2.text = "If a nation imports commodities, its a Manufacturer."
        questionLabel3.text = "If a nation exports commodities, it a Commodity nation."
        status = .InfoQuestion
        hideQuestionLabels(false)
        
    }
    
    func showRightAnswer()
    {
        hideInfoLabels(true)
        questionLabel1.text = "Correct! Japan imports Commodities,"
        questionLabel2.text = "and it EXPORTS manufactured goods. "
        questionLabel3.text = "This means Japan has a manufacturing-based economy"
        hideQuestionLabels(false)
    }
    
    func jump(point : CGPoint)
    {
        
        var targetVector = CGVector(dx: point.x - player.position.x, dy: point.y - player.position.y)


        //chances are if this happens the player wants to double jump in the same direction
        if (targetVector.length() < 350.0)
        {
            targetVector = prevTargetVector
        }

        if(targetVector.dy > 0.0)
        {
            prevTargetVector = targetVector
        }
        if(state == .ground)
        {
            if targetVector.dy <= -0.1
            {

                return
            }
            else if targetVector.dy < 0.0
            {
                targetVector.dy = 0.1
            }
        }
        
        targetVector.normalize()
        print("THE GROUND JUMP IS: \(CGVector(dx: targetVector.dx * jumpingForce, dy: targetVector.dy * jumpingForce*1.5))")
        if (state == .ground)
        {
            playerPhysicsBody.applyImpulse(CGVector(dx: targetVector.dx * jumpingForce, dy: targetVector.dy * jumpingForce*1.5))
        }
        else if (state == .jumping || state == .hanging)
        {
            playerPhysicsBody.applyImpulse(CGVector(dx: targetVector.dx * jumpingForce, dy: targetVector.dy * jumpingForce*1.5))
        }
        else if (state == .falling)
        {
            playerPhysicsBody.velocity = CGVector.zero
            playerPhysicsBody.applyImpulse(CGVector(dx: targetVector.dx * jumpingForce, dy: targetVector.dy * jumpingForce*1.5))
        }
        state = .jumping

    }
    
    
    func isIdle() -> Bool
    {
        return playerPhysicsBody.velocity.dy < 0.1 && playerPhysicsBody.velocity.dy > -0.1
    }
    
    func spawnIcon()
    {
        let iconChoice = CGFloat(arc4random_uniform(101))
        let spawnChoice = arc4random_uniform(2)
        var spawn : CGPoint = CGPoint()
        var icon : SKSpriteNode = SKSpriteNode()
        if iconChoice < spawnChance
        {
            icon = getCommodity().copy() as! SKSpriteNode
            icon.physicsBody = iconPhysicsBody.copy() as? SKPhysicsBody
        }
        else if iconChoice >= spawnChance
        {
            icon = getManufactured().copy() as! SKSpriteNode
            icon.physicsBody = iconPhysicsBody.copy() as? SKPhysicsBody
        }
        
        if (spawnChoice == 0)
        {
            spawn = leftSpawn
        }
        else
        {
            spawn = rightSpawn
        }
        gameLayer.addChild(icon)
        icon.position = spawn
        icon.zPosition = player.zPosition - 1

        let name = icon.name!
        if (status == .Rising && name.hasSuffix("_com"))
        {
            if greenBar.size.height >= finalBarSize
            {
                playable = false
                resetPlayableScene()
                status = .RisingEnd
                return
            }
            scaleGraphs(greenBar, down: false)
            scaleGraphs(redBar, down: true)
        }
        else if (status == .Falling && name.hasSuffix("_man"))
        {
            if redBar.size.height >= finalBarSize
            {
                playable = false
                resetPlayableScene()
                status = .RisingEnd
                return
            }
            scaleGraphs(greenBar, down: true)
            scaleGraphs(redBar, down: false)
        }
        catapultIcon(icon, spawn: spawn)
        
    }
    
    func getCommodity() -> SKSpriteNode
    {
        var array = [SKSpriteNode]()
        for node in goodsArray
        {
            let name = node.name!
            if name.hasSuffix("_com")
            {
                array.append(node)
            }
        }
        
        let choice : Int = Int(arc4random_uniform(UInt32(array.count)))
        
        return array[choice]
    }
    
    func getManufactured() -> SKSpriteNode
    {
        var array = [SKSpriteNode]()
        for node in goodsArray
        {
            let name = node.name!
            if name.hasSuffix("_man")
            {
                array.append(node)
            }
        }
        
        let choice : Int = Int(arc4random_uniform(UInt32(array.count)))
        print("THE ARRAY COUNT IS: \(array.count)")
        return array[choice]
    }
    
    func scaleGraphs(node : SKSpriteNode, down : Bool)
    {
        var scaleY : CGFloat = 1.1
        if (down)
        {
            scaleY = 0.95
        }
        
        let scaleDown =  SKAction.scaleXBy(1, y: scaleY, duration: 0.1)
        
        node.runAction(scaleDown)
    }
    
    
    func catapultIcon(icon : SKSpriteNode, spawn : CGPoint)
    {
        let yOffset : CGFloat = CGFloat(getYOffset())
        var target = CGVector(dx: (frame.width/2 - spawn.x), dy: (((frame.height) - spawn.y) + yOffset))
        target.normalize()
        let forceOffset = CGFloat(getForceOffset())
        let force : CGFloat = 4000 * (forceOffset / 10)
        target = CGVector(dx: target.dx * (force * 2.5), dy: target.dy * (force * 2))
        icon.physicsBody?.mass = 5
        icon.physicsBody?.applyImpulse(target)
    }
    
    
    func getYOffset() -> UInt32
    {
        return 600 + arc4random_uniform(300)
    }
    
    func getForceOffset() -> UInt32
    {
        return (12 + arc4random_uniform(6))
    }
    
    //COLLISIONS
    func didBeginContact(contact: SKPhysicsContact)
    {
        if((contact.bodyA == self.physicsBody && contact.bodyB == playerPhysicsBody) ||
           (contact.bodyA == playerPhysicsBody && contact.bodyB == self.physicsBody))
        {
            if contact.bodyA == border
            {
                state = .hanging
                findHangPosition(contact.bodyA.node!)
            }
            else
            {
                state = .hanging
                findHangPosition(contact.bodyB.node!)
            }
        }
        
        //store commodities and manufactured names in seperate arrays
        var comNameArray = [String]()
        var manNameArray = [String]()
        for node in goodsArray
        {
            let name = node.name!
            if (name.hasSuffix("_com"))
            {
                comNameArray.append(name)
            }
            else
            {
                manNameArray.append(name)
            }
        }
        
        //if player makes contact with any icons
        if(((manNameArray.contains(contact.bodyA.node!.name!) || (comNameArray.contains(contact.bodyA.node!.name!)) && contact.bodyB == playerPhysicsBody) ||
        (contact.bodyA == playerPhysicsBody && (manNameArray.contains(contact.bodyB.node!.name!) || comNameArray.contains(contact.bodyB.node!.name!) ))))
        {
            if (state != .ground && state != .hanging && state != .attacking)
            {
                state = .attacking
                if (contact.bodyA == playerPhysicsBody)
                {
                    destroyIcon((contact.bodyB.node as? SKSpriteNode)!)
                }
                else
                {
                    destroyIcon((contact.bodyA.node as? SKSpriteNode)!)
                }
            }
        }
        
        if((contact.bodyA ==  platformPhysicsBody && contact.bodyB == playerPhysicsBody) ||
            (contact.bodyA == playerPhysicsBody && contact.bodyB == platformPhysicsBody))
        {
            playerPhysicsBody.velocity = CGVector.zero
            state = .ground
        }
    }
    
    func findHangPosition(node : SKNode)
    {
        let pos = player.position
        if (pos.y < 700)
        {
            //too low to hang
            state = .falling
            return
        }
        
        if(pos.x < 200)
        {
            attach("left")
        
        }
        else if (pos.x > frame.width - 200)
        {
            attach("right")
        }
        else
        {
            attach("up")
        }
    }
    
    func attach(direction : String)
    {
        setPlayerTexture(playerHang)
        switch(direction)
        {
        case "left":
            player.runAction(SKAction.rotateByAngle(CGFloat(-M_PI/2), duration: 0.0))
            break
        case "right":

            player.runAction(SKAction.rotateByAngle(CGFloat(M_PI/2), duration: 0.0))
            break
        case "up":
            player.runAction(SKAction.rotateByAngle(CGFloat(M_PI), duration: 0.0))
            break
        default: break
        }
        
        playerPhysicsBody.affectedByGravity = false
        playerPhysicsBody.velocity = CGVector.zero
        
    }
    
    func destroyIcon(node : SKSpriteNode)
    {
        let name = node.name!
        if (name.hasSuffix("_com") && status == .Practice)
        {
            practiceCount++
            playerHurt = false
            runAction(getHitSound(playerHurt))
        }
        else if (name.hasSuffix("_man") && status == .Practice)
        {
            playerHurt = true
            runAction(getHitSound(playerHurt))
        }
        else if (name.hasSuffix("_com") && status == .Rising)
        {
            playerHurt = false
            runAction(getHitSound(playerHurt))
            calculateSpawnRate()
            spawnChance += 5
            if spawnChance >= 90
            {
                spawnChance = 90
            }
        }
        else if (name.hasSuffix("_man") && status == .Rising)
        {
            playerHurt = true
            runAction(getHitSound(playerHurt))
            
        }
        else if (name.hasSuffix("_man") && status == .Falling)
        {
            playerHurt = false
            runAction(getHitSound(playerHurt))
            calculateSpawnRate()
            print("THE CURRENT SPAWN CHANCE IS: \(spawnChance)")
            spawnChance -= 5
            if spawnChance <= 10
            {
                spawnChance = 10
            }
        }
        else if (name.hasSuffix("_com") && status == .Falling)
        {
            playerHurt = true
            runAction(getHitSound(playerHurt))
        }

        
       
        if (!playerHurt)
        {
            resolveAttack(node, hurt: false)
        }
        else
        {
            resolveAttack(node, hurt: true)
        }
    }
    
    func resolveAttack(node : SKSpriteNode, hurt : Bool)
    {
        
        let prevScale = player.xScale
        if node.position.x > player.position.x
        {
            player.xScale = -1
        }
        else
        {
            player.xScale = 1
        }
        var playerPrevVel = playerPhysicsBody.velocity
        let nodePrevVelocity = node.physicsBody?.velocity
        playerPhysicsBody.affectedByGravity = false
        playerPhysicsBody.velocity = CGVector.zero
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.velocity = CGVector.zero
        player.runAction(
            SKAction.sequence([SKAction.waitForDuration(1),
                SKAction.runBlock()
                    {
                        self.setPlayerTexture(self.playerAttack)
                },
                SKAction.waitForDuration(0.5),
                SKAction.runBlock()
                    {
                        node.physicsBody?.contactTestBitMask = 0x1 << 10
                        node.physicsBody?.affectedByGravity = true
                        if (!hurt)
                        {
                            node.physicsBody?.velocity = CGVector.zero
                            node.runAction(self.flash(node))
                            playerPrevVel.dy = 0.0
                            self.playerPhysicsBody.affectedByGravity = true
                            self.playerPhysicsBody.velocity = playerPrevVel
                        }
                        else
                        {
                            node.physicsBody?.velocity = nodePrevVelocity!
                            self.playerPhysicsBody.velocity = CGVector.zero
                            self.playerPhysicsBody.affectedByGravity = true
                            self.player.runAction(self.flash(self.player), completion: {self.playerHurt = false})
                        }
                        self.player.xScale = prevScale
                        self.state = .falling
                        if self.practiceCount >= 4
                        {
                            self.playable = false
                            self.resetPlayableScene()
                            self.status = .PracticeWin1
                        }
                        
                }
                ])
        )
    }
    
    func resetPlayableScene()
    {
        state = .ground
        setPlayerTexture(playerIdle)
        let rotation = SKAction.rotateToAngle(0.0, duration: 0.0)
        let move = SKAction.moveTo(playerSpawn, duration: 0.0)
        player.runAction(SKAction.group([rotation, move]))
        playerPhysicsBody.affectedByGravity = true
        playerPhysicsBody.velocity = CGVector.zero
        var name = String()
        for node in self.children
        {
            name = node.name!
            if name.hasSuffix("_com") || name.hasSuffix("_man")
            {
                node.removeAllActions()
                node.removeFromParent()
            }
        }
        practiceCount = 0
        
    }
    
    func setPlayerTexture(tex : SKTexture)
    {
        player.texture = tex
        if playerPhysicsBody.velocity.dx > 0.0 && state != .hanging
        {
            player.xScale = -1
        }
    }
    
    func flash(node : SKSpriteNode) -> SKAction
    {
        let fadeOut = SKAction.fadeAlphaTo(0.1, duration: 0.05)
        let fadeIn = SKAction.fadeAlphaTo(0.75, duration: 0.05)
        let fadeSequence = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatAction(fadeSequence, count: 20)
    }
    
    func placeTouchNode(position : CGPoint)
    {
        print("THE POSITION IS: \(position)")
        touchNode = Swipe(position: position, target: hudLayer)
        self.addChild(touchNode!)
    }
    
    func removeTouchNode()
    {
        touchStart = CGPointZero
        touchNode!.removeFromParent()
    }
    
    func playMusic(fileName : String)
    {
        
        
        let url = NSBundle.mainBundle().URLForResource(fileName, withExtension: nil)
        
        if (url != nil)
        {
            //var error: NSError? = nil
            
            do
            {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: url!)
                //} catch let error1 as NSError {
            } catch _ as NSError
            {
                //error = error1
                backgroundMusicPlayer = nil
            }
            
        }
        
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()

    }
    
    func getHitSound(playerHurt : Bool) -> SKAction
    {
        let hit = SKAction.playSoundFileNamed("SFX_hit", waitForCompletion: false)
        var result = SKAction()
        
        if (!playerHurt)
        {
            let sfxChoice = arc4random_uniform(3)
            switch (sfxChoice)
            {
            case 0:
                result = SKAction.playSoundFileNamed(sfxArray[0], waitForCompletion: false)
            case 1:
                result = SKAction.playSoundFileNamed(sfxArray[1], waitForCompletion: false)
            case 2:
                result = SKAction.playSoundFileNamed(sfxArray[2], waitForCompletion: false)
            default: break
            }
        }
        else
        {
            result = SKAction.playSoundFileNamed("SFX_playerHurt.mp3", waitForCompletion: false)
        }
        
        let sequence = SKAction.sequence([hit, SKAction.waitForDuration(1), result])
        return sequence
    }
    
    func stopMusic()
    {
        if (backgroundMusicPlayer != nil)
        {
            backgroundMusicPlayer.stop()
        }
    }
}