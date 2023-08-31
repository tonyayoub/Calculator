//
//  CalculatorViewViewModel.swift
//  Calculator
//
//  Created by Tony Ayoub on 27-08-2023.
//

import SwiftUI
import Combine

@MainActor
class CalculatorViewViewModel: ObservableObject {
    @Published var display: String = "0"
    @Published var enabledOperations: [Operation] = [
        .sin,
        .cos,
        .bitCoin,
        .divide,
        .multiply,
        .subtract,
        .add
    ]
    
    var bag = Set<AnyCancellable>()
    var currentCalculation = Calculation()
    let service: CurrencyService
    let screenWidth = UIScreen.main.bounds.width
    let buttonValue = PassthroughSubject<CalculatorButton, Never>()
    let columns = 4
    let spacing: CGFloat = 10.0
    let middleNumberRows: [[CalculatorButton]] = [
        [.one, .two, .three],
        [.four, .five, .six],
        [.seven, .eight, .nine],
    ]
    
    init(service: CurrencyService) {
        self.service = service
        buttonValue
            .sink {
                if $0 == .bitCoin {
                    Task {
                        let value = try await service.fetchCurrencyValue(for: 4)
                        print(value)
                    }
                } else {
                    self.currentCalculation = CalculationHandler.updateCalculation(
                        button: $0,
                        currentCalculation: self.currentCalculation
                    )
                    self.display = self.currentCalculation.displayedValue
                }
            }
            .store(in: &bag)
    }
}
