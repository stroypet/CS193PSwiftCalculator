//
//  CalculatorBrain.swift
//  Calculator
//  Stanford CS193P Spring 2016 Class.
//  Stanley Petley, 2/5/16.

import Foundation

//enum Optional {
//    case None
//    case Some(T)
//}
//}

class CalculatorBrain
{
    private var accumulator = 0.0 //inferred as Double, don't need ": Double"
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private var operations: Dictionary<String,Operation> = [ //generic type like Java (keys and values).
        "π" : Operation.Constant(M_PI), //applied M_PI as associated value,
        "e" : Operation.Constant(M_E), //applied M_E too,
        "√" : Operation.UnaryOperation(sqrt), //sqrt
        "cos" : Operation.UnaryOperation(cos), //cos
        "×" : Operation.BinaryOperation({$0 * $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "−" : Operation.BinaryOperation({$0 - $1}),
        "=" : Operation.Equals
    ]
    
    private enum Operation { //enum is discrete set of values, like Java, enums are allowed to have methods, but no vars or inheritence.
        case Constant(Double) //made Double it's associated value.
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation { //infers operation is the same as Operation because we pull from    operations which has Operation as it's value.
            case .Constant(let value):
                accumulator = value //infers Operation.Constant, but how do we get associated value out?
            case .UnaryOperation(let function):
                accumulator = function(accumulator) //Functions are just a type. "function" here is just a local variable that is a function that takes a double and returns a double.
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals: executePendingBinaryOperation()
            }
        }
        
        //OLD CODE
        //if let constant = operations[symbol] { //added from using operations lookup Dict.
        //accumulator = constant //must unwrap, can crash without if let, so we add if let and don't                              use !
        //}
        //switch symbol {
        //case "π": accumulator = M_PI
        //case "√": accumulator = sqrt(accumulator)
        //default: break
        //}
    }
    

    private func executePendingBinaryOperation()
    {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    private var pending: PendingBinaryOperationInfo? //Optional, can be nil.
    
    private struct PendingBinaryOperationInfo { //struct is almost identical to class, no inheritence, but structs are passed by value, not reference like class
        var binaryFunction: (Double, Double) -> Double //Swift will only copy struct once it's mutated -> Swift performance enhancement.
        var firstOperand: Double
    }
    
    var result: Double { //read only property, only uses get.
        get {
            return accumulator
        }
    }
}