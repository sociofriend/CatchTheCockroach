//
//  HeartBurstView.swift
//  Kill The Cockroach
//
//  Created by Lilit Avdalyan on 22.02.25.
//


import SwiftUI

struct HeartBurstView: View {
    @State private var opacity: Double = 1.0

    var body: some View {
        ZStack {
            ForEach(0..<10) { _ in
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundColor(randomColor())
                    .position(x: CGFloat.random(in: 10...180), y: CGFloat.random(in: 10...180))
                    .opacity(opacity)
                    .animation(.easeOut(duration: 1.5), value: opacity)
            }
        }
        .onAppear {
            withAnimation {
                opacity = 0
            }
        }
    }

    func randomColor() -> Color {
        let colors: [Color] = [.red, .pink, .purple]
        return colors.randomElement() ?? .white
    }
}