//
//  Currency.swift
//  Calculator
//
//  Created by Tony Ayoub on 31-08-2023.
//

import Foundation

struct Currency: Decodable {
    let m15: Double
    let last: Double
    let buy: Double
    let sell: Double
    let symbol: String
    
    enum CodingKeys: String, CodingKey {
        case m15 = "15m"
        case last
        case buy
        case sell
        case symbol
    }
}

