# Tinka's Sweet Escape

A goal-based runner iOS game where players help Valeria collect exactly 10 hearts to escape from a persistent policeman. Collect candies to gain hearts while avoiding handcuffs. Built with SwiftUI and SpriteKit.

## 🎮 Game Features

- **Goal-Based Gameplay** - Collect exactly 10 hearts to win the game
- **Heart System** - Collect candies to gain hearts, lose hearts when caught by handcuffs
- **Multiple Candy Types** - 6 different candy varieties with smart randomization
- **Dynamic Spawning** - Procedurally generated obstacles and collectibles
- **Multiple Scenes** - Start screen, gameplay, win screen, and game over screen
- **iOS Optimized** - Native Swift performance with SpriteKit physics
- **Universal Support** - Works on iPhone and iPad

## 🍭 Gameplay

- **Objective**: Help Valeria collect 10 hearts to win by gathering candies
- **Controls**: Tap anywhere to make Valeria jump
- **Collectibles**: 
  - 🍬 **Candies**: candy, choco, gummygreen, gummyorange, lollipop, stick
  - 👮 **Handcuffs**: Avoid these or lose hearts
- **Win Condition**: Collect 10 hearts total
- **Lose Condition**: Lose all hearts to handcuffs

## 🚀 Quick Start

### Requirements
- Xcode 16.3+
- iOS 17.6+
- Swift 5.0+

### Installation
```bash
git clone https://github.com/sangreal-007/game-sweet-escape.git
cd game-sweet-escape
open TinkasSweetEscape.xcodeproj
```

Build and run on device or simulator using Xcode.

## 🛠️ Technology Stack

- **Framework**: SwiftUI + SpriteKit
- **Language**: Swift 5.0
- **Physics**: SpriteKit Physics Engine
- **Graphics**: 2D Sprite-based rendering
- **Architecture**: Scene-based game structure
- **Testing**: XCTest framework with UI tests
- **Deployment**: iOS 17.6+ (iPhone & iPad)

## 📂 Project Structure

```
TinkasSweetEscape/
├── TinkasSweetEscapeApp.swift     # App entry point
├── GameView.swift                 # SwiftUI wrapper for SpriteKit
├── StartScene.swift              # Main menu scene
├── GameScene.swift               # Core gameplay scene
├── WinScene.swift                # Victory screen
├── GameOverScene.swift           # Game over screen
├── Preview.swift                 # SwiftUI previews for development
├── GameViewController.swift       # Legacy UIKit controller
├── Assets/                       # Game sprites and images
├── TinkasSweetEscapeTests/       # Unit tests
└── TinkasSweetEscapeUITests/     # UI automation tests
```

## 🎨 Game Assets

The game includes custom sprite artwork for:
- **Characters**: Valeria (girl), Policeman
- **Collectibles**: 6 candy types, handcuffs
- **UI Elements**: Hearts, buttons, title graphics
- **Backgrounds**: Start screen, gameplay, win/lose screens
- **Ground Tiles**: Floating platform graphics

## 🎯 Game Mechanics

### Physics System
- Gravity-based jumping mechanics
- Collision detection for collectibles
- Ground collision boundaries
- Smooth scrolling background

### Spawning Algorithm
- Randomized candy/trap generation
- Smart candy type rotation (prevents consecutive duplicates)
- Timed spawning intervals (1.3 seconds)
- Vertical positioning variation
- Game ends when player reaches 10 hearts or loses all hearts

### Heart System
- Visual heart display (pink/gray states)
- Dynamic heart count updates
- Win condition at 10 hearts
- Lose condition at 0 hearts

## 📱 Device Support

- **iPhone**: iOS 17.6+ (Optimized for iPhone 14/15 - 390x844)
- **iPad**: iOS 17.6+ with universal layout
- **Orientations**: Portrait, Landscape Left, Landscape Right
- **Status Bar**: Hidden for immersive gameplay

## 🎵 Audio

Ready for sound integration:
- Sound effect hooks in collision detection
- Background music support in scene setup
- Button press audio feedback points

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request


## 🎮 Game Design

**Tinka's Sweet Escape** combines classic runner mechanics with a goal-oriented challenge. Players must strategically collect candies to reach exactly 10 hearts while avoiding the policeman's handcuffs - creating a finite, winnable game experience.

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/sangreal-007/game-sweet-escape/issues)
- **Developer**: Daria Iaparova

## ⚠️ Development Notes

- Game uses procedural generation for varied gameplay
- Physics simulation ensures realistic jumping mechanics  
- Smart asset loading prevents memory issues
- Scene transitions provide smooth user experience
- Finite game design with clear win/lose conditions
