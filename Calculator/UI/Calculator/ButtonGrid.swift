//
//  ButtonGrid.swift
//  Calculator
//
//  Created by Tony Ayoub on 25-08-2023.
//

import SwiftUI
import Combine

struct ButtonGrid: View {
    // Will be a binding injected from parent
    
    let columns = 4
    let spacing: CGFloat = 10.0
    let screenWidth = UIScreen.main.bounds.width
//    var buttonValue: PassthroughSubject<String, Never>
    @EnvironmentObject var viewModel: CalculatorViewViewModel
    
    
    // Calculate size based on screen width
    var buttonSize: CGFloat {
        (screenWidth - (spacing * CGFloat(columns + 1))) / CGFloat(columns)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            
            UpperRow()

            if viewModel.tallRightColumn {
                HStack(spacing: viewModel.spacing) {
                    VStack(spacing: viewModel.spacing) {
                        MiddleGrid()
                        BottomRow()
                    }
                    RightColumn()
                }
            } else {
                HStack(spacing: viewModel.spacing) {
                    MiddleGrid()
                    RightColumn()
                }
                BottomRow()
            }
        }
        .padding(.horizontal, spacing)
        
    }
}

