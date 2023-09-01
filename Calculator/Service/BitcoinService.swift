//
//  BitcoinService.swift
//  Calculator
//
//  Created by Tony Ayoub on 31-08-2023.
//

import Foundation

typealias CurrencyResponse = [String: Currency]

enum ServiceError: Error {
    case badURL
    case requestFailed
    case overFlow
}

class BitcoinService: CurrencyService {
    func fetchCurrencyValue(for localValue: Double) async throws -> Double {
        guard let url = URL(string: "https://blockchain.info/ticker") else {
            throw ServiceError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ServiceError.requestFailed
        }
        
        let currencyResponse = try JSONDecoder().decode(CurrencyResponse.self, from: data)
        guard let usdValue = currencyResponse["USD"]?.last else {
            throw ServiceError.requestFailed
        }
        let result = round(usdValue * localValue * 100) / 100.0
        if abs(result) > 9999999999 {
            throw ServiceError.overFlow
        }
        else {
            return result
        }
    }
}
