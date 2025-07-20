//
//  RainbowWaveView.swift
//  Kill The Cockroach
//
//  Created by Lilit Avdalyan on 22.02.25.
//


import SwiftUI

struct RainbowWaveView: View {
    @State private var offsetX: CGFloat = -100

    var body: some View {
        ZStack {
            ForEach(0..<15) { i in
                Circle()
                    .fill(randomRainbowColor())
                    .frame(width: 8, height: 8)
                    .offset(x: offsetX + CGFloat(i * 10), y: CGFloat.random(in: -30...30))
                    .animation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true),
                        value: offsetX
                    )
            }
        }
        .onAppear {
            offsetX = 100
        }
    }

    func randomRainbowColor() -> Color {
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]
        return colors.randomElement() ?? .white
    }
}