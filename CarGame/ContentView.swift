import SwiftUI

struct ContentView: View {
    @State var moves: Int = 0
    @State var cars: [[Car]] = [[]]
    @State var showAlert:Bool = false
    @State var isGameOver:Bool = false
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
    
    func createGrid(){
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
        let x:Int = Int.random(in: 0..<5)
        let y:Int = Int.random(in: 0..<5)
        cars[y][x].direction = 1
        cars[y][x].refreshView()
    }
    
    var body: some View {
        ZStack{
            Color.blue
                .ignoresSafeArea()
            VStack {
                ForEach(cars.indices, id: \.self) { i in
                    HStack {
                        ForEach(cars[i].indices, id: \.self) { j in
                            cars[i][j].image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .onTapGesture {
                                    if !isGameOver{
                                        moves+=1
                                        changeCarLocation(row: i, column: j)
                                        isGameOver = isGameFinished()
                                        if isGameOver{
                                            showAlert=true
                                        }
                                    }
                                }
                        }
                    }
                }
                HStack{
                    Spacer()
                    VStack{
                        Text("Moves: \(moves)")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 25))
                        Button{
                            createGrid()
                            moves=0
                            isGameOver=false
                        }label: {
                            Text("Restart")
                                .foregroundStyle(Color.white)
                        }
                        .padding()
                        .background(isGameOver ? Color.green : Color.red)
                        .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.black.opacity(0.6))
                .cornerRadius(12)
            }
            .padding()
            .onAppear() {
                createGrid()
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
