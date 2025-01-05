import SwiftUI

struct ContentView: View {
    @State var carsDirection: [[Int]] = Array(repeating: Array(repeating: 1, count: 6), count: 6)
    @State var carsImages: [[Image]] = Array(repeating: Array(repeating: Image("car1"), count: 6), count: 6)
    
    var body: some View {
        VStack {
            ForEach(carsImages.indices, id: \.self) { i in
                HStack {
                    ForEach(carsImages[i].indices, id: \.self) { j in
                            carsImages[i][j]
                            .resizable()
                            //.frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                carsDirection[i][j] = (carsDirection[i][j] % 3) + 1
                                carsImages[i][j] = Image("car" + String(carsDirection[i][j]))
                            }
                    }
                }
            }
        }
        .padding()
        .onAppear() {
            carsImages = (0..<6).map { i in
                (0..<6).map { j in
                    Image("car" + String(carsDirection[i][j]))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
