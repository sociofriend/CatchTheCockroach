//
//  ContentView.swift
//  Kill The Cockroach Watch App
//
//  Created by Lilit Avdalyan on 03.02.25.
//

import SwiftUI

struct ContentView: View {
    @State private var cockroachPosition = CGPoint(x: 100, y: 100)
    @State private var cockroachPosition1 = CGPoint(x: 100, y: 100)
    @State private var cockroachPosition2 = CGPoint(x: 100, y: 100)
    @State private var score = 0
    @State private var isAlive = true
    @State private var isAlive1 = true
    @State private var isAlive2 = true
    
    
    let screenWidth = WKInterfaceDevice.current().screenBounds.width
    let screenHeight = WKInterfaceDevice.current().screenBounds.height
    
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .scaledToFill()
                .zIndex(0)
            
            // Խավարասեր (սեղմելու համար)
            if isAlive {
                
                Image("cockroach-\(Int.random(in: 0...6))")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Double.random(in: 30...50), height: Double.random(in: 50...80))
                    .position(cockroachPosition)
                    .onTapGesture {
                        isAlive = false
                        score += 1
                        respawnCockroach()
                    }
                    .animation(.easeInOut(duration: 0.3), value: cockroachPosition)
            }
            
            // Մատչելի միավորների ցուցադրություն
            VStack {
                HStack {
                    Spacer()
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .font(.headline)
                        .background {
                            RoundedRectangle(cornerRadius: 50)
                                .frame(width: 100, height: 30)
                                .padding(5)
                                .opacity(0.8)
                                .foregroundStyle(.red)
                        }
                    Spacer()
                }
                Spacer()
            }
            .padding()
        }
        .onAppear {
            startMovingCockroach()
        }
    }
    
    // Խավարասերի շարժման գործառույթ
    func startMovingCockroach() {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            if isAlive {
                moveCockroachRandomly()
            }
        }
    }
    
    // Խավարասերի վերադասավորում պատահական դիրքում
    func moveCockroachRandomly() {
        let randomX = CGFloat.random(in: 20...(screenWidth - 20))
        let randomY = CGFloat.random(in: 20...(screenHeight - 20))
        cockroachPosition = CGPoint(x: randomX, y: randomY)
    }
    
    // Սատկացնելուց հետո նոր խավարասեր ավելացնելու գործառույթ
    func respawnCockroach() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isAlive = true
            moveCockroachRandomly()
        }
    }
}

#Preview {
    ContentView()
}
#Preview {
    ContentView()
}
