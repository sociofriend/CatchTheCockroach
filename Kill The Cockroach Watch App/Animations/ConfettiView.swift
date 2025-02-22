//
//  ConfettiView.swift
//  Kill The Cockroach
//
//  Created by Lilit Avdalyan on 22.02.25.
//


import SwiftUI

// 🎊 Simple Confetti Animation View
struct ConfettiView: View {
    @State private var rotation = 0.0
    
    var body: some View {
        ZStack {
            ForEach(0..<20) { i in
                Circle()
                    .fill(randomColor())
                    .frame(width: 8, height: 8)
                    .position(
                        x: CGFloat.random(in: 0...180),
                        y: CGFloat.random(in: 0...180)
                    )
                    .opacity(0.8)
                    .rotationEffect(.degrees(rotation))
                    .animation(
                        .easeInOut(duration: Double.random(in: 0.5...1.5))
                        .repeatForever(autoreverses: true),
                        value: rotation
                    )
            }
        }
        .onAppear {
            rotation = 360
        }
    }
    
    func randomColor() -> Color {
        let colors: [Color] = [.red, .yellow, .green, .blue, .purple, .orange, .pink]
        return colors.randomElement() ?? .white
    }
}