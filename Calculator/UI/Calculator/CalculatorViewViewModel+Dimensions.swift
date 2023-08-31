//
//  CalculatorViewViewModel+Dimensions.swift
//  Calculator
//
//  Created by Tony Ayoub on 31-08-2023.
//

import Foundation

extension CalculatorViewViewModel {
    var buttonSize: CGFloat {
        let usedWidth = screenWidth > 500 ? screenWidth * 0.6 : screenWidth * 0.98
        return (usedWidth - (spacing * CGFloat(columns + 1))) / CGFloat(columns)
    }
    
    var upperRowOperations: [Operation] { // sin, cos, bitcoin
        Operation.advanced.filter { enabledOperations.contains($0) }
    }
    
    var rightColumnOperations: [Operation] { // divide, multiply, subtract, add
        Operation.simple.filter { enabledOperations.contains($0) }
    }
    
    var acButtonWidth: CGFloat {
        let ACButtonLogicalWidth = CGFloat(4 - upperRowOperations.count)
        return ACButtonLogicalWidth * buttonSize + (ACButtonLogicalWidth - 1) * spacing
    }
    

    
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
}
