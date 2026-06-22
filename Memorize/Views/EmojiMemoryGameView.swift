//
//  ContentView.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 21/06/26.
//

//
//  EmojiMemoryGameView.swift
//  Memorize
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    @State private var showThemePicker = false
    
    var isGameOver: Bool {
        viewModel.cards.allSatisfy { $0.isMatched }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderView(
                    score: viewModel.score,
                    themeColor: viewModel.themeColor,
                    themeName: viewModel.themeName,
                    matchedCount: viewModel.cards.filter { $0.isMatched }.count,
                    totalCards: viewModel.cards.count
                )
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 8) {
                        ForEach(viewModel.cards) { card in
                            CardView(card: card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        viewModel.choose(card: card)
                                    }
                                }
                        }
                    }
                    .padding()
                }
                
                FooterView(
                    isGameOver: isGameOver,
                    themeColor: viewModel.themeColor,
                    onNewGame: {
                        withAnimation(.easeInOut) {
                            viewModel.resetGame()
                        }
                    },
                    onShowThemes: {
                        withAnimation {
                            showThemePicker.toggle()
                        }
                    }
                )
            }
            .navigationTitle("Memorize")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showThemePicker) {
                ThemePickerView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
