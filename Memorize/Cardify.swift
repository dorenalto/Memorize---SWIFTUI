//
//  Cardify.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 26/09/24.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    var rotation: Double
    var isFaceUp: Bool { rotation < 90 }
    init(isFaceUp: Bool) {
        self.rotation = isFaceUp ? 0 : 180
    }
    var animatableData: Double {
        get{ return rotation }
        set{ rotation = newValue }
    }
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }
                .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0,1,0))
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
