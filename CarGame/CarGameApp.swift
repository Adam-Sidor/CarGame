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


@main
struct CarGameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
