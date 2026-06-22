//
//  ThemePickerView.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 21/06/26.
//

import SwiftUI

struct ThemePickerView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List(EmojiMemoryGame.Theme.allCases, id: \.self) { theme in
                HStack {
                    // Preview dos emojis
                    HStack(spacing: 2) {
                        ForEach(theme.emojis.prefix(3), id: \.self) { emoji in
                            Text(emoji)
                                .font(.title3)
                        }
                        if theme.emojis.count > 3 {
                            Text("+\(theme.emojis.count - 3)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(width: 80, alignment: .leading)
                    
                    Text(theme.name)
                        .font(.headline)
                    
                    Spacer()
                    
                    Circle()
                        .fill(theme.color)
                        .frame(width: 24, height: 24)
                        .overlay(
                            Circle()
                                .stroke(Color(.systemGray4), lineWidth: 0.5)
                        )
                    
                    if viewModel.currentTheme == theme {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        viewModel.changeTheme(to: theme)
                    }
                    dismiss()
                }
            }
            .navigationTitle("Choose Theme")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}

#Preview {
    ThemePickerView(viewModel: EmojiMemoryGame())
}
