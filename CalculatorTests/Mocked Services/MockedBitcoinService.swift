//
//  MockedBitcoinService.swift
//  CalculatorTests
//
//  Created by Tony Ayoub on 01-09-2023.
//

import Foundation
@testable import Calculator

enum ResponseType {
    case normal, overFlow, unknown
}

class MockedBitcoinService: CurrencyService {
    let responseType: ResponseType
    
    init(responseType: ResponseType) {
        self.responseType = responseType
    }
    
    func fetchCurrencyValue(for localValue: Double) async throws -> Double {
        switch responseType {
        case .normal:
            return localValue * 2700
        case .overFlow:
            throw ServiceError.overFlow
        case .unknown:
            throw ServiceError.badURL
        }
    }
}
