//
//  GameTimer.swift
//  Kill The Cockroach
//
//  Created by Lilit Avdalyan on 22.02.25.
//


import SwiftUI
import Playgrounds

class GameTimer: ObservableObject {
    @Published var timeRemaining: Int
    private var timer: Timer?
    
    init(initialTime: Int) {
        self.timeRemaining = initialTime
    }
    
    func start() {
        invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.invalidate()
            }
        }
    }
    
    func invalidate() {
        timer?.invalidate()
        timer = nil
    }
}
