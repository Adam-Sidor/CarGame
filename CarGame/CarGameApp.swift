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

struct scoreboardItem: Hashable,Encodable,Decodable{
    var moves: Int
    var time: String
}

struct FileManagerHelper {
    static let fileName = "scoreboard.json"
    
    static var fileURL: URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsURL.appendingPathComponent(fileName)
    }
    
    static func saveArray2D(_ array: [[scoreboardItem]]) {
        do {
            let data = try JSONEncoder().encode(array)
            try data.write(to: fileURL)
        } catch {
            print(error)
        }
    }
        static func loadArray2D() -> [[scoreboardItem]]? {
        do {
            let data = try Data(contentsOf: fileURL)
            let array = try JSONDecoder().decode([[scoreboardItem]].self, from: data)
            return array
        } catch {
            print(error)
            return nil
        }
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
