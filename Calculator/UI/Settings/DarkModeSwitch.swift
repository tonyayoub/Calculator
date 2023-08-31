//
//  DarkModeSwitch.swift
//  Calculator
//
//  Created by Tony Ayoub on 31-08-2023.
//

import SwiftUI

struct DarkModeSwitch: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        Text("\(Image(systemName: "moon.fill"))")
            .font(.footnote)
            .padding()
            .foregroundColor(isDarkMode ? Color.blue : Color.gray)
            .onTapGesture { toggleOperation() }
    }
    
    func toggleOperation() {
        isDarkMode.toggle()
    }
}

#Preview {
    DarkModeSwitch()
}
