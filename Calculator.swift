//
//  Calculator.swift
//  Calculator
//
//  Created by Victor Wu on 3/18/16.
//  Copyright © 2016 wayfair. All rights reserved.
//

import Foundation

func add(a: Double, b: Double) -> Double {
    let result = a + b
    return result
}
func sub(a: Double, b: Double) -> Double {
    let result = a - b
    return result
}
func mul(a: Double, b: Double) -> Double {
    let result = a * b
    return result
}
func div(a: Double, b: Double) -> Double {
    let result = a / b
    return result
}

typealias Binop = (Double, Double) -> Double
let ops: [String: Binop] = [ "+" : add, "-" : sub, "*" : mul, "/" : div ]

class Calculator {
    static let sharedInstance = Calculator()
    
    private init() {
    
    }

    var currentOutput: String = ""
    var currentNumber: String = ""
    var numberStack = Stack<Double>()
    var operationStack = Stack<String>()
    var hasDecimal : Bool = false
    var isMultOrDiv: Bool = false
    
    func addNumber(number: String) {
        currentNumber = currentNumber + number
        currentOutput = currentOutput + number
    }
    
    func addOperation(operation: String) {
        if(currentNumber != "") {
            numberStack.push (Double(currentNumber)!)
            currentNumber = ""
        
            if(isMultOrDiv == true){
                doMultOrDiv()
                isMultOrDiv = false
            }
            
            currentOutput = currentOutput + " " + operation + " "
            operationStack.push(operation)
        
            hasDecimal = false
            
        }
        
        if(currentOutput != ""){
            if(operation == "/" || operation == "*"){
                isMultOrDiv = true
            }
        }
        
    }
    
    func doMultOrDiv() {
        let secondNumber = numberStack.pop()
        let firstNumber = numberStack.pop()
        let operation = ops[operationStack.pop()]
        
        let newNumber = operation!(firstNumber, secondNumber)
        
        numberStack.push(newNumber)
    }
    
    func doEquals() {
        if let current = Double(currentNumber) where (currentOutput != "" && !numberStack.isEmpty() && !operationStack.isEmpty()) {
            
            var calculatedNumber: Double = 0.0
            
            numberStack.push(current)
            
            while(!operationStack.isEmpty() && !numberStack.isEmpty()){
                let secondNumber = numberStack.pop()
                let firstNumber = numberStack.pop()
                
                if let operation = ops[operationStack.pop()]{
                    let newNumber = operation(firstNumber, secondNumber)
                
                    numberStack.push(newNumber)
                    calculatedNumber = newNumber
                }
            }
            clearOutput()
            
            let isInt = (floor(calculatedNumber) == calculatedNumber)
            if(isInt){
                let intOutput = Int(calculatedNumber)
                currentOutput = "\(intOutput)"
            } else {
                currentOutput = "\(calculatedNumber)"
            }
            
            currentNumber = currentOutput
        }
    }
    
    func clearOutput() {
        currentNumber = ""
        currentOutput = ""
        numberStack.popAll()
        operationStack.popAll()
        hasDecimal = false
        isMultOrDiv = false
    }
    
    func changeSign() {
        var index = currentNumber.startIndex.advancedBy(0)
        var newNumber:String!
        
        if(currentNumber[index] != "-"){
            newNumber = "-\(currentNumber)"
        } else {
            index = currentNumber.startIndex.advancedBy(1)
            newNumber = currentNumber.substringFromIndex(index)
        }
        
        
        updateOutput(currentNumber, newNumber: newNumber)
    }
    
    func percent() {
        var newNumber: Double = Double(currentNumber)!
        newNumber = newNumber / 100
        
        updateOutput(currentNumber, newNumber: "\(newNumber)")
    }
    
    func addDecimal() {
        if(!hasDecimal && currentNumber != "") {
            currentNumber = currentNumber + "."
            currentOutput = currentOutput + "."
            hasDecimal = true
        }
    }
    
    func updateOutput(removeNumber: String, newNumber: String) {
        let currentNumberLength = removeNumber.characters.count
        
        let index = currentOutput.endIndex.advancedBy(-currentNumberLength)
        
        currentOutput = currentOutput.substringToIndex(index)
        currentOutput += newNumber
        currentNumber = newNumber
    }
    
    func getCurrentOutput() -> String {
        return currentOutput
    }
}

struct Stack<Element> {
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    mutating func popAll() {
        while(!isEmpty()) {
            self.pop()
        }
    }
    
    func isEmpty() -> Bool {
        if(items.last != nil) {
            return false
        }
        return true
    }
    
    func peek() -> Element? {
        return items.last
    }
}
