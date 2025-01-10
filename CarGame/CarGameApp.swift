import SwiftUI

class Car: ObservableObject {
    @Published var direction: Int
    @Published var image: Image
    
    init(direction: Int) {
        self.direction = direction
        self.image = Image("car\(direction)")
    }
    
    func refreshView() {
        image = Image("car\(direction)")  // Przypisanie nowego obrazu
    }
}


class TimerManager: ObservableObject {
    @Published var timeString = "00:00"
    private var timer: Timer?
    private var totalSeconds = 0

    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                self.totalSeconds += 1
                self.updateTimeString()
            }
        }
    }

    func pauseTimer() {
        timer?.invalidate()
        timer = nil
    }

    func resetTimer() {
        pauseTimer()
        totalSeconds = 0
        updateTimeString()
    }

    private func updateTimeString() {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        timeString = String(format: "%02d:%02d", minutes, seconds)
    }
}

@main
struct CarGameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
