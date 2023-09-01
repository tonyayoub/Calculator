//
//  UpperRow.swift
//  Calculator
//
//  Created by Tony Ayoub on 26-08-2023.
//

import SwiftUI
import Combine

struct UpperRow: View {
    @EnvironmentObject var viewModel: CalculatorViewViewModel
    let spacing: CGFloat = 10.0
    var body: some View {
        return HStack(spacing: spacing) {
            SquareButton(
                width: viewModel.acButtonWidth,
                height: viewModel.buttonSize,
                value: viewModel.buttonValue,
                calculatorButton: .ac
            )
            
            ForEach(viewModel.upperRowOperations) { operation in
                SquareButton(
                    width: viewModel.buttonSize,
                    height: viewModel.buttonSize,
                    value: viewModel.buttonValue,
                    calculatorButton: CalculatorButton.createCalculatorButton(from: operation)
                )
            }
        }
    }
}

#Preview {
    UpperRow()
}
