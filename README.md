Desenvolvimento em SWIFTUI

Jogo da memoria em SwiftUI

# 🧠 Memorize

A classic memory card game built with SwiftUI, featuring multiple themes, score tracking, and bonus time mechanics.

![Platform](https://img.shields.io/badge/platform-iOS-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0-blueviolet)
![Xcode](https://img.shields.io/badge/Xcode-15.0-green)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

---

## 📱 About the Game

Memorize is a digital version of the classic memory card game. The goal is to find all matching pairs of cards. The game includes:

- **6 different themes** with unique emoji sets
- **Bonus points** for finding matches quickly
- **Score penalties** for wrong guesses
- **Beautiful animations** with card flips and transitions
- **Victory celebration** when you complete the game

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🎯 **Memory Game** | Classic card matching gameplay |
| 🎨 **6 Themes** | Halloween, Animals, Food, Sports, Flags, Faces |
| ⏱️ **Bonus System** | Earn bonus points for quick matches |
| 📊 **Score Tracking** | Real-time score updates with penalties |
| 🔄 **New Game** | Reset the game with the same theme |
| 🏆 **Victory Screen** | Celebration when you win |
| 📱 **Responsive** | Works on iPhone and iPad |

---

## 🎮 How to Play

1. **Start the game** - Cards appear face down on the screen
2. **Tap a card** - It flips to reveal an emoji
3. **Find matches** - Tap two cards with the same emoji
4. **Earn bonuses** - Match cards quickly for extra points ⏱️
5. **Avoid penalties** - Wrong guesses cost you points ❌
6. **Win the game** - Match all pairs to see the victory screen 🎉
7. **Change themes** - Tap the "Themes" button to try different emojis

---

## 🏗️ Architecture

The project follows the **MVVM (Model-View-ViewModel)** pattern:

---

## 🚀 Requirements

| Requirement | Version |
|-------------|---------|
| iOS | 17.0+ |
| iPadOS | 17.0+ |
| Xcode | 15.0+ |
| Swift | 5.9+ |
| SwiftUI | 4.0+ |

---

## 📦 Installation

### 1. Clone the repository

```bash
git clone https://github.com/SEU_USUARIO/Memorize.git
cd Memorize

2. Open the project
open Memorize.xcodeproj

3. Build and run
Select a simulator or device

Press Cmd + R or click the play button ▶️

🧪 Running Tests
Open the project
# Via Xcode
Cmd + U

# Via command line
xcodebuild test -scheme Memorize -destination 'platform=iOS Simulator,name=iPhone 15 Pro'

🛠️ Technologies Used
Technology                  Purpose
SwiftUI                     Declarative UI framework
Combine                     Reactive state management
XCTest                      Unit and performance testing
Core Animation              Card flip and rotation effects
Swift Package Manager       Dependency management

🎨 Themes
Theme                  Emojis                  Color
🎃 Halloween        👻🎃🕷️🧛🦇🍬💀⚰️          Orange
🐶 Animals          🐶🐱🐭🐹🐰🦊🐻🐼          Green
🍕 Food             🍕🍔🌮🥗🍣🥩🍝🧁          Red
⚽ Sports           ⚽🏀🏈⚾🎾🏐🏓🎱          Blue
🏳️ Flags            🇧🇷🇺🇸🇯🇵🇩🇪🇫🇷🇮🇹🇪🇸🇬🇧          Yellow
😊 Faces            😊😂🤣😍🥰😎🤩😇          Purple

📸 Screenshots
Game Screen                     Theme Picker                     Victory Screen
https://Screenshots/game.png    https://Screenshots/theme.png    https://Screenshots/victory.png


🔮 Future Improvements
Add sound effects for card flips and matches

Implement confetti animation on victory

Add difficulty levels (easy, medium, hard)

Save high scores using UserDefaults

Add multiplayer mode

Achievements system

iCloud sync for progress

Widget showing daily challenge

🤝 Contributing
Contributions are welcome! Here's how you can help:

Fork the repository

Create a feature branch: git checkout -b feature/AmazingFeature

Commit your changes: git commit -m 'Add some AmazingFeature'

Push to the branch: git push origin feature/AmazingFeature

Open a Pull Request

📝 License
This project is licensed under the MIT License - see the LICENSE file for details.

👨‍💻 Author
Dorenalto Mangueira Couto

Platform    Link
💼 LinkedIn    linkedin.com/in/dorenalto
🐙 GitHub    github.com/dorenalto
📧 Email    dorenalto@gmail.com
🙏 Acknowledgments
Stanford CS193p - Course that inspired this project

SwiftUI Community - For amazing resources and examples

All contributors - For testing and feedback

⭐ Show Your Support
If you found this project helpful, please give it a ⭐ on GitHub!
