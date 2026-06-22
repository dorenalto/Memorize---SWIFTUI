//
//  CardView.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 21/06/26.
//

//
//  CardView.swift
//  Memorize
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    @State private var animateBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animateBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animateBonusRemaining = 0
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    if card.isConsumingBonusTime {
                        Pie(
                            startAngle: Angle(degrees: 0 - 90),
                            endAngle: Angle(degrees: -animateBonusRemaining * 360 - 90),
                            clockwise: true
                        )
                        .onAppear {
                            startBonusTimeAnimation()
                        }
                        .padding(5)
                        .opacity(0.4)
                    } else if card.bonusRemaining > 0 && !card.isMatched {
                        Pie(
                            startAngle: Angle(degrees: 0 - 90),
                            endAngle: Angle(degrees: -card.bonusRemaining * 360 - 90),
                            clockwise: true
                        )
                        .padding(5)
                        .opacity(0.4)
                    }
                    
                    Text(card.content)
                        .font(.system(size: fontSize(for: geometry.size)))
                        .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                        .animation(.easeInOut(duration: 0.5), value: card.isMatched)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(.identity)
            }
        }
    }
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

#Preview {
    let card = MemoryGame<String>.Card(
        isFaceUp: true,
        isMatched: false,
        hasBeenSeen: false,
        content: "👻",
        id: 0,
        bonusTimeLimit: 6
    )
    return CardView(card: card)
        .frame(width: 100, height: 150)
}
