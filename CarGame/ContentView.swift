import SwiftUI

struct ContentView: View {
    @State var moves: Int = 0
    @State var cars: [[Car]] = [[]]

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
    
    var body: some View {
        VStack {
            ForEach(cars.indices, id: \.self) { i in
                HStack {
                    ForEach(cars[i].indices, id: \.self) { j in
                        cars[i][j].image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                changeCarLocation(row: i, column: j)
                                moves+=1
                            }
                    }
                }
            }
            Text("Moves: \(moves)")
        }
        .padding()
        .onAppear() {
            for i in 0..<6 {
                cars.append([])
                for j in 0..<6 {
                    cars[i].append(Car(direction: Int.random(in: 0..<4)))
                    cars[i][j].refreshView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
