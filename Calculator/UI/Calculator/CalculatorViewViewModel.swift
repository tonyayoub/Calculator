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
    @Published var display = "0"
    @Published var enabledOperations: [Operation] = [
        .sin,
        .cos,
        .bitCoin,
        .divide,
        .multiply,
        .subtract,
        .add
    ]
    @Published var showProgress = false
    @Published var errorMessage = ""
    
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
                self.errorMessage = ""
                $0 == .bitCoin ? self.fetchBitcoinValue() : self.performLocalOperation(button: $0)
            }
            .store(in: &bag)
        
        $enabledOperations.map {
            $0.isEmpty ? "Please enable at least one operation" : ""
        }
        .assign(to: \.errorMessage, on: self)
        .store(in: &bag)
    }
    
    private func fetchBitcoinValue() {
        guard let numericValue = Double(display) else {
            return
        }
        
        if numericValue.isInfinite || numericValue.isNaN {
            self.display = "0"
            return
        }
        
        Task {
            showProgress = true
            do {
                let value = try await service.fetchCurrencyValue(for: numericValue)
                self.display = String(value)
                self.currentCalculation.displayedValue = "0"
            } catch ServiceError.overFlow {
                self.currentCalculation.displayingResult = true
                self.errorMessage = "Error: value overflow"
            }
            catch  {
                self.currentCalculation.displayingResult = true
                self.errorMessage = "Error: please check your network connection"
            } 
            

            showProgress = false
        }
    }
    
    private func performLocalOperation(button: CalculatorButton) {
        self.currentCalculation = CalculationHandler.updateCalculation(
            button: button,
            currentCalculation: self.currentCalculation
        )
        self.display = self.currentCalculation.displayedValue
    }
}
