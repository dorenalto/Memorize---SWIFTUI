//
//  HeaderView.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 21/06/26.
//

import SwiftUI

struct HeaderView: View {
    let score: Int
    let themeColor: Color
    let themeName: String
    let matchedCount: Int
    let totalCards: Int
    
    var body: some View {
        HStack {
            // Score
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("\(score)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(themeColor)
            }
            
            Spacer()
            
            // Progress
            VStack(spacing: 2) {
                ProgressView(value: Double(matchedCount), total: Double(totalCards))
                    .tint(themeColor)
                    .frame(width: 100)
                
                Text("\(matchedCount)/\(totalCards)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Theme
            HStack(spacing: 4) {
                Circle()
                    .fill(themeColor)
                    .frame(width: 12, height: 12)
                Text(themeName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(themeColor)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
}

#Preview {
    HeaderView(
        score: 10,
        themeColor: .orange,
        themeName: "Halloween",
        matchedCount: 6,
        totalCards: 12
    )
}
