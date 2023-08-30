//
//  SettingsView.swift
//  Calculator
//
//  Created by Tony Ayoub on 24-08-2023.
//

import SwiftUI

struct SettingsView: View {
    @Binding var enabledOperations: [Operation]

    var body: some View {
        Form {
            OperationToggle(id: .add, enabledOperations: $enabledOperations)
            OperationToggle(id: .subtract, enabledOperations: $enabledOperations)
            OperationToggle(id: .multiply, enabledOperations: $enabledOperations)
            OperationToggle(id: .divide, enabledOperations: $enabledOperations)
            OperationToggle(id: .sin, enabledOperations: $enabledOperations)
            OperationToggle(id: .cos, enabledOperations: $enabledOperations)
            OperationToggle(id: .bitCoin, enabledOperations: $enabledOperations)
        }
        .navigationTitle("Settings")
    }
}
