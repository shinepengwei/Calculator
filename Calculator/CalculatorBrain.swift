//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by yangpengwei on 15/6/11.
//  Copyright (c) 2015年 yangpengwei. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private enum Op:Printable
    {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String{
            get{
                switch self{
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _ ):
                    return symbol
                case .BinaryOperation(let symbol, _ ):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()
    
    init(){
        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷", {$1 / $0})
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("−", {$1 - $0})
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
    }
    
    private func evaluate(ops: [Op])-> (result : Double?, remainOps : [Op]){
        if !ops.isEmpty{
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op{
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_ , let operation):
                let operrandEvaluation = evaluate(remainingOps)
                if let operand = operrandEvaluation.result{
                    return (operation(operand), operrandEvaluation.remainOps)
                }
            case .BinaryOperation(_ , let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result{
                    let op2Evaluation = evaluate(op1Evaluation.remainOps)
                    if let operand2 = op2Evaluation.result{
                        return (operation(operand1, operand2), op2Evaluation.remainOps)
                    }
                }
            }
        
        }
        return (nil,ops)
    }
    
    func evaluate() -> Double?{
        let (result, remainOp ) = evaluate(opStack)
        println("opStack:\(opStack), result = \(result), remainStack :\(remainOp)")
        return result
    }
    
    func pushOperand(operand: Double) -> Double!{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol : String) -> Double!{
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
    
    
}
