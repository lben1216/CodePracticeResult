//
//  File.swift
//  BenChessApp
//
//  Created by Lei Zhou on 3/20/22.
//

import Foundation
struct ChessViewModel {
    var gridSize = 19
    var grid : [[GridItem]] = []
    var isWhite : Bool = false
    init(){
        for i in 1...gridSize{
            var row : [GridItem] = []
            for j in 1...gridSize{
                        row.append(GridItem(background:  GridBackGround.black , chess: .nothing))
                }
            grid.append(row)
        }
    }
    mutating func tap(item:GridItem){
            if isWhite{
                isWhite = false
                tapChess(chess: .white, item: item)
            }else{
                isWhite = true
                tapChess(chess: .black, item: item)
            }
        }

    mutating func tapChess(chess: ChessItem,item:GridItem){
           for row in 0..<gridSize {
               for i in 0..<gridSize{
                   if grid[row][i].id == item.id{
                       grid[row][i].chess = chess
                       return
                   }
               }
           }
    }
    
}

