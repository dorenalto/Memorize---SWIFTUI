//
//  VictoryBadge.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 21/06/26.
//

import SwiftUI

struct VictoryBadge: View {
    let themeColor: Color
    
    var body: some View {
        HStack {
            Image(systemName: "trophy.fill")
                .foregroundColor(.yellow)
                .font(.title2)
            
            Text("You Win!")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(themeColor)
            
            Text("🎉")
                .font(.title2)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(themeColor.opacity(0.15))
        )
        .overlay(
            Capsule()
                .stroke(themeColor, lineWidth: 1)
        )
    }
}

#Preview {
    VictoryBadge(themeColor: .orange)
}
