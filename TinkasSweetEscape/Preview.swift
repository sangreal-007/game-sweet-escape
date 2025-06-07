//
//  Preview.swift
//  TinkasSweetEscape
//
//  Created by Daria Iaparova on 06/05/25.
//

import SwiftUI
import SpriteKit

struct ScenePreview: View {
    var scene: SKScene {
        // Change this to preview a different scene
//        let scene = WinScene(size: CGSize(width: 390, height: 844))
//        let scene = GameOverScene(size: CGSize(width: 390, height: 844))
        let scene = StartScene(size: CGSize(width: 390, height: 844))
//        let scene = WinScene(size: CGSize(width: 390, height: 844))
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

#Preview {
    ScenePreview()
}
