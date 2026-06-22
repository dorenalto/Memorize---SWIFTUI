//
//  MemoryGamePerformanceTests.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 21/06/26.
//

import XCTest
@testable import Memorize

final class MemoryGamePerformanceTests: XCTestCase {
    
    func testPerformanceLargeGameInitialization() throws {
        measure {
            let _ = MemoryGame<String>(numberOfPairsOfCards: 50) { index in
                return "\(index)"
            }
        }
    }
    
    func testPerformanceShuffle() throws {
        var game = MemoryGame<String>(numberOfPairsOfCards: 20) { index in
            return "\(index)"
        }
        
        measure {
            game.shuffleCards() 
        }
    }
    
    func testPerformanceChooseCards() throws {
        var game = MemoryGame<String>(numberOfPairsOfCards: 20) { index in
            return "\(index)"
        }
        
        measure {
            for card in game.cards.prefix(10) {
                game.choose(card: card)
            }
        }
    }
}
