//
//  CalculatorBrain.swift
//  testCalculator
//
//  Created by Sravan on 26/12/15.
//  Copyright © 2015 pioneer11x. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op {
        
        case Operand(Double)
        case UnaryOperation(String,( Double -> Double))
        case BinaryOperation(String,( Double , Double ) -> Double)
        
    }
    private var opStack = Array<Op>()
    private var knownOps = [String:Op]()
    
    init (){
        knownOps["*"] = Op.BinaryOperation("*",*)
        knownOps["/"] = Op.BinaryOperation("/"){$1 / $0}
        knownOps["-"] = Op.BinaryOperation("-"){$1 - $0}
        knownOps["+"] = Op.BinaryOperation("+",+)
        
        knownOps["sqrt"] = Op.UnaryOperation("sqrt",sqrt)
        
    }
    
    private func evaluate(var ops: [Op]) -> ( result: Double?,remainingStack: [Op]){
        
        if !ops.isEmpty{
            let op = ops.removeLast()
            
            switch op{
            case .Operand(let operand):
                return (operand,ops)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(ops)
                if let operand = operandEvaluation.result{
                    return (operation(operand), operandEvaluation.remainingStack)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(ops)
                if let operand1 = op1Evaluation.result{
                    let op2Evaluation = evaluate(op1Evaluation.remainingStack)
                    if let operand2 = op2Evaluation.result{
                        return (operation(operand1,operand2),op2Evaluation.remainingStack)
                    }
                }
                
                
            }
        }
        
        
        return (nil,ops)
        
    }
    
    func evaluate() -> Double? {
        let (result , _) = evaluate(opStack)
        return result
    }
    
    func pushOperand( operand : Double ) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation( symbol: String){
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
    }
    
}
