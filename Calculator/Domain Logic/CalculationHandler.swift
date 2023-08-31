//
//  CalculationHandler.swift
//  Calculator
//
//  Created by Tony Ayoub on 30-08-2023.
//

import Foundation

struct CalculationHandler {
    
    static func updateCalculation(
        button: CalculatorButton,
        currentCalculation: Calculation
    ) -> Calculation {
        var updatedCalculation = currentCalculation
        switch button {
        case .ac:
            updatedCalculation.displayedValue = "0"
            updatedCalculation.storedValue = nil
            updatedCalculation.pendingOperation = nil
        case .dot:
            if currentCalculation.displayingResult {
                updatedCalculation.displayedValue = "0."
                updatedCalculation.displayingResult = false
            } else if !currentCalculation.displayedValue.contains(".") {
                updatedCalculation.displayedValue = currentCalculation.displayedValue + "."
            }
        case .equals:
            guard let storedValue = currentCalculation.storedValue,
                  let pendingOperation = currentCalculation.pendingOperation,
                  let currentValue = Double(currentCalculation.displayedValue) else {
                updatedCalculation.displayingResult = true // For when the user taps '=' twice
                return updatedCalculation
            }
            updatedCalculation.displayedValue = String(format: "%g", pendingOperation(storedValue, currentValue))
            updatedCalculation.storedValue = nil
            updatedCalculation.pendingOperation = nil
            updatedCalculation.displayingResult = true
        case .add:
            updatedCalculation = updatePendingOperation(operation: { $0 + $1 }, currentCalculation: currentCalculation)
        case .subtract:
            updatedCalculation = updatePendingOperation(operation: { $0 - $1 }, currentCalculation: currentCalculation)
        case .multiply:
            updatedCalculation = updatePendingOperation(operation: { $0 * $1 }, currentCalculation: currentCalculation)
        case .divide:
            updatedCalculation = updatePendingOperation(operation: { $0 / $1 }, currentCalculation: currentCalculation)
        case .sin:
            if let value = Double(currentCalculation.displayedValue) {
                let result = "\(sin(value * .pi / 180.0))"
                updatedCalculation.displayedValue = String(result.prefix(10))
                updatedCalculation.displayingResult = true
            }
        case .cos:
            if let value = Double(currentCalculation.displayedValue) {
                let result = "\(cos(value * .pi / 180.0))"
                updatedCalculation.displayedValue = String(result.prefix(10))
                updatedCalculation.displayingResult = true
            }
        case .bitCoin:
            fatalError("Bitcoin operation should be directed to service.")
        default:
            if currentCalculation.displayedValue == "0" || currentCalculation.displayingResult {
                updatedCalculation.displayedValue = button.title
                updatedCalculation.displayingResult = false
            } else {
                if updatedCalculation.displayedValue.count < 12 {
                    updatedCalculation.displayedValue += button.title
                }
                
            }
        }
        
        return updatedCalculation
    }
        
    static func updatePendingOperation(
        operation: @escaping (Double, Double) -> Double,
        currentCalculation: Calculation
    ) -> Calculation {
        var updatedCalculation = currentCalculation
        if let storedValue = currentCalculation.storedValue,
           let currentValue = Double(currentCalculation.displayedValue),
           let pendingOperation = currentCalculation.pendingOperation {
            let result = pendingOperation(storedValue, currentValue)
            updatedCalculation.storedValue = result
            updatedCalculation.displayedValue = "0"
        } else if let value = Double(currentCalculation.displayedValue) {
            updatedCalculation.storedValue = value
            updatedCalculation.displayedValue = "0"
        }
        updatedCalculation.pendingOperation = operation
        return updatedCalculation
    }
}
