//
//  File.swift
//  BenChessApp
//
//  Created by Lei Zhou on 3/20/22.
//

import Foundation
struct ChessViewModel {
    var gridSize = 8
    var grid : [[GridItem]] = []
    var isWhite : Bool = false
    init(){
        for i in 1...gridSize{
            var row : [GridItem] = []
            for j in 1...gridSize{
                    row.append(GridItem(
                        background: (i+j)%2 == 0 ? .black : .white,
                        chess: .nothing,
                        row: i-1, column: j-1
                    ))
                
            }
            grid.append(row)
        }
    }
    mutating func tap(item:GridItem){
        if item.chess == .nothing {
            grid[item.row][item.column].chess = isWhite ? .white : .black
            isWhite.toggle()
            
        }
            
        }

//    mutating func tapChess(chess: ChessItem,item:GridItem){
//           for row in 0..<gridSize {
//               for i in 0..<gridSize{
//                   if grid[row][i].id == item.id{
//                       grid[row][i].chess = chess
//                       return
//                   }
//               }
//           }
//    }
    
}

