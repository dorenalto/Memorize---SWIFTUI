//
//  FooterView.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 21/06/26.
//

import SwiftUI

struct FooterView: View {
    let isGameOver: Bool
    let themeColor: Color
    let onNewGame: () -> Void
    let onShowThemes: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            if isGameOver {
                VictoryBadge(themeColor: themeColor)
                    .transition(.scale.combined(with: .opacity))
            }
            
            HStack(spacing: 12) {
                Button(action: onNewGame) {
                    Label("New Game", systemImage: "arrow.counterclockwise")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(themeColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                Button(action: onShowThemes) {
                    Label("Themes", systemImage: "paintpalette")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color(.systemGray5))
                        .foregroundColor(themeColor)
                        .cornerRadius(12)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.05), radius: 5, y: -5)
    }
}

#Preview {
    FooterView(
        isGameOver: true,
        themeColor: .orange,
        onNewGame: {},
        onShowThemes: {}
    )
}
