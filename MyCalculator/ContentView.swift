//
//  ContentView.swift
//  MyCalculator
//
//  Created by Ruhen White on 2022/10/29.
//

import SwiftUI

struct ContentView: View {
    @State private var calculationLog = ""
    @State private var inputNum = "0"
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 150) { // Texts area
                Text(calculationLog).font(.title).foregroundColor(.gray)
                Text(inputNum).font(.largeTitle)
            }.frame(width: 360, alignment: .trailing)
            Spacer()
            ButtonsView(calculationLog: $calculationLog, inputNum: $inputNum)
        }
        .padding()
    }
}

struct ButtonsView: View {
    @Binding var calculationLog: String
    @Binding var inputNum: String
    
    var body: some View {
        Group { // Buttons area
            HStack {
                VStack {
                    HStack{ // AC, BS, % Buttons
                        Button(action: {print("AC or C")}, label: {Text("AC").modifier(buttonTextStyle())})
                        Button(action: {backSpace()}, label: {Image(systemName: "delete.backward.fill").modifier(buttonTextStyle())})
                        Button(action: {print("%")}, label: {Text("%").modifier(buttonTextStyle())})
                    }
                    .buttonStyle(.borderedProminent)

                    Group { // Numbers Buttons
                        HStack{
                            Button(action: {print("7")}, label: {Text("7").modifier(buttonTextStyle())})
                            Button(action: {print("8")}, label: {Text("8").modifier(buttonTextStyle())})
                            Button(action: {print("9")}, label: {Text("9").modifier(buttonTextStyle())})
                        }
                        HStack{
                            Button(action: {print("4")}, label: {Text("4").modifier(buttonTextStyle())})
                            Button(action: {print("5")}, label: {Text("5").modifier(buttonTextStyle())})
                            Button(action: {print("6")}, label: {Text("6").modifier(buttonTextStyle())})
                        }
                        HStack{
                            Button(action: {print("1")}, label: {Text("1").modifier(buttonTextStyle())})
                            Button(action: {print("2")}, label: {Text("2").modifier(buttonTextStyle())})
                            Button(action: {print("3")}, label: {Text("3").modifier(buttonTextStyle())})
                        }
                        HStack{ // +/-, 0, . Buttons
                            Button(action: {print("plus/minus")}, label: {Image(systemName: "plus.forwardslash.minus").modifier(buttonTextStyle())})
                            Button(action: {print("0")}, label: {Text("0").modifier(buttonTextStyle())})
                            Button(action: {print(".")}, label: {Text(".").modifier(buttonTextStyle())})
                        }
                    }
                    .buttonStyle(.bordered)
                }
                VStack { // Operator Buttons
                    Button(action: {print("divide")}, label: {Image(systemName: "divide").modifier(buttonTextStyle())})
                    Button(action: {print("multiply")}, label: {Image(systemName: "multiply").modifier(buttonTextStyle())})
                    Button(action: {print("minus")}, label: {Image(systemName: "minus").modifier(buttonTextStyle())})
                    Button(action: {print("plus")}, label: {Image(systemName: "plus").modifier(buttonTextStyle())})
                    Button(action: {print("equal")}, label: {Image(systemName: "equal").modifier(buttonTextStyle())})
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
    
    func backSpace() {
        if inputNum != "0" {
            if inputNum.count == 1 {
                inputNum = "0"
            } else {
                inputNum.removeLast()
            }
        }
    }
    
    func clear() {
        inputNum = "0"
    }
    
    func allClear() { // Todo. 클래스 구현하고 구현하기
        
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
        ContentView()
    }
}
