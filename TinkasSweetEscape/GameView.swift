import SwiftUI
import SpriteKit

struct GameView: View {
    var scene: SKScene {
        let scene = StartScene(size: CGSize(width: 390, height: 844)) // iPhone 14/15 size
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

#Preview {
    GameView()
}
