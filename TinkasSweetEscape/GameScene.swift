import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var girl: SKSpriteNode!
    var policeman: SKSpriteNode!
    var groundTiles: [SKSpriteNode] = []
    var pinkHearts: [SKSpriteNode] = []
    var grayHearts: [SKSpriteNode] = []
    var collectibles: [SKSpriteNode] = []
    
    let scrollSpeed: CGFloat = 100
    let maxHearts = 10
    var pinkHeartCount = 3
    var spawnTimer: TimeInterval = 0
    let candyTypes = ["candy", "choco", "gummygreen", "gummyorange", "lollipop", "stick"]
    static var lastCandy: String?
    
    override func didMove(to view: SKView) {
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
        setupBackground()
        setupHearts()
        setupGround()
        setupGirlAndPoliceman()
    }
    
    private func setupBackground() {
        let bg = SKSpriteNode(imageNamed: "background")
        bg.size = self.size
        bg.position = CGPoint(x: size.width / 2, y: size.height / 2)
        bg.zPosition = -1
        addChild(bg)
    }
    
    private func setupHearts() {
        pinkHearts.forEach { $0.removeFromParent() }
        grayHearts.forEach { $0.removeFromParent() }
        pinkHearts.removeAll()
        grayHearts.removeAll()
        
        let heartSize = CGSize(width: 28, height: 28)
        let spacing: CGFloat = 8
        let totalWidth = CGFloat(maxHearts) * heartSize.width + CGFloat(maxHearts - 1) * spacing
        let startX = (size.width - totalWidth) / 2
        
        for i in 0..<maxHearts {
            let x = startX + CGFloat(i) * (heartSize.width + spacing)
            let gray = SKSpriteNode(imageNamed: "decorheartgray")
            gray.size = heartSize
            gray.anchorPoint = CGPoint(x: 0, y: 1)
            gray.position = CGPoint(x: x, y: size.height - 80)
            gray.zPosition = 9
            addChild(gray)
            grayHearts.append(gray)
            
            let pink = SKSpriteNode(imageNamed: "heart")
            pink.size = heartSize
            pink.anchorPoint = gray.anchorPoint
            pink.position = gray.position
            pink.zPosition = 10
            pink.isHidden = i >= pinkHeartCount
            addChild(pink)
            pinkHearts.append(pink)
        }
    }
    
    private func setupGround() {
        let tileTexture = SKTexture(imageNamed: "floating")
        let visibleWidth: CGFloat = 80
        let scale = visibleWidth / tileTexture.size().width
        let tileCount = Int(ceil(size.width / visibleWidth)) + 2
        
        for i in 0..<tileCount {
            let tile = SKSpriteNode(texture: tileTexture)
            tile.setScale(scale)
            tile.anchorPoint = CGPoint(x: 0, y: 0)
            tile.position = CGPoint(x: CGFloat(i) * visibleWidth, y: 60)
            tile.zPosition = 2
            addChild(tile)
            groundTiles.append(tile)
        }
        
        let solid = SKNode()
        solid.position = CGPoint(x: size.width / 2, y: 90)
        solid.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width, height: 20))
        solid.physicsBody?.isDynamic = false
        solid.physicsBody?.categoryBitMask = 2
        addChild(solid)
    }
    
    private func setupGirlAndPoliceman() {
        let girlTexture = SKTexture(imageNamed: "girl")
        girl = SKSpriteNode(texture: girlTexture)
        let height: CGFloat = 90
        let aspect = girlTexture.size().width / girlTexture.size().height
        girl.size = CGSize(width: height * aspect, height: height)
        girl.position = CGPoint(x: 160, y: 120)
        girl.zPosition = 5
        girl.physicsBody = SKPhysicsBody(rectangleOf: girl.size)
        girl.physicsBody?.affectedByGravity = true
        girl.physicsBody?.allowsRotation = false
        girl.physicsBody?.restitution = 0.0
        girl.physicsBody?.categoryBitMask = 1
        girl.physicsBody?.contactTestBitMask = 4 | 8
        girl.physicsBody?.collisionBitMask = 2
        addChild(girl)
        
        let policeTexture = SKTexture(imageNamed: "policeman")
        policeman = SKSpriteNode(texture: policeTexture)
        let pHeight: CGFloat = 80
        let pAspect = policeTexture.size().width / policeTexture.size().height
        policeman.size = CGSize(width: pHeight * pAspect, height: pHeight)
        policeman.position = CGPoint(x: girl.position.x - 100, y: 120)
        policeman.zPosition = 4
        addChild(policeman)
    }
    
    private func spawnCollectible() {
        let isCandy = Bool.random()
        let imageName: String
        if isCandy {
            var newCandy: String
            repeat {
                newCandy = candyTypes.randomElement()!
            } while newCandy == GameScene.lastCandy
            GameScene.lastCandy = newCandy
            imageName = newCandy
        } else {
            imageName = "handcuffs"
        }
        
        let texture = SKTexture(imageNamed: imageName)
        let height: CGFloat = isCandy ? 40 : 50
        let aspect = texture.size().width / texture.size().height
        let fixedSize = CGSize(width: height * aspect, height: height)
        
        let item = SKSpriteNode(texture: texture)
        item.size = fixedSize
        item.position = CGPoint(x: size.width + 60, y: CGFloat.random(in: 280...350))
        item.zPosition = 6
        item.name = isCandy ? "candy" : "trap"
        item.physicsBody = SKPhysicsBody(rectangleOf: fixedSize)
        item.physicsBody?.isDynamic = false
        item.physicsBody?.categoryBitMask = isCandy ? 4 : 8
        item.physicsBody?.contactTestBitMask = 1
        item.physicsBody?.collisionBitMask = 0
        addChild(item)
        collectibles.append(item)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if abs(girl.physicsBody!.velocity.dy) < 0.1 {
            girl.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 250))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        let dt: CGFloat = 1.0 / 60.0
        
        for tile in groundTiles {
            tile.position.x -= scrollSpeed * dt
            if tile.position.x + tile.size.width < 0 {
                if let maxX = groundTiles.max(by: { $0.position.x < $1.position.x }) {
                    tile.position.x = maxX.position.x + tile.size.width
                }
            }
        }
        
        for (index, item) in collectibles.enumerated().reversed() {
            item.position.x -= scrollSpeed * dt
            if item.position.x < -100 {
                item.removeFromParent()
                collectibles.remove(at: index)
            }
        }
        
        spawnTimer += dt
        if spawnTimer >= 1.3 {
            spawnCollectible()
            spawnTimer = 0
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node,
              let nodeB = contact.bodyB.node else { return }
        
        let other = (nodeA == girl) ? nodeB : nodeA
        
        if other.name == "candy" {
            if pinkHeartCount < maxHearts {
                pinkHearts[pinkHeartCount].isHidden = false
                pinkHeartCount += 1
            }
        } else if other.name == "trap" {
            if pinkHeartCount > 0 {
                pinkHeartCount -= 1
                pinkHearts[pinkHeartCount].isHidden = true
            }
        }
        
        if let index = collectibles.firstIndex(of: other as! SKSpriteNode) {
            collectibles.remove(at: index)
        }
        other.removeFromParent()
        
        if pinkHeartCount >= maxHearts {
            freezeAndTransition(to: .win)
        } else if pinkHeartCount <= 0 {
            freezeAndTransition(to: .gameOver)
        }
    }
    
    enum EndState {
        case win, gameOver
    }
    
    private func freezeAndTransition(to endState: EndState) {
        girl.physicsBody?.velocity = .zero
        girl.isPaused = true
        policeman.isPaused = true
        isUserInteractionEnabled = false
        collectibles.forEach { $0.isPaused = true }
        
        run(SKAction.wait(forDuration: 0.8)) {
            guard let view = self.view else { return }
            
            let nextScene: SKScene
            switch endState {
            case .win:
                nextScene = WinScene(size: view.bounds.size)
            case .gameOver:
                nextScene = GameOverScene(size: view.bounds.size)
            }
            
            nextScene.scaleMode = .aspectFill
            view.presentScene(nextScene, transition: .crossFade(withDuration: 0.5))
        }
    }
}
