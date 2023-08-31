//
//  CurrencyService.swift
//  Calculator
//
//  Created by Tony Ayoub on 31-08-2023.
//

import Foundation

protocol CurrencyService {
    func fetchCurrencyValue(for localValue: Double) async throws -> Double
}
