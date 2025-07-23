import SwiftUI
import WatchKit
import Combine

struct ContentView: View {
    @State private var cancellables: Set<AnyCancellable> = []
    
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
                .ignoresSafeArea()
                .zIndex(0)
            
            if isAlive {
                Image("cockroach-\(Int.random(in: 0...14))")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 80)
                    .position(cockroachPosition)
                    .onTapGesture {
                        isAlive = false
                        if score < targetScore {
                            score += 1
                        }
                        respawnCockroach()
                    }
                    .animation(.easeInOut(duration: 0.3), value: cockroachPosition)
                    .shadow(color: .white, radius: 8)
            }
            
            VStack {
                Spacer()
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
        .onAppear {
            startGame()
            startMovingCockroach()
        }
        .onChange(of: gameTimer.timeRemaining) { _, newState in
            if newState == 0 { checkForCelebration() }
        }
        .onChange(of: score) { _, newValue in
            if newValue == targetScore { checkForCelebration() }
        }
    }
    
    func startGame() {
        isAlive = true
        score = 0
        targetScore = Int.random(in: 5...7)
        gameTimer.invalidate()
        gameTimer.timeRemaining = 10
        gameTimer.start()
        gameStarted = true
        selectBackground()
    }
    
    
    func startMovingCockroach() {
        Timer.publish(every: 1.5, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if isAlive {
                    moveCockroachRandomly()
                }
            }
            .store(in: &cancellables)
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
            isAlive = false
            celebrationType = Int.random(in: 0...2)
            showCelebration = true
            
            cancellables.removeAll()
            playHaptic()

            print("🎉 Celebration ON at \(Date().description)")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation {
                    showCelebration = false
                    print("🎉 Celebration OFF at \(Date().description)")
                    
                    startGame()
                }
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
