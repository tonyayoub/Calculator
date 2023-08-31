//
//  Operation.swift
//  Calculator
//
//  Created by Tony Ayoub on 25-08-2023.
//

enum Operation: String, Identifiable {
    var id: Self { self }
    
    case add, subtract, multiply, divide
    case sin, cos, bitCoin
    
    static var advanced: [Operation] { [.sin, .cos, .bitCoin] }
    static var simple: [Operation] { [.divide, .multiply, .subtract, .add] }
    
    var display: String {
        switch self {
        case .sin: return "Sin"
        case .cos: return "Cos"
        case .bitCoin: return "₿"
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        }
    }
}
