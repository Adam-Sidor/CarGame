import SwiftUI

struct ContentView: View {
    @State var carsDirection: [[Int]] = Array(repeating: Array(repeating: 0, count: 6), count: 6)
    @State var carsImages: [[Image]] = Array(repeating: Array(repeating: Image("car1"), count: 6), count: 6)
    
    func refreshCarView(row:Int,column:Int){
        carsImages[row][column] = Image("car" + String(carsDirection[row][column]))
    }
    
    func changeCarLocation(row:Int,column:Int){
        if(carsDirection[row][column]==1){
            if row>0{
                if carsDirection[row-1][column] == 0{
                    carsDirection[row][column]=0;
                    carsDirection[row-1][column]=1;
                    refreshCarView(row: row-1, column: column)
                }
            }
            else{
                carsDirection[row][column]=0;
            }
            
        }
        if(carsDirection[row][column]==2){
            if column<5{
                if carsDirection[row][column+1] == 0{
                    carsDirection[row][column]=0;
                    carsDirection[row][column+1]=2;
                    refreshCarView(row: row, column: column+1)
                }
            }
            else{
                carsDirection[row][column]=0;
            }
            
        }
        if(carsDirection[row][column]==3){
            if row<5{
                if carsDirection[row+1][column] == 0{
                    carsDirection[row][column]=0;
                    carsDirection[row+1][column]=3;
                    refreshCarView(row: row+1, column: column)
                }
            }
            else{
                carsDirection[row][column]=0;
            }
            
        }
        if(carsDirection[row][column]==4){
            if column>0{
                if carsDirection[row][column-1] == 0{
                    carsDirection[row][column]=0;
                    carsDirection[row][column-1]=4;
                    refreshCarView(row: row, column: column-1)
                }
            }
            else{
                carsDirection[row][column]=0;
            }
            
        }
        refreshCarView(row: row, column: column)
    }
    
    var body: some View {
        VStack {
            ForEach(carsImages.indices, id: \.self) { i in
                HStack {
                    ForEach(carsImages[i].indices, id: \.self) { j in
                            carsImages[i][j]
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                changeCarLocation(row: i, column: j)
                            }
                    }
                }
                
            }
        }
        .padding()
        .onAppear() {
            carsDirection = (0..<6).map { _ in
                        (0..<6).map { _ in
                            Int.random(in: 0...3)
                        }
                    }
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
