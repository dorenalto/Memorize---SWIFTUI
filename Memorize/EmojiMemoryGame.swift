//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 21/06/26.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    // MARK: - Themes
    enum Theme: String, CaseIterable {
        case halloween = "🎃"
        case animals = "🐶"
        case food = "🍕"
        case sports = "⚽"
        case flags = "🏳️"
        case faces = "😊"
        
        var emojis: [String] {
            switch self {
            case .halloween: return ["👻", "🎃", "🕷️", "🧛", "🦇", "🍬", "💀", "⚰️"]
            case .animals: return ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"]
            case .food: return ["🍕", "🍔", "🌮", "🥗", "🍣", "🥩", "🍝", "🧁"]
            case .sports: return ["⚽", "🏀", "🏈", "⚾", "🎾", "🏐", "🏓", "🎱"]
            case .flags: return ["🇧🇷", "🇺🇸", "🇯🇵", "🇩🇪", "🇫🇷", "🇮🇹", "🇪🇸", "🇬🇧"]
            case .faces: return ["😊", "😂", "🤣", "😍", "🥰", "😎", "🤩", "😇"]
            }
        }
        
        var color: Color {
            switch self {
            case .halloween: return .orange
            case .animals: return .green
            case .food: return .red
            case .sports: return .blue
            case .flags: return .yellow
            case .faces: return .purple
            }
        }
        
        var name: String {
            switch self {
            case .halloween: return "Halloween"
            case .animals: return "Animals"
            case .food: return "Food"
            case .sports: return "Sports"
            case .flags: return "Flags"
            case .faces: return "Faces"
            }
        }
    }
    
    @Published private var model: MemoryGame<String>
    @Published var currentTheme: Theme
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var themeColor: Color {
        currentTheme.color
    }
    
    var themeName: String {
        currentTheme.name
    }
    
    // MARK: - Intent
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = createMemoryGame(theme: currentTheme)
    }
    
    func changeTheme(to theme: Theme) {
        currentTheme = theme
        model = createMemoryGame(theme: theme)
    }
    
    // MARK: - Private
    
    private func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis = theme.emojis.shuffled()
        let numberOfPairs = Int.random(in: 4...8)
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    // MARK: - Initialization
    
    init() {
        let initialTheme = Theme.halloween
        self.currentTheme = initialTheme
        self.model = MemoryGame<String>(numberOfPairsOfCards: 4) { _ in "👻" }
        self.model = createMemoryGame(theme: initialTheme)
    }
}
