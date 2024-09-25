//
//  MemorizeApp.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 25/09/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: EmojiMemoryGame())
        }
    }
}
