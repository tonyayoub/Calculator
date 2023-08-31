//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Tony Ayoub on 23-08-2023.
//

import SwiftUI

@main
struct CalculatorApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            CalculatorView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
