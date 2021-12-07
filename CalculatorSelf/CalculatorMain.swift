//
//  CalculatorMain.swift
//  CalculatorSelf
//
//  Created by LrUCiA on 2021/11/14.
//

import Foundation

class CalculatorMain {
    var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
let operationForCalculator: Dictionary <String, KindsOfOperation> = [
    "+": .BinaryOperation({$0+$1}),
    "-": .BinaryOperation({$0-$1}),
    "÷": .BinaryOperation({$0/$1}),
    "×": .BinaryOperation({$0*$1}),
    "+ / −": .UniOperation({-$0}),
    "AC": .Constant(0),
    "√": .UniOperation(sqrt),
    "∏": .Constant(.pi),
    "=": .Equal
]

enum KindsOfOperation {
    case BinaryOperation((Double, Double) -> Double)
    case UniOperation((Double) -> Double)
    case Constant(Double)
    case Equal
}
    
    func startOperation(symbol: String) {
        if let calculate = operationForCalculator[symbol] {
            switch calculate {
            case .UniOperation(let uniFunction):
                accumulator = uniFunction(accumulator)
            case .BinaryOperation(let biFunction):
                clickDirectOperation()
                saveOperation = SaveForNextOperation(nextOperation: biFunction, firstOperhand: accumulator)
            case .Constant(let constant):
                accumulator = constant
            case .Equal:
                clickDirectOperation()
            }
        }
    }
    
    var saveOperation: SaveForNextOperation?
    
    struct SaveForNextOperation {
        var nextOperation: (Double, Double) -> Double
        var firstOperhand: Double
    }
    
    func clickDirectOperation() {
        if saveOperation != nil {
            accumulator = saveOperation!.nextOperation(saveOperation!.firstOperhand, accumulator)
            saveOperation = nil
        }
    }
    var result: Double {
        get {
            return accumulator
    }
}

}
