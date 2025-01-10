import SwiftUI

struct ContentView: View {
    @State var moves: Int = 0
    @State var cars: [[Car]] = [[]]
    @State var showAlert:Bool = false
    @State var isGameOver:Bool = false
    @State var isGameStarted:Bool = false
    @State var dificulty:Int = 1
    @StateObject private var timerManager = TimerManager()
    
    func changeCarLocation(row:Int,column:Int){
        if(cars[row][column].direction==1){
            if row>0{
                if cars[row-1][column].direction == 0{
                    cars[row][column].direction=0
                    cars[row-1][column].direction=1
                    cars[row-1][column].refreshView()
                }
            }
            else{
                cars[row][column].direction=0;
            }
            
        }
        if(cars[row][column].direction==2){
            if column<5{
                if cars[row][column+1].direction == 0{
                    cars[row][column].direction=0
                    cars[row][column+1].direction=2
                    cars[row][column+1].refreshView()
                }
            }
            else{
                cars[row][column].direction=0;
            }
            
        }
        if(cars[row][column].direction==3){
            if row<5{
                if cars[row+1][column].direction == 0{
                    cars[row][column].direction=0
                    cars[row+1][column].direction=3
                    cars[row+1][column].refreshView()
                }
            }
            else{
                cars[row][column].direction=0;
            }
            
        }
        if(cars[row][column].direction==4){
            if column>0{
                if cars[row][column-1].direction == 0{
                    cars[row][column].direction=0
                    cars[row][column-1].direction=4
                    cars[row][column-1].refreshView()
                }
            }
            else{
                cars[row][column].direction=0;
            }
            
        }
        cars[row][column].refreshView()
    }
    
    func isGameFinished() -> Bool {
        var finished = true
        cars.forEach { row in
            row.forEach { cell in
                if cell.direction != 0 {
                    finished = false
                }
            }
        }
        return finished
    }
    
    func createGrid(_ carsCount:Int){
        if cars.count > 0 {
            cars.removeAll()
        }
        for i in 0..<6 {
            cars.append([])
            for j in 0..<6 {
                cars[i].append(Car(direction: 0))
                cars[i][j].refreshView()
            }
        }
        var howManyCars:Int=0
        while howManyCars < carsCount {
            print(howManyCars)
            let row = Int.random(in: 0..<6)
            let column = Int.random(in: 0..<6)
            let direction = Int.random(in: 1...4)
            var create:Bool = true
            if cars[row][column].direction == 0 {
                switch direction {
                    case 1:
                        for j in 0...row {
                            if cars[j][column].direction == 3 {
                                create = false
                            }
                        }
                    case 2:
                        for j in column...5 {
                            if cars[row][j].direction == 4 {
                                create = false
                            }
                        }
                    case 3:
                        for j in row...5 {
                            if cars[j][column].direction == 1 {
                                create = false
                            }
                        }
                    case 4:
                        for j in 0...column {
                            if cars[row][j].direction == 2 {
                                create = false
                            }
                        }
                    default:
                    create = false
                }
            }else{
                create = false
            }
            if create {
                cars[row][column].direction = direction
                cars[row][column].refreshView()
                howManyCars += 1
            }
        }
    }
    
    var body: some View {
        ZStack{
            Color.blue
                .ignoresSafeArea()
            VStack {
                Text("Car Game")
                    .foregroundColor(Color.white)
                    .fontWeight(.heavy)
                    .font(.system(size: 50))
                Text(timerManager.timeString)
                    .foregroundStyle(Color.white)
                    .fontWeight(.heavy)
                    .font(.system(size: 20))
                VStack{
                    ForEach(cars.indices, id: \.self) { i in
                        HStack {
                            ForEach(cars[i].indices, id: \.self) { j in
                                cars[i][j].image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .onTapGesture {
                                        if !isGameOver{
                                            if !isGameStarted{
                                                timerManager.startTimer()
                                            }
                                            isGameStarted=true
                                            moves+=1
                                            changeCarLocation(row: i, column: j)
                                            isGameOver = isGameFinished()
                                            if isGameOver{
                                                timerManager.pauseTimer()
                                                isGameStarted=false
                                                showAlert=true
                                                
                                            }
                                            
                                        }
                                    }
                                
                            }
                        }
                    }
                }
                .padding(8)
                .background(Color.gray)
                .cornerRadius(10)
                HStack{
                    Spacer()
                    VStack{
                        Text("Moves: \(moves)")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 25))
                        Button{
                            createGrid(dificulty*10)
                            moves=0
                            isGameOver=false
                            timerManager.resetTimer()
                            isGameStarted=false
                        }label: {
                            Text("Restart")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                        }
                        .padding()
                        .background(isGameOver ? Color.green : Color.red)
                        .cornerRadius(10)
                        .padding(.bottom)
                        Picker(selection: $dificulty, label: Text("Poziom trudnosci")) {
                            Text("Łatwy").tag(1)
                            Text("Średni").tag(2)
                            Text("Trudny").tag(3)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .background(Color.blue.opacity(0.9))
                        .cornerRadius(8)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.black.opacity(0.6))
                .cornerRadius(12)
                
            }
            .padding()
            .onAppear() {
                createGrid(dificulty * 10)
            }
            .alert(isPresented: $showAlert) { // Alert
                Alert(
                    title: Text("Gratulacje!"),
                    message: Text("Wygrales"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
