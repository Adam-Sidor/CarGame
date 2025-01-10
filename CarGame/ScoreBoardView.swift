import SwiftUI

struct ScoreBoardView: View {
    @State var scoreboard: [[scoreboardItem]] = (FileManagerHelper.loadArray2D() ?? [[]])
    
    @State var selectedDificulty: Int = 0
    
    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black.opacity(0.9)]), startPoint: .bottom, endPoint: .top)
                    .ignoresSafeArea()
                VStack{
                    Text("Tablica wyników")
                        .foregroundColor(Color.white)
                        .fontWeight(.heavy)
                        .font(.system(size: 40))
                    ForEach(scoreboard[selectedDificulty], id: \.self) { item in
                        Text("\(item.moves) ruchów w \(item.time)")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 20))
                    }
                    Picker(selection: $selectedDificulty, label: Text("Poziom trudnosci")) {
                        Text("Łatwy").tag(0)
                        Text("Średni").tag(1)
                        Text("Trudny").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color.blue.opacity(0.9))
                    .cornerRadius(8)
                    Button{
                        scoreboard[selectedDificulty].removeAll()
                        FileManagerHelper.saveArray2D(scoreboard)
                    }label: {
                        Text("Wyczyść tablicę")
                            .fontWeight(.heavy)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                            .foregroundColor(Color.white)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.8))
                .cornerRadius(12)
                .padding()
            }
        }
    }
}

#Preview {
    ScoreBoardView()
}
