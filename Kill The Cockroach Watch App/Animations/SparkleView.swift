struct SparkleView: View {
    @State private var scale = 0.5
    
    var body: some View {
        ZStack {
            ForEach(0..<15) { _ in
                Circle()
                    .fill(Color.yellow.opacity(0.8))
                    .frame(width: 6, height: 6)
                    .position(
                        x: CGFloat.random(in: 0...180),
                        y: CGFloat.random(in: 0...180)
                    )
                    .scaleEffect(scale)
                    .animation(
                        .easeInOut(duration: Double.random(in: 0.3...1.2))
                        .repeatForever(autoreverses: true),
                        value: scale
                    )
            }
        }
        .onAppear {
            scale = 1.5
        }
    }
}