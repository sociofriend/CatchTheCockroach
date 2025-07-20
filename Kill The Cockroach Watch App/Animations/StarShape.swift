//
//  StarShape.swift
//  Kill The Cockroach
//
//  Created by Lilit Avdalyan on 22.02.25.
//


import SwiftUI

// Simple star shape
struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        var points: [CGPoint] = []
        let radius = min(rect.width, rect.height) / 2
        for i in 0..<5 {
            let angle = Double(i) * (2.0 * .pi / 5.0) - .pi / 2
            let point = CGPoint(
                x: center.x + cos(angle) * radius,
                y: center.y + sin(angle) * radius
            )
            points.append(point)
        }
        path.move(to: points.first!)
        for i in stride(from: 0, to: points.count, by: 2) {
            path.addLine(to: points[(i + 2) % points.count])
        }
        path.closeSubpath()
        return path
    }
}
