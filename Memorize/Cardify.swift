//
//  Cardify.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 21/06/26.
//

//
//  Cardify.swift
//  Memorize
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    var rotation: Double
    var color: Color = .orange
    
    var isFaceUp: Bool { rotation < 90 }
    
    init(isFaceUp: Bool, color: Color = .orange) {
        self.rotation = isFaceUp ? 0 : 180
        self.color = color
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    let cornerRadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: edgeLineWidth)
                    .foregroundColor(color)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(color)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
    }
}

extension View {
    func cardify(isFaceUp: Bool, color: Color = .orange) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, color: color))
    }
}
