//
//  ConfigurationCell.swift
//  Calculator
//
//  Created by Tony Ayoub on 29-08-2023.
//

import SwiftUI

struct ConfigurationCell: View {
    var item: Operation
    @Binding var enabledOperations: [Operation]
    var body: some View {
        Text(item.display)
            .font(.footnote)
            .padding()
            .foregroundColor(enabled ? Color.blue : Color.gray)
            .onTapGesture { toggleOperation() }
    }
    
    var enabled: Bool {
        enabledOperations.contains(item)
    }
    
    func toggleOperation() {
        withAnimation(.smooth) {
            enabled
            ? enabledOperations.removeAll(where: { $0 == item })
            : enabledOperations.append(item)
        }
    }
}

#Preview {
    ConfigurationCell(item: .add, enabledOperations: .constant([]))
}
