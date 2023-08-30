//
//  ConfigurationGrid.swift
//  Calculator
//
//  Created by Tony Ayoub on 29-08-2023.
//

import SwiftUI

struct ConfigurationGrid: View {
    @Binding var enabledOperations: [Operation]
    
    var body: some View {
        
        VStack {
            HStack {
                ForEach(Operation.advanced) {
                    ConfigurationCell(item: $0, enabledOperations: $enabledOperations)
                }
                ForEach(Operation.simple) {
                    ConfigurationCell(item: $0, enabledOperations: $enabledOperations)
                }
            }
        }
    }
}

#Preview {
    ConfigurationGrid(enabledOperations: .constant([]))
}
