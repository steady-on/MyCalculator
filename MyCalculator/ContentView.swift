//
//  ContentView.swift
//  MyCalculator
//
//  Created by Roen White on 2022/10/29.
//
// 메모
// 1. 다중 연산 로직 수정 필요(*, /를 우선 적용, +,-를 후적용 하되, 앞에 있는 것 먼저 계산 하도록
// 1-1. 분모가 0일때 에러처리 필요

import SwiftUI

struct ContentView: View {
    @ObservedObject var calculate: Calculate = Calculate()
    @State private var inputNum: String = "0"
    
    var body: some View {
        VStack(alignment: .trailing) {
            Spacer()
            VStack(spacing: 150) { // Texts area
                Text(calculate.calculationLog).font(.title).foregroundColor(.gray)
                Text(inputNum).font(.largeTitle)
            }.frame(width: 360, alignment: .trailing)
            Spacer()
            ButtonsView(calculate: calculate, inputNum: $inputNum)
        }
        .padding()
    }
}

struct ButtonsView: View {
    
    @ObservedObject var calculate: Calculate
    @State private var isInputOperator: Bool = false
    @Binding var inputNum: String
    
    var body: some View {
        Group { // Buttons area
            HStack {
                VStack {
                    HStack { // AC, BS, % Buttons
                        inputNum == "0" ?
                        Button(action: {allClear()}, label: {Text("AC").modifier(buttonTextStyle())}) :
                        Button(action: {clear()}, label: {Text("C").modifier(buttonTextStyle())})
                        
                        Button(action: {backSpace()}, label: {Image(systemName: "delete.backward.fill").modifier(buttonTextStyle())})
                        Button(action: {calculate.operators("%")}, label: {Text("%").modifier(buttonTextStyle())})
                    }
                    .buttonStyle(.borderedProminent)

                    Group { // Numbers Buttons
                        HStack {
                            Button(action: {inputNumber("7")}, label: {Text("7").modifier(buttonTextStyle())})
                            Button(action: {inputNumber("8")}, label: {Text("8").modifier(buttonTextStyle())})
                            Button(action: {inputNumber("9")}, label: {Text("9").modifier(buttonTextStyle())})
                        }
                        HStack {
                            Button(action: {inputNumber("4")}, label: {Text("4").modifier(buttonTextStyle())})
                            Button(action: {inputNumber("5")}, label: {Text("5").modifier(buttonTextStyle())})
                            Button(action: {inputNumber("6")}, label: {Text("6").modifier(buttonTextStyle())})
                        }
                        HStack {
                            Button(action: {inputNumber("1")}, label: {Text("1").modifier(buttonTextStyle())})
                            Button(action: {inputNumber("2")}, label: {Text("2").modifier(buttonTextStyle())})
                            Button(action: {inputNumber("3")}, label: {Text("3").modifier(buttonTextStyle())})
                        }
                        HStack { // +/-, 0, . Buttons
                            Button(action: {inputNumber("+/-")}, label: {Image(systemName: "plus.forwardslash.minus").modifier(buttonTextStyle())})
                            Button(action: {inputNumber("0")}, label: {Text("0").modifier(buttonTextStyle())})
                            Button(action: {inputNumber(".")}, label: {Text(".").modifier(buttonTextStyle())})
                        }
                    }
                    .buttonStyle(.bordered)
                }
                VStack { // Operator Buttons
                    Button(action: { operatorButtons("/") }, label: {Image(systemName: "divide").modifier(buttonTextStyle())})
                    Button(action: { operatorButtons("*") }, label: {Image(systemName: "multiply").modifier(buttonTextStyle())})
                    Button(action: { operatorButtons("-") }, label: {Image(systemName: "minus").modifier(buttonTextStyle())})
                    Button(action: { operatorButtons("+") }, label: {Image(systemName: "plus").modifier(buttonTextStyle())})
                    Button(action: {
                        calculate.inputValues.append(inputNum)
                        inputNum = calculate.equal()
                    }, label: {Image(systemName: "equal").modifier(buttonTextStyle())})
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
    
    func backSpace() {
        if !isInputOperator {
            if inputNum != "0" {
                if inputNum.count == 1 {
                    inputNum = "0"
                } else {
                    inputNum.removeLast()
                }
            }
        }
    }
    
    func clear() { inputNum = "0" }
    
    func allClear() { // Todo. 클래스 구현하고 구현하기
        calculate.inputValues = []
        calculate.calculationLog = ""
    }
    
    func operatorButtons(_ input: String) {
        if isInputOperator {
            calculate.inputValues.removeLast()
            calculate.inputValues.append(input)
        } else {
            isInputOperator = true
            calculate.inputValues.append(inputNum)
            calculate.inputValues.append(input)
        }
    }
    
    func inputNumber(_ input: String) {
        if calculate.calculationLog.contains("=") {
            allClear()
            clear()
        } else if inputNum == "-0" { inputNum.removeLast() }
        else if isInputOperator {
            isInputOperator = false
            inputNum = ""
        }
        
        switch input {
        case "0":
            if inputNum != "0" { inputNum += "0" }
        case "1"..."9":
            if inputNum == "0" {
                inputNum = input
            } else {
                inputNum += input
            }
        case ".":
            if inputNum.isEmpty { inputNum += "0." }
            else if inputNum == "0" { inputNum += "." }
            else if !inputNum.contains(".") { inputNum += "." }
        case "+/-":
            if inputNum.contains("-") { inputNum.removeFirst() }
            else { inputNum.insert("-", at: inputNum.startIndex) }
        default:
            break
        }
    }
}

struct buttonTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .frame(width: 60, height: 70)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(calculate: Calculate())
    }
}
