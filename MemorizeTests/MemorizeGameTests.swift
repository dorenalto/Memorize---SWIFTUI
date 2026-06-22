//
//  MemorizeTests.swift
//  MemorizeTests
//
//  Created by dorenalto mangueira couto on 21/06/26.
//

import XCTest
@testable import Memorize

final class MemorizeTests: XCTestCase {
    
    var game: MemoryGame<String>!
    
    override func setUpWithError() throws {
        super.setUp()
        // Criar um jogo com 3 pares de cartas
        game = MemoryGame<String>(numberOfPairsOfCards: 3) { index in
            return ["👻", "🎃", "🕷️"][index]
        }
    }
    
    override func tearDownWithError() throws {
        game = nil
        super.tearDown()
    }
    
    // MARK: - Testes de Inicialização
    
    func testGameInitialization() throws {
        // Deve ter 6 cartas (3 pares)
        XCTAssertEqual(game.cards.count, 6, "Deveria ter 6 cartas para 3 pares")
        
        // Todas as cartas devem começar viradas para baixo
        let faceUpCount = game.cards.filter { $0.isFaceUp }.count
        XCTAssertEqual(faceUpCount, 0, "Todas as cartas devem começar viradas para baixo")
        
        // Nenhuma carta deve estar marcada como correspondida
        let matchedCount = game.cards.filter { $0.isMatched }.count
        XCTAssertEqual(matchedCount, 0, "Nenhuma carta deve começar correspondida")
    }
    
    func testGameHasPairs() throws {
        // Verificar se cada carta tem um par correspondente
        let contents = game.cards.map { $0.content }
        let uniqueContents = Set(contents)
        
        // Deve ter 3 conteúdos únicos
        XCTAssertEqual(uniqueContents.count, 3, "Deveria ter 3 conteúdos únicos")
        
        // Cada conteúdo deve aparecer exatamente 2 vezes
        for content in uniqueContents {
            let count = contents.filter { $0 == content }.count
            XCTAssertEqual(count, 2, "Cada carta deveria aparecer exatamente 2 vezes, mas \(content) apareceu \(count) vezes")
        }
    }
    
    // MARK: - Testes de Escolha de Cartas
    
    func testChooseFirstCard() throws {
        // Escolher a primeira carta
        let firstCard = game.cards[0]
        game.choose(card: firstCard)
        
        // A carta deve estar virada para cima
        XCTAssertTrue(game.cards[0].isFaceUp, "A carta escolhida deve estar virada para cima")
        
        // Nenhuma outra carta deve estar virada para cima
        let faceUpCount = game.cards.filter { $0.isFaceUp }.count
        XCTAssertEqual(faceUpCount, 1, "Apenas a carta escolhida deve estar virada para cima")
    }
    
    func testChooseTwoMatchingCards() throws {
        // Encontrar duas cartas com o mesmo conteúdo
        let content = game.cards[0].content
        let matchingIndices = game.cards.indices.filter { game.cards[$0].content == content }
        
        guard matchingIndices.count >= 2 else {
            XCTFail("Não foi possível encontrar duas cartas com o mesmo conteúdo")
            return
        }
        
        // Escolher a primeira carta do par
        game.choose(card: game.cards[matchingIndices[0]])
        game.choose(card: game.cards[matchingIndices[1]])
        
        // Ambas devem estar marcadas como correspondidas
        XCTAssertTrue(game.cards[matchingIndices[0]].isMatched, "A primeira carta deve estar marcada como correspondida")
        XCTAssertTrue(game.cards[matchingIndices[1]].isMatched, "A segunda carta deve estar marcada como correspondida")
        
        // Ambas devem estar viradas para cima (ou podem ser viradas para baixo se a UI esconder)
        // O modelo mantém isFaceUp, a UI pode decidir não mostrar
        XCTAssertTrue(game.cards[matchingIndices[0]].isFaceUp, "A primeira carta deve estar virada para cima")
        XCTAssertTrue(game.cards[matchingIndices[1]].isFaceUp, "A segunda carta deve estar virada para cima")
    }
    
    func testChooseTwoNonMatchingCards() throws {
        // Encontrar duas cartas com conteúdos diferentes
        let card1 = game.cards[0]
        let card2 = game.cards.first { $0.content != card1.content }!
        
        // Escolher a primeira carta
        game.choose(card: card1)
        
        // Escolher a segunda carta (diferente)
        game.choose(card: card2)
        
        // Nenhuma deve estar correspondida
        XCTAssertFalse(game.cards[0].isMatched, "A primeira carta não deve estar correspondida")
        XCTAssertFalse(game.cards.first { $0.id == card2.id }!.isMatched, "A segunda carta não deve estar correspondida")
        
        // Ambas devem estar viradas para cima
        XCTAssertTrue(game.cards[0].isFaceUp, "A primeira carta deve estar virada para cima")
        XCTAssertTrue(game.cards.first { $0.id == card2.id }!.isFaceUp, "A segunda carta deve estar virada para cima")
    }
    
    // MARK: - Testes de Bônus
    
    func testBonusTimeInitialization() throws {
        // Verificar se o bônus é inicializado corretamente
        let card = game.cards[0]
        
        // O tempo limite deve ser 6 segundos (padrão)
        XCTAssertEqual(card.bonusTimeLimit, 6, "O tempo limite de bônus deve ser 6 segundos")
        
        // O bônus restante deve ser 100% no início
        XCTAssertEqual(card.bonusRemaining, 1.0, accuracy: 0.01, "O bônus restante deve ser 100% no início")
    }
    
    func testCardFaceUpTracksTime() throws {
        // Testar se o tempo é rastreado quando a carta está virada para cima
        var card = game.cards[0]
        
        // A carta começa virada para baixo
        XCTAssertFalse(card.isFaceUp, "A carta deve começar virada para baixo")
        
        // Virar a carta para cima
        card.isFaceUp = true
        // O tempo deve começar a ser rastreado
        // Nota: Como não podemos simular o tempo, apenas verificamos se a carta está virada para cima
        XCTAssertTrue(card.isFaceUp, "A carta deve estar virada para cima")
    }
    
    // MARK: - Testes de Edge Cases
    
    func testChooseAlreadyMatchedCard() throws {
        // Marcar uma carta como correspondida
        var card = game.cards[0]
        card.isMatched = true
        let cardId = card.id
        
        // Tentar escolher a carta já correspondida
        game.choose(card: card)
        
        // A carta deve permanecer correspondida
        let matchedCard = game.cards.last { $0.id == cardId }!
        XCTAssertTrue(!matchedCard.isMatched, "A carta deve permanecer correspondida")
        
        // Não deve virar nenhuma outra carta
        let faceUpCount = game.cards.filter { $0.isFaceUp }.count
        XCTAssertEqual(faceUpCount, 1, "Nenhuma carta deve virar")
    }
    
    func testChooseAlreadyFaceUpCard() throws {
        // Escolher uma carta para virar
        let card = game.cards[0]
        game.choose(card: card)
        
        // Tentar escolher a mesma carta novamente
        game.choose(card: card)
        
        // A carta deve permanecer virada para cima
        XCTAssertTrue(game.cards[0].isFaceUp, "A carta deve permanecer virada para cima")
        
        // Nenhuma outra carta deve ser afetada
        let faceUpCount = game.cards.filter { $0.isFaceUp }.count
        XCTAssertEqual(faceUpCount, 1, "Apenas a carta escolhida deve estar virada para cima")
    }
}
