//
//  CalculatorBrain.swift
//  calculatorApp
//
//  Created by Lei Zhou on 2/20/22.
//

import Foundation

enum CalculatorBrain {
    case left(String)
    case leftOp(left:String,op: CalculatorButtonItem.Op)
    case leftOpRight(left:String,op:CalculatorButtonItem.Op,right:String)
    case error
    
    var output: String {
        let result: String
        switch self {
        case .left(let left):
            result = left
        case .leftOp(left: let left, op: _):
            result = left
        case .leftOpRight(left: _, op: _, right: let right):
            result = right
        case .error:
            result = "ERROR"
        }
        guard let value = Double(result) else {
            return "ERROR"
        }
        return formatter.string(from: value as NSNumber)!
    }
    
    func apply(item: CalculatorButtonItem) -> CalculatorBrain {
        switch item {
        case .digit(let num):
            return applyNumber(num: num)
        case .op(let op):
            return applyOp(op: op)
        case .dot:
            return applyDot()
        case .command(let cmd):
            return applyCommand(command: cmd)
        
        }
    }
    
    private func applyOp(op: CalculatorButtonItem.Op) -> CalculatorBrain {
        switch self {
            case .left(let left):
                return CalculatorBrain.leftOp(left: left, op: op)
        case .leftOp(left: let left, op: _):
            return CalculatorBrain.leftOp(left: left, op: op)
        case .leftOpRight(left: let left, op: let oldOp, right: let right):
            switch op{
            case .plus, .multiply, .divide, .minus:
                if let result = oldOp.calculate(left: left, right: right){
                    return .leftOp(left: result, op: op)
                }
                else{
                    return .error
                }
            case .equal:
                if let result = oldOp.calculate(left: left, right: right){
                    return .leftOp(left: result, op: oldOp)
                }
                else{
                    return .error
                }
            }
 
        case .error:
            return self
        }
    }
    
    private func applyCommand(command: CalculatorButtonItem.Command) -> CalculatorBrain {
         switch command {
         case .opposite:
             switch self {
             case .left(let left):
                 return .left(left.flipped())
             case .leftOp(left: let left, op: let op):
                 return CalculatorBrain.leftOpRight(left: left, op: op, right: "0")

             case .leftOpRight(left: let left, op: let op, right: let right):
                 return .leftOpRight(left: left, op: op, right: right.flipped())
             case .error:
                 return self
             }

         case .clear:
             return CalculatorBrain.left("0")
         case .percent:
             switch self{
             case .left(let left):
                 return CalculatorBrain.left(left.percent())
             case .leftOp(left: let left, op: let op):
                 return CalculatorBrain.leftOpRight(left: left, op: op, right: "0")
             case .leftOpRight(left: let left, op: let op, right: let right):
                 return CalculatorBrain.leftOpRight(left: left, op: op, right: right.percent())
             case .error:
                 return self
             }
         }
     }
    private func applyDot() -> CalculatorBrain {
         switch self {
         case .left(let left):
             return CalculatorBrain.left(left.applyDot())
         case .leftOp(left: let left, op: let op):
             return CalculatorBrain.leftOpRight(left: left, op: op, right: "0.")
         case .leftOpRight(left: let left, op: let op, right: let right):
             return CalculatorBrain.leftOpRight(left: left, op: op, right: right.applyDot())
             
         case .error:
             return .error
         }
     }
    
    private func applyNumber(num : Int) -> CalculatorBrain{
        switch self {
        case .left(let left):
            return left == "0" ? .left("\(num)") : .left("\(left)\(num)")
        case .leftOp(left: let left, op: let op):
            return .leftOpRight(left: left, op: op, right: "\(num)")
        case .leftOpRight(left: let left, op: let op, right: let right):
            return right == "0" ?
            .leftOpRight(left: left, op: op, right: "\(num)") :
            .leftOpRight(left: left, op: op, right: "\(right)\(num)")
        case .error:
            return self
        }
    }

}
extension CalculatorButtonItem.Op {
    func calculate(left:String,right:String) -> String? {
        guard let left = Double(left), let right = Double(right) else {
            return nil
        }
        switch self {
            
        case .plus:
            return String(left + right)
        case .minus:
            return String(left - right)
        case .multiply:
            return String(left * right)
        case .divide:
            return right == 0 ? "0" : String(left / right)
        case .equal:
            return nil
        }
       // return ""
    }
}
extension String {
    var containsDot : Bool {
        return contains(".")
    }
    func applyDot()  -> String {
        return containsDot ? self  : "\(self)."
    }
    
    var startwithNegative : Bool {
        return starts(with: "-")
    }
    func flipped() -> String {
        if startwithNegative {
            var s = self
            s.removeFirst()
            return s
        } else{
            return "-\(self)"
        }
    }
    func percent() -> String {
        return String((Double(self) ?? 0)/100)
    }
}
var formatter: NumberFormatter = {
    let f = NumberFormatter()
    f.minimumFractionDigits = 0
    f.maximumFractionDigits = 8
    f.numberStyle = .decimal
    return f
}()
