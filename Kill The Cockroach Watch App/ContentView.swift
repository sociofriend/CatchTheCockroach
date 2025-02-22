import SwiftUI
import WatchKit


struct ContentView: View {
    @State private var cockroachPosition = CGPoint(x: 100, y: 100)
    @State private var score = 0
    @State private var isAlive = true
    @State private var showCelebration = false
    @State private var backgroundNumber = 0
    @State private var celebrationType = 0
    @State private var targetScore = 5
    @State private var gameStarted = false
    @State private var showTimer = true
    
    @StateObject private var gameTimer = GameTimer(initialTime: 10)
    
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
                        respawnCockroach()
                    }
                    .animation(.easeInOut(duration: 0.3), value: cockroachPosition)
                    .shadow(color: .white, radius: 8)
            }
            
            VStack {
                HStack {
                    Text("🎯: \(score)/\(targetScore)")
                        .foregroundColor(.white)
                        .font(.headline)
                        .background(
                            RoundedRectangle(cornerRadius: 50)
                                .frame(width: 60, height: 25)
                                .padding(5)
                                .opacity(0.7)
                                .foregroundStyle(.red)
                        )
                    Spacer()
                    if showTimer {
                        Text("⏳: \(gameTimer.timeRemaining)")
                            .foregroundColor(.white)
                            .font(.headline)
                            .background(
                                RoundedRectangle(cornerRadius: 50)
                                    .frame(width: 60, height: 25)
                                    .padding(5)
                                    .opacity(0.7)
                                    .foregroundStyle(.blue)
                            )
                    }
                }
                .padding()
                Spacer()
            }
            
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
        .onAppear { startGame() }
        .onChange(of: gameTimer.timeRemaining) { _, newState in
            if newState == 0 { endGame() }
        }
        .onChange(of: score) { _, newValue in
            if newValue == targetScore { endGame() }
        }
    }
    
    func startGame() {
        score = 0
        targetScore = Int.random(in: 5...7)
        gameTimer.invalidate()
        gameTimer.timeRemaining = 10
        gameTimer.start()
        gameStarted = true
        selectBackground()
        startMovingCockroach()
    }
    
    func endGame() {
        checkForCelebration()
        playHaptic()
        resetGoal()
    }
    
    func resetGoal() {
        showCelebration = false
        startGame()
    }
    
    func startMovingCockroach() {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
            if isAlive {
                moveCockroachRandomly()
            }
        }
    }
    
    func moveCockroachRandomly() {
        let randomX = CGFloat.random(in: 8...(screenWidth - 8))
        let randomY = CGFloat.random(in: 8...(screenHeight - 8))
        cockroachPosition = CGPoint(x: randomX, y: randomY)
    }
    
    func respawnCockroach() {
        isAlive = true
        moveCockroachRandomly()
    }
    
    func checkForCelebration() {
        if score != 0 && score == targetScore {
            celebrationType = Int.random(in: 0...2)
            showCelebration = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation { showCelebration = false }
            }
        }
    }
    
    func selectBackground() {
        backgroundNumber = Int.random(in: 0...6)
    }
    
    func playHaptic() {
        WKInterfaceDevice.current().play(score >= targetScore ? .success : .retry)
    }
}

#Preview { ContentView() }
