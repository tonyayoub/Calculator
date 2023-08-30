//
//  CalculatorViewViewModel.swift
//  Calculator
//
//  Created by Tony Ayoub on 27-08-2023.
//

import SwiftUI
import Combine

class CalculatorViewViewModel: ObservableObject {
    //    @Published var enabledOperations: [Operation] = [.sin, .cos, .bitCoin, .divide, .multiply, .subtract, .add]
    
    @Published var display: String = "0"
    private var currentCalculation = Calculation()
    @Published var enabledOperations: [Operation] = [
        .sin,
        .cos,
        .bitCoin,
        .divide,
        .multiply,
        .subtract,
        .add
    ]
    
    let buttonValue = PassthroughSubject<CalculatorButton, Never>()
    private var bag = Set<AnyCancellable>()
    let columns = 4
    let spacing: CGFloat = 10.0
    var screenWidth = UIScreen.main.bounds.width
    var buttonSize: CGFloat {
        let usedWidth = screenWidth > 500 ? screenWidth * 0.6 : screenWidth * 0.98
        return (usedWidth - (spacing * CGFloat(columns + 1))) / CGFloat(columns)
    }
    
    var upperRowOperations: [Operation] { // sin, cos, bitcoin
        enabledOperations.filter { Operation.advanced.contains($0) }
    }
    
    var rightColumnOperations: [Operation] { // divide, multiply, subtract, add
        enabledOperations.filter { Operation.simple.contains($0) }
    }
    
    var acButtonWidth: CGFloat {
        let ACButtonLogicalWidth = CGFloat(4 - upperRowOperations.count)
        return ACButtonLogicalWidth * buttonSize + (ACButtonLogicalWidth - 1) * spacing
    }
    
    let middleNumberRows: [[CalculatorButton]] = [
        [.one, .two, .three],
        [.four, .five, .six],
        [.seven, .eight, .nine],
    ]
    
    var rightColumn: [CalculatorButton] {
        if rightColumnOperations.isEmpty {
            return [.equals]
        } else if rightColumnOperations.count == 4 {
            return [.divide, .multiply, .subtract] // add will be part of the lower row
        } else {
            return rightColumnOperations.map { CalculatorButton.createCalculatorButton(from: $0) }
        }
    }
    
    var rightColumnButtonHeight: CGFloat {
        switch rightColumnOperations .count {
        case 0, 1: return 3 * buttonSize + 2 * spacing
        case 2: return 2 * buttonSize + spacing
        default: return buttonSize
        }
    }
    
    var bottomRow: [CalculatorButton] {
        if rightColumnOperations.count == 4 {
            return [.zero, .dot, .equals, .add]
        } else if rightColumnOperations.isEmpty {
            return [.zero, .dot] // "=" will occupy the right column
        } else {
            return [.zero, .dot, .equals]
        }
    }
    
    var zeroButtonWidth: CGFloat {
        switch rightColumnOperations.count {
        case 0, 1, 3: return 2 * buttonSize + spacing
        default: return buttonSize
        }
    }
    
    var dotButtonWidth: CGFloat {
        rightColumnOperations.isEmpty ? 2 * buttonSize + spacing : buttonSize
    }
    
    var equalsButtonHeight: CGFloat {
        rightColumnOperations.isEmpty ? 4 * buttonSize + 3 * spacing : buttonSize
    }
    
    var tallRightColumn: Bool {
        rightColumn.count == 2
    }
    
    init() {
        buttonValue
            .sink {
                print($0)
                self.currentCalculation = self.buttonTapped(button: $0, currentCalculation: self.currentCalculation) ?? Calculation()
//                self.buttonTapped($0)
            }
            .store(in: &bag)
    }
    
    func buttonTapped(button: CalculatorButton, currentCalculation: Calculation) -> Calculation? {
        var updatedCalculation = currentCalculation
        switch button {
        case .ac:
            display = "0"
            updatedCalculation.storedValue = nil
            updatedCalculation.pendingOperation = nil
        case .dot:
            if !display.contains(".") {
                display += "."
            }
        case .equals:
            guard let storedValue = currentCalculation.storedValue,
                  let pendingOperation = currentCalculation.pendingOperation,
                  let currentValue = Double(display) else {
                updatedCalculation.displayingResult = true // For when the user taps '=' twice
                return updatedCalculation
            }
            display = String(format: "%g", pendingOperation(storedValue, currentValue))
            updatedCalculation.storedValue = nil
            updatedCalculation.pendingOperation = nil
            updatedCalculation.displayingResult = true
        case .add:
            updatedCalculation = setPendingOperation(operation: { $0 + $1 }, currentCalculation: currentCalculation)
//             setPendingOperation { $0 + $1 }
        case .subtract:
            updatedCalculation = setPendingOperation(operation: { $0 - $1 }, currentCalculation: currentCalculation)
        case .multiply:
            updatedCalculation = setPendingOperation(operation: { $0 - $1 }, currentCalculation: currentCalculation)
        case .divide:
            updatedCalculation = setPendingOperation(operation: { $0 / $1 }, currentCalculation: currentCalculation)
        case .sin:
            if let value = Double(display) {
                let result = "\(sin(value * .pi / 180.0))"
                display = String(result.prefix(10))
                updatedCalculation.displayingResult = true
            }
        case .cos:
            if let value = Double(display) {
                let result = "\(cos(value * .pi / 180.0))"
                display = String(result.prefix(10))
                updatedCalculation.displayingResult = true
            }
        default:
            if display == "0" || currentCalculation.displayingResult {
                display = button.title
                updatedCalculation.displayingResult = false
            } else {
                display += button.title
            }
        }
        
        return updatedCalculation
    }
        
    func setPendingOperation(
        operation: @escaping (Double, Double) -> Double,
        currentCalculation: Calculation
    ) -> Calculation {
        var updatedCalculation = currentCalculation
        print("Setting pending operation...")
        if let storedValue = currentCalculation.storedValue,
           let currentValue = Double(display),
           let pendingOperation = currentCalculation.pendingOperation {
            let result = pendingOperation(storedValue, currentValue)
            updatedCalculation.storedValue = result
            display = "0"
        } else if let value = Double(display) {
            updatedCalculation.storedValue = value
            display = "0"
        }
        updatedCalculation.pendingOperation = operation
        return updatedCalculation
    }
}
