//
//  Calculation.swift
//  Calculator
//
//  Created by Tony Ayoub on 30-08-2023.
//

import Foundation

struct Calculation {
    var pendingOperation: ((Double, Double) -> Double)? = nil
    var storedValue: Double? = nil
    var displayingResult = false
}
