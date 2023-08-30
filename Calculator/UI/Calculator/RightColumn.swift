//
//  RightColumn.swift
//  Calculator
//
//  Created by Tony Ayoub on 27-08-2023.
//

import SwiftUI
import Combine

struct RightColumn: View {
    @EnvironmentObject var viewModel: CalculatorViewViewModel
    var body: some View {
        VStack {
            ForEach(viewModel.rightColumn, id: \.self) { button in
                SquareButton(
                    width: viewModel.buttonSize,
                    height: viewModel.rightColumnButtonHeight,
                    value: viewModel.buttonValue,
                    calculatorButton: button
                )
            }
        }
    }
}

#Preview {
    RightColumn()
}
