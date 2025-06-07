import SpriteKit

class StartScene: SKScene {
    override func didMove(to view: SKView) {
        // Background with height-based scaling
        let bg = SKSpriteNode(imageNamed: "startbg")
        bg.zPosition = -1
        bg.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        // Always scale background by height while maintaining aspect ratio
        let textureAspect = bg.texture!.size().width / bg.texture!.size().height
        bg.size = CGSize(width: size.height * textureAspect, height: size.height)
        addChild(bg)
        
        // Title - "Valeria's Sweet Escape"
        let title = SKSpriteNode(imageNamed: "title")
        // Based on the reference, title takes about 70% of screen width
        let titleWidth = size.width * 0.7
        let titleAspect = title.texture!.size().width / title.texture!.size().height
        title.size = CGSize(width: titleWidth, height: titleWidth / titleAspect)
        
        // Position at exactly 75% height to match reference
        title.position = CGPoint(x: size.width / 2, y: size.height * 0.6)
        title.zPosition = 1
        addChild(title)
        
        // Characters positioned at the center of the screen
        // Policeman (left character)
        let policeman = SKSpriteNode(imageNamed: "policeman")
        let policemanHeight = size.height * 0.15
        let policemanAspect = policeman.texture!.size().width / policeman.texture!.size().height
        policeman.size = CGSize(width: policemanHeight * policemanAspect, height: policemanHeight)
        policeman.position = CGPoint(x: size.width / 2 - 60, y: size.height * 0.4)
        policeman.zPosition = 1
        addChild(policeman)
        
        // Girl (right character)
        let girl = SKSpriteNode(imageNamed: "girl")
        let girlHeight = size.height * 0.15
        let girlAspect = girl.texture!.size().width / girl.texture!.size().height
        girl.size = CGSize(width: girlHeight * girlAspect, height: girlHeight)
        girl.position = CGPoint(x: size.width / 2 + 60, y: size.height * 0.4)
        girl.zPosition = 1
        addChild(girl)
        
        // Start Button - positioned lower to match reference
        let start = SKSpriteNode(imageNamed: "start")
        start.name = "startButton"
        let startWidth = size.width * 0.6
        let startAspect = start.texture!.size().width / start.texture!.size().height
        start.size = CGSize(width: startWidth, height: startWidth / startAspect)
        start.position = CGPoint(x: size.width / 2, y: size.height * 0.23)
        start.zPosition = 1
        addChild(start)
        
        // Add animation to the start button for visual appeal
        let scaleUp = SKAction.scale(to: 1.05, duration: 0.8)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.8)
        let pulse = SKAction.sequence([scaleUp, scaleDown])
        let pulseContinuously = SKAction.repeatForever(pulse)
        start.run(pulseContinuously)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            if node.name == "startButton" {
                // Add a simple tap animation before transitioning
                let scaleDown = SKAction.scale(by: 0.9, duration: 0.1)
                let scaleUp = SKAction.scale(by: 1.1, duration: 0.1)
                let scaleSequence = SKAction.sequence([scaleDown, scaleUp])
                
                node.run(scaleSequence) {
                    let gameScene = GameScene(size: self.size)
                    gameScene.scaleMode = .aspectFill
                    self.view?.presentScene(gameScene, transition: SKTransition.fade(withDuration: 0.5))
                }
            }
        }
    }
}
