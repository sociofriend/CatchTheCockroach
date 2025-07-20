//
//  BalloonView.swift
//  Kill The Cockroach
//
//  Created by Lilit Avdalyan on 22.02.25.
//


import SwiftUI

struct BalloonView: View {
    @State private var offsetY: CGFloat = 100
    @State private var opacity: Double = 1.0

    var body: some View {
        ZStack {
            ForEach(0..<6) { i in
                Circle()
                    .fill(randomColor())
                    .frame(width: 15, height: 20)
                    .offset(x: CGFloat.random(in: -40...40), y: offsetY)
                    .opacity(opacity)
                    .animation(
                        .easeOut(duration: Double.random(in: 2.0...3.0))
                        .repeatForever(autoreverses: false),
                        value: offsetY
                    )
            }
        }
        .onAppear {
            offsetY = -100
            opacity = 0
        }
    }

    func randomColor() -> Color {
        let colors: [Color] = [.red, .blue, .green, .yellow, .purple, .orange]
        return colors.randomElement() ?? .white
    }
}