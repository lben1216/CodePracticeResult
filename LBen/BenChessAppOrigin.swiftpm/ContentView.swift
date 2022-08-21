import SwiftUI
import SwiftUI

struct MyContentView : View {
    @State var vm = ChessViewModel()
    
    var body: some View{

        VStack(spacing:0){
            ForEach (vm.grid,id:\.self){ row in
                HStack(spacing:0){
                    ForEach (row){ item in
                        GrideItemView(item: item)
                            .onTapGesture {
                                vm.tap(item: item)
                            }
                    }
                }
            }
        }
    }
}

struct GrideItemView : View {
    var item : GridItem
    var body: some View{
        ZStack{
            Rectangle()
                .fill(item.background.color)
            Image(systemName: item.chess.rawValue)
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .padding(10)
        }
        .frame(width: 30, height: 30)
    }
}
