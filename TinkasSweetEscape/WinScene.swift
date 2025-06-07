import SpriteKit

class WinScene: SKScene {
    override func didMove(to view: SKView) {
        // Background with proper scaling
        let bg = SKSpriteNode(imageNamed: "winbg")
        bg.zPosition = -1
        bg.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        // Scale by height to maintain aspect ratio
        let textureAspect = bg.texture!.size().width / bg.texture!.size().height
        bg.size = CGSize(width: size.height * textureAspect, height: size.height)
        addChild(bg)
        
        // Happy face at the top
        let face = SKSpriteNode(imageNamed: "happy")
        let faceHeight = size.height * 0.25
        let faceAspect = face.texture!.size().width / face.texture!.size().height
        face.size = CGSize(width: faceHeight * faceAspect, height: faceHeight)
        face.position = CGPoint(x: size.width/2, y: size.height * 0.68)
        face.zPosition = 1
        addChild(face)
        
        // "YOU WIN!" text
        // Using a sprite node instead of text for exact match with reference
        let win = SKSpriteNode(imageNamed: "win")
        let winWidth = size.width * 0.6
        let winAspect = win.texture!.size().width / win.texture!.size().height
        win.size = CGSize(width: winWidth, height: winWidth / winAspect)
        win.position = CGPoint(x: size.width/2, y: size.height * 0.40)
        win.zPosition = 1
        addChild(win)
        
        // BIGGER BUTTONS with same height
        let buttonHeight = size.height * 0.10
        
        // Home button (left)
        let home = SKSpriteNode(imageNamed: "home")
        let homeAspect = home.texture!.size().width / home.texture!.size().height
        home.size = CGSize(width: buttonHeight * homeAspect, height: buttonHeight)
        home.name = "home"
        home.position = CGPoint(x: size.width/2 - 60, y: size.height * 0.22)
        home.zPosition = 1
        addChild(home)
        
        // Restart button (right)
        let restart = SKSpriteNode(imageNamed: "refresh")
        let restartAspect = restart.texture!.size().width / restart.texture!.size().height
        restart.size = CGSize(width: buttonHeight * restartAspect, height: buttonHeight)
        restart.name = "restart"
        restart.position = CGPoint(x: size.width/2 + 60, y: size.height * 0.22)
        restart.zPosition = 1
        addChild(restart)
        
        // Add button highlight animation with SLOWER speed
        let scaleUp = SKAction.scale(to: 1.1, duration: 1.0)   // Slowed down from 0.5 to 1.2
        let scaleDown = SKAction.scale(to: 1.0, duration: 1.0) // Slowed down from 0.5 to 1.2
        let pulse = SKAction.sequence([scaleUp, scaleDown])
        let pulseContinuously = SKAction.repeatForever(pulse)
        
        home.run(pulseContinuously)
        restart.run(pulseContinuously)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            if node.name == "restart" {
                // Button press animation
                let scaleDown = SKAction.scale(by: 0.9, duration: 0.15) // Slowed down
                let scaleUp = SKAction.scale(to: 1.0, duration: 0.15)   // Slowed down
                let scaleSequence = SKAction.sequence([scaleDown, scaleUp])
                
                node.run(scaleSequence) {
                    // Create a new GameScene instance (not from file)
                    let gameScene = GameScene(size: self.size)
                    gameScene.scaleMode = .aspectFill
                    self.view?.presentScene(gameScene, transition: SKTransition.fade(withDuration: 0.5))
                }
            } else if node.name == "home" {
                // Button press animation
                let scaleDown = SKAction.scale(by: 0.9, duration: 0.15) // Slowed down
                let scaleUp = SKAction.scale(to: 1.0, duration: 0.15)   // Slowed down
                let scaleSequence = SKAction.sequence([scaleDown, scaleUp])
                
                node.run(scaleSequence) {
                    // Create a new StartScene instance (not from file)
                    let startScene = StartScene(size: self.size)
                    startScene.scaleMode = .aspectFill
                    self.view?.presentScene(startScene, transition: SKTransition.fade(withDuration: 0.5))
                }
            }
        }
    }
}
