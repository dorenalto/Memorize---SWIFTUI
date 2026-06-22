//
//  MemorizeApp.swift
//  Memorize
//
//  Created by dorenalto mangueira couto 21/06/26.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: EmojiMemoryGame())
        }
    }
}
