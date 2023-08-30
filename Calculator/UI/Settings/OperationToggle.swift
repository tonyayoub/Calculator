//
//  OperationToggle.swift
//  Calculator
//
//  Created by Tony Ayoub on 29-08-2023.
//

import SwiftUI

struct OperationToggle: View {
    var id: Operation
    @Binding var enabledOperations: [Operation]
    private var title: String {
        id.rawValue.prefix(1).capitalized + id.rawValue.dropFirst()
    }
    var isOn: Binding<Bool> {
        Binding<Bool>(
            get: { enabledOperations.contains(id) },
            set: { newValue in
                if newValue {
                    enabledOperations.append(id)
                } else {
                    enabledOperations.removeAll(where: { $0 == id })
                }
            }
        )
    }
    var body: some View {
        Toggle(isOn: isOn) {
            Text(title)
        }
    }
}

#Preview {
    OperationToggle(id: .add, enabledOperations: .constant([]))
}
