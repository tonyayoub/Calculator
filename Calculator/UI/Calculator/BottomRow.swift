//
//  BottomRow.swift
//  Calculator
//
//  Created by Tony Ayoub on 27-08-2023.
//

import SwiftUI
import Combine

struct BottomRow: View {
    @EnvironmentObject var viewModel: CalculatorViewViewModel
    var body: some View {
        HStack(spacing: 10) {
            SquareButton(
                width: viewModel.zeroButtonWidth,
                height: viewModel.buttonSize,
                value: viewModel.buttonValue,
                calculatorButton: .zero
            )
            
            SquareButton(
                width: viewModel.dotButtonWidth,
                height: viewModel.buttonSize,
                value: viewModel.buttonValue,
                calculatorButton: .dot
            )
            
            if viewModel.bottomRow.contains(.equals) {
                SquareButton(
                    width: viewModel.buttonSize,
                    height: viewModel.buttonSize,
                    value: viewModel.buttonValue,
                    calculatorButton: .equals
                )
            }
            
            if viewModel.bottomRow.contains(.add) {
                SquareButton(
                    width: viewModel.buttonSize,
                    height: viewModel.buttonSize,
                    value: viewModel.buttonValue,
                    calculatorButton: .add
                )
            }
        }
    }
}

#Preview {
    BottomRow()
}
