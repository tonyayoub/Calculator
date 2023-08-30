//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Tony Ayoub on 24-08-2023.
//

import SwiftUI

enum CalculatorButton: String, CaseIterable {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case ac, dot, equals
    case add, subtract, multiply, divide
    case sin, cos
    case bitCoin
    case empty

    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .ac: return "AC"
        case .dot: return "."
        case .equals: return "="
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .sin: return "sin"
        case .cos: return "cos"
        case .bitCoin: return "₿"
        case .empty: return ""
        }
    }
    
    var color: Color {
        switch self {
        case .ac: return .red
        case .equals, .add, .subtract, .multiply, .divide: return .orange
        case .empty: return .clear
        default: return .gray
        }
    }
    
    static func createCalculatorButton(from operation: Operation) -> CalculatorButton {
        switch operation {
        case .add: return .add
        case .subtract: return .subtract
        case .multiply: return .multiply
        case .divide: return .divide
        case .sin: return .sin
        case .cos: return .cos
        case .bitCoin: return .bitCoin
        }
    }
}
