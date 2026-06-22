//
//  EmojiMemoryGameTests.swift
//  MemorizeTests
//
//  Created by dorenalto mangueira couto on 21/06/26.
//

import XCTest
@testable import Memorize

final class EmojiMemoryGameTests: XCTestCase {
    
    var viewModel: EmojiMemoryGame!
    
    override func setUpWithError() throws {
        super.setUp()
        viewModel = EmojiMemoryGame()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Testes de Inicialização
    
    func testViewModelInitialization() throws {
        // Verificar se o ViewModel foi inicializado corretamente
        XCTAssertNotNil(viewModel, "O ViewModel deve ser inicializado")
        
        // O tema inicial deve ser halloween
        XCTAssertEqual(viewModel.currentTheme, EmojiMemoryGame.Theme.halloween, "O tema inicial deve ser Halloween")
        
        // Deve haver cartas no jogo
        XCTAssertFalse(viewModel.cards.isEmpty, "O jogo deve ter cartas")
    }
    
    func testThemeName() throws {
        // Testar se o nome do tema está correto
        let theme = EmojiMemoryGame.Theme.halloween
        XCTAssertEqual(theme.name, "Halloween", "O nome do tema Halloween deve ser 'Halloween'")
        
        let animalsTheme = EmojiMemoryGame.Theme.animals
        XCTAssertEqual(animalsTheme.name, "Animals", "O nome do tema Animals deve ser 'Animals'")
    }
    
    func testThemeColor() throws {
        // Testar se a cor do tema está correta
        let halloweenTheme = EmojiMemoryGame.Theme.halloween
        XCTAssertEqual(halloweenTheme.color, .orange, "A cor do tema Halloween deve ser laranja")
        
        let animalsTheme = EmojiMemoryGame.Theme.animals
        XCTAssertEqual(animalsTheme.color, .green, "A cor do tema Animals deve ser verde")
    }
    
    func testThemeEmojis() throws {
        // Testar se os emojis do tema não estão vazios
        for theme in EmojiMemoryGame.Theme.allCases {
            XCTAssertFalse(theme.emojis.isEmpty, "O tema \(theme.name) deve ter emojis")
            XCTAssertGreaterThanOrEqual(theme.emojis.count, 4, "O tema \(theme.name) deve ter pelo menos 4 emojis")
        }
    }
    
    // MARK: - Testes de Funcionalidade
    
    func testChooseCard() throws {
        let initialCards = viewModel.cards
        
        // Escolher uma carta
        let card = initialCards[0]
        viewModel.choose(card: card)
        
        // A carta deve estar virada para cima
        let chosenCard = viewModel.cards.first { $0.id == card.id }!
        XCTAssertTrue(chosenCard.isFaceUp, "A carta escolhida deve estar virada para cima")
    }
    
    func testResetGame() throws {
        let initialCards = viewModel.cards
        
        // Escolher algumas cartas para mudar o estado
        let card = initialCards[0]
        viewModel.choose(card: card)
        
        // Resetar o jogo
        viewModel.resetGame()
        
        // As cartas devem ser diferentes (embaralhadas)
        let newCards = viewModel.cards
        XCTAssertNotEqual(initialCards.map { $0.id }, newCards.map { $0.id }, "As cartas devem ser embaralhadas após o reset")
    }
    
    func testChangeTheme() throws {
        let newTheme = EmojiMemoryGame.Theme.animals
        viewModel.changeTheme(to: newTheme)
        
        // O tema deve ter mudado
        XCTAssertEqual(viewModel.currentTheme, newTheme, "O tema deve mudar para Animals")
        
        // As cartas devem ser do novo tema
        let cardsContent = viewModel.cards.map { $0.content }
        let allEmojis = newTheme.emojis
        for content in cardsContent {
            XCTAssertTrue(allEmojis.contains(content), "As cartas devem conter emojis do novo tema")
        }
    }
    
    func testScoreStartsAtZero() throws {
        XCTAssertEqual(viewModel.score, 0, "A pontuação deve começar em 0")
    }
    
    // MARK: - Testes de Performance
    
    func testPerformanceResetGame() throws {
        measure {
            viewModel.resetGame()
        }
    }
    
    func testPerformanceChooseCard() throws {
        let cards = viewModel.cards
        measure {
            for _ in 0..<10 {
                viewModel.choose(card: cards.randomElement()!)
            }
        }
    }
}
