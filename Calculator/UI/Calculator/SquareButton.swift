//
//  SquareButton.swift
//  Calculator
//
//  Created by Tony Ayoub on 26-08-2023.
//

import SwiftUI
import Combine

struct SquareButton: View {
    var width: CGFloat
    var height: CGFloat
    var value: PassthroughSubject<CalculatorButton, Never>
    var calculatorButton: CalculatorButton
    
    var body: some View {
        Button(action: {
            value.send(calculatorButton)
        }) {
            Text(calculatorButton.title)
                .frame(width: width, height: height)
                .background(.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

#Preview {
    SquareButton(
        width: 10,
        height: 10,
        value: PassthroughSubject(),
        calculatorButton: .add
    )
}
