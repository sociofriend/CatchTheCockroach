import SwiftUI
import WatchKit

struct ContentView: View {
    @State private var cockroachPosition = CGPoint(x: 100, y: 100)
    @State private var score = 0
    @State private var isAlive = true
    @State private var showCelebration = false  // Celebration flag
    @State private var backgroundNumber = 0
    @State private var celebrationType = 0
    
    let screenWidth = WKInterfaceDevice.current().screenBounds.width
    let screenHeight = WKInterfaceDevice.current().screenBounds.height

    
    var body: some View {
        ZStack {
            Image("background-\(backgroundNumber)")
                .resizable()
                .scaledToFill()
                .zIndex(0)
            
            if isAlive {
                Image("cockroach-\(Int.random(in: 0...14))")
                    .resizable()
                    .scaledToFit()
                    .frame(width: Double.random(in: 50...70), height: Double.random(in: 70...90))
                    .position(cockroachPosition)
                    .onTapGesture {
                        isAlive = false
                        score += 1
                        checkForCelebration()  // Check score condition
                        respawnCockroach()
                    }
                    .animation(.easeInOut(duration: 0.3), value: cockroachPosition)
                    .shadow(color: .white, radius: 8)
            }
            
            VStack {
                HStack {
                    Spacer()
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .font(.headline)
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .frame(width: 100, height: 30)
                                .padding(5)
                                .opacity(0.8)
                                .foregroundStyle(.red)
                        )
                    Spacer()
                }
                Spacer()
            }
            .padding()
            
            // 🎉 Celebration Effect
            if showCelebration {
                VStack {
                    
                    if celebrationType == 0 {
                        ConfettiView()
                    } else if celebrationType == 1 {
                        FireworksView()
                    } else {
                        SparkleView()
                    }
                    
                }
                .transition(.opacity)
                .zIndex(1)
      
            }
        }
        .onAppear {
            startMovingCockroach()
        }
    }
    
    func startMovingCockroach() {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            if isAlive {
                moveCockroachRandomly()
            }
        }
    }
    
    func moveCockroachRandomly() {
        let randomX = CGFloat.random(in: 20...(screenWidth - 20))
        let randomY = CGFloat.random(in: 20...(screenHeight - 20))
        cockroachPosition = CGPoint(x: randomX, y: randomY)
    }
    
    func respawnCockroach() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isAlive = true
            moveCockroachRandomly()
        }
    }
    
    // 🎯 Check for Celebration Trigger
    func checkForCelebration() {
        if score != 0 && score % 10 == 0 {
            showCelebration = true
            celebrationType = Int.random(in: 0...2) // Choose a random effect
            changeBackground()
            playHaptic()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation {
                    showCelebration = false
                }
            }
        }
    }
    
    func changeBackground() {
        backgroundNumber = Int.random(in: 0...6)
    }
    
    func playHaptic() {
        WKInterfaceDevice.current().play(.success) // Plays a small vibration
    }
    
}

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

#Preview {
    ContentView()
}
