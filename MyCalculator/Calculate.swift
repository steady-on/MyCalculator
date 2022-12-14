//
//  Calculate.swift
//  MyCalculator
//
//  Created by Roen White on 2022/10/30.
//

import Foundation
import Combine

class Calculate: ObservableObject {
    @Published var inputValues: [String] = []
    @Published var calculationLog: String = ""
    @Published var calculationResult: String = ""
        
    func equal() -> String {
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
                
                if num2 == 0 {  }
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
        calculationResult = values.last ?? "0"
        calculationLog = inputValues.joined(separator: " ")
        return calculationResult
    }
}
