//
//  File.swift
//  BenChessApp
//
//  Created by Lei Zhou on 3/20/22.
//

import Foundation
import SwiftUI

enum GridBackGround {
    case black
    case white
}

enum ChessItem: String{
    case white = "circle"
    case black = "circle.fill"
    case nothing = ""
}

struct GridItem: Identifiable,Hashable {
    let id = UUID()
    var background: GridBackGround
    var chess: ChessItem
    var row: Int
    var column: Int
    
}

extension ChessItem {
    var isHidden: Bool{
        if self == .nothing {
            return true
        } else {
            return false
        }
    }
    var nextChess : ChessItem {
        switch self {
        case .black :
            return .white
        case .white :
            return .black
        default :
            return .white
        }
    }
}


extension GridBackGround {
    var color: Color {
        switch self {
        case .black:
            return Color.black
        case .white:
            return Color.white
        }
        
    }
}
