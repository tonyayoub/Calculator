//
//  MiddleGrid.swift
//  Calculator
//
//  Created by Tony Ayoub on 27-08-2023.
//

import SwiftUI
import Combine

struct MiddleGrid: View {
    @EnvironmentObject var viewModel: CalculatorViewViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.middleNumberRows, id: \.self) { row in
                HStack(spacing: viewModel.spacing) {
                    ForEach(row, id: \.self) { numberButton in
                        SquareButton(
                            width: viewModel.buttonSize,
                            height: viewModel.buttonSize,
                            value: viewModel.buttonValue,
                            calculatorButton: numberButton
                        )
                    }
                }
            }
        }

    }
}

#Preview {
    MiddleGrid()
}
