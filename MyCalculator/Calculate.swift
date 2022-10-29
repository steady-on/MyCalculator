//
//  Calculate.swift
//  MyCalculator
//
//  Created by Ruhen White on 2022/10/30.
//

import Foundation
import Combine

class Calculate: ObservableObject {
    @Published var inputValues: [String] = []
    @Published var calculationLog: String = ""
    @Published var calculationResult: String = ""
    
    func operators(_ operatorInput: String) {
        if inputValues.isEmpty {
            if calculationResult.isEmpty {
                inputValues.append("0")
            } else {
                inputValues.append(calculationResult)
            }
        }
        
        switch operatorInput {
        case "+", "-", "*", "/":
            inputValues.append(operatorInput)
        case "%":
            let percentNum: Double = (Double(inputValues.last ?? "0") ?? 0) * 0.01
            inputValues.removeLast()
            inputValues.append(String(percentNum))
        default:
            break
        }
    }
    
    func equal() {
        var values: [String] = inputValues
        
        while values.contains("*") {
            if let multiply = values.firstIndex(of: "*") {
                let num1 = Double(values.remove(at: multiply-1)) ?? 0
                let num2 = Double(values.remove(at: multiply)) ?? num1
                values[multiply-1] = String(num1 * num2)
            }
        }
        
        while values.contains("/") {
            if let divide = values.firstIndex(of: "/") {
                let num1 = Double(values.remove(at: divide-1)) ?? 0
                let num2 = Double(values.remove(at: divide)) ?? num1
                values[divide-1] = String(num1 / num2)
            }
        }
        
        while values.contains("+") {
            if let plus = values.firstIndex(of: "+") {
                let num1 = Double(values.remove(at: plus-1)) ?? 0
                let num2 = Double(values.remove(at: plus)) ?? num1
                values[plus-1] = String(num1 + num2)
            }
        }
        
        while values.contains("-") {
            if let minus = values.firstIndex(of: "-") {
                let num1 = Double(values.remove(at: minus-1)) ?? 0
                let num2 = Double(values.remove(at: minus)) ?? num1
                values[minus-1] = String(num1 - num2)
            }
        }
        
        inputValues.append("=")
        inputValues += values
        
        calculationLog = inputValues.joined(separator: " ")
    }
}
