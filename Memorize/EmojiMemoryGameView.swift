//
//  ContentView.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 25/09/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.orange)
            Button(action: {
                withAnimation(.easeInOut) {
                    self.viewModel.resetGame()
                }
            }, label: { Text("New Game") })
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animateBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animateBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animateBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(
                            startAngle: Angle(degrees: 0 - 90),
                            endAngle: Angle(degrees: -animateBonusRemaining * 360 - 90),
                            clockwise: true
                        )
                        .onAppear {
                            startBonusTimeAnimation()
                        }
                    } else {
                        Pie(
                            startAngle: Angle(degrees: 0 - 90),
                            endAngle: Angle(degrees: -card.bonusRemaining * 360 - 90),
                            clockwise: true
                        )
                    }
                }
                        .padding(5).opacity(0.4)
                    Text(card.content)
                        .font(Font.system(size: fontSize(for: size)))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.identity)
        }
    }
    //    MARK: - Drawing Constant
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
