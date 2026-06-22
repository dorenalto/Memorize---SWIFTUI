//
//  MemoryGame.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 21/06/26.
//
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    private(set) var numberOfPairs: Int
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // Já existe uma carta virada para cima - verificar match
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // MATCH! ✅
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    // Bônus por match rápido
                    score += 2 + Int(cards[chosenIndex].bonusRemaining * 10)
                } else {
                    // NO MATCH! ❌ - Penalidade por erro
                    if !cards[chosenIndex].hasBeenSeen {
                        cards[chosenIndex].hasBeenSeen = true
                    } else {
                        score -= 1
                    }
                    if !cards[potentialMatchIndex].hasBeenSeen {
                        cards[potentialMatchIndex].hasBeenSeen = true
                    } else {
                        score -= 1
                    }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                // Nenhuma carta virada para cima - primeira escolha
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    // MARK: - Métodos Públicos
    
    /// Embaralha as cartas do jogo
    mutating func shuffleCards() {
        cards.shuffle()
    }
    
    /// Reinicia o jogo com novas cartas
    mutating func resetGame(with newCards: [Card]) {
        cards = newCards
        score = 0
        cards.shuffle()
    }
    
    /// Retorna o número total de pares no jogo
    func getTotalPairs() -> Int {
        return numberOfPairs
    }
    
    /// Retorna quantos pares já foram encontrados
    func getMatchedPairsCount() -> Int {
        return cards.filter { $0.isMatched }.count / 2
    }
    
    /// Verifica se o jogo acabou (todos os pares encontrados)
    func isGameOver() -> Bool {
        return cards.allSatisfy { $0.isMatched }
    }
    
    // MARK: - Inicialização
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        self.numberOfPairs = numberOfPairsOfCards
        cards = []
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
}

// MARK: - Card Struct

extension MemoryGame {
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                isFaceUp ? startUsingBonusTime() : stopUsingBonusTime()
            }
        }
        
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var hasBeenSeen = false
        let content: CardContent
        let id: Int
        
        // MARK: - Bonus Time Properties
        
        /// Tempo limite para ganhar bônus (em segundos)
        var bonusTimeLimit: TimeInterval = 6
        
        /// Tempo total que a carta ficou virada para cima
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        /// Data da última vez que a carta foi virada para cima
        var lastFaceUpDate: Date?
        
        /// Tempo acumulado que a carta ficou virada para cima (excluindo o período atual)
        var pastFaceUpTime: TimeInterval = 0
        
        /// Tempo restante para ganhar o bônus
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        /// Percentual de bônus restante (0 a 1)
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        /// Indica se a carta está consumindo tempo de bônus
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // MARK: - Bonus Time Methods
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}

// MARK: - Extensão para Debug

extension MemoryGame where CardContent == String {
    /// Retorna uma representação em string do estado atual do jogo (para debug)
    func debugDescription() -> String {
        var description = "MemoryGame State:\n"
        description += "Score: \(score)\n"
        description += "Pairs: \(numberOfPairs)\n"
        description += "Cards:\n"
        for (index, card) in cards.enumerated() {
            let status = card.isMatched ? "✅" : (card.isFaceUp ? "🔺" : "🔻")
            description += "  \(index): \(card.content) \(status) \(card.isFaceUp ? "🔄" : "")\n"
        }
        return description
    }
}

// MARK: - Equatable

extension MemoryGame.Card: Equatable where CardContent: Equatable {
    static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
        return lhs.id == rhs.id &&
               lhs.content == rhs.content &&
               lhs.isFaceUp == rhs.isFaceUp &&
               lhs.isMatched == rhs.isMatched
    }
}

// MARK: - Hashable

extension MemoryGame.Card: Hashable where CardContent: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(content)
        hasher.combine(isFaceUp)
        hasher.combine(isMatched)
    }
}
