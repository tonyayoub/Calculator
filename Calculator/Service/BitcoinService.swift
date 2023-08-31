//
//  BitcoinService.swift
//  Calculator
//
//  Created by Tony Ayoub on 31-08-2023.
//

import Foundation

typealias CurrencyResponse = [String: Currency]

enum NetworkError: Error {
    case badURL
    case requestFailed
    case unknown
}

class BitcoinService: CurrencyService {
    func fetchCurrencyValue(for localValue: Double) async throws -> Double {
        guard let url = URL(string: "https://blockchain.info/ticker") else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        
        do {
            let currencyResponse = try JSONDecoder().decode(CurrencyResponse.self, from: data)
            guard let usdValue = currencyResponse["USD"]?.last else {
                throw NetworkError.requestFailed
            }
            return usdValue * localValue
        } catch {
            throw NetworkError.unknown
        }
    }
}
