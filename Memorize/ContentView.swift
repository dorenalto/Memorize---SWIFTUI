//
//  ContentView.swift
//  Memorize
//
//  Created by dorenalto mangueira couto on 25/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            ForEach(0..<4) { index in
                CardView(isFaceUp: false)
            }
        }
        .padding()
        .foregroundColor(.orange)
        .font(.largeTitle)
    }
}

struct CardView: View {
    var isFaceUp: Bool
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(.white)
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                Text(" X ")
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }
    }
}

#Preview {
    ContentView()
}
