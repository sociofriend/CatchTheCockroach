struct FireworksView: View {
    @State private var opacity = 1.0
    
    var body: some View {
        ZStack {
            ForEach(0..<10) { _ in
                Circle()
                    .fill(Color.red.opacity(0.7))
                    .frame(width: 12, height: 12)
                    .position(
                        x: CGFloat.random(in: 20...180),
                        y: CGFloat.random(in: 20...180)
                    )
                    .scaleEffect(1.5)
                    .opacity(opacity)
                    .animation(.easeOut(duration: 1.5), value: opacity)
            }
        }
        .onAppear {
            opacity = 0
        }
    }
}