//
//  StarburstView.swift
//  Kill The Cockroach
//
//  Created by Lilit Avdalyan on 22.02.25.
//


import SwiftUI

struct StarburstView: View {
    @State private var scale: CGFloat = 0.2
    @State private var opacity: Double = 1.0

    var body: some View {
        ZStack {
            ForEach(0..<12) { i in
                StarShape()
                    .fill(Color.yellow.opacity(0.8))
                    .frame(width: 10, height: 10)
                    .offset(x: CGFloat.random(in: -50...50), y: CGFloat.random(in: -50...50))
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .rotationEffect(.degrees(Double(i) * 30))
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.2)) {
                scale = 1.5
                opacity = 0
            }
        }
    }
}
