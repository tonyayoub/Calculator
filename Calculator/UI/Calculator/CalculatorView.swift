//
//  CalculatorView.swift
//  Calculator
//
//  Created by Tony Ayoub on 23-08-2023.
//
import SwiftUI

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewViewModel(service: BitcoinService())
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer(minLength: 40)
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    Text(viewModel.display)
                        .font(.largeTitle)
                        .multilineTextAlignment(.trailing)
                        .padding()
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                        .padding(.trailing, viewModel.resultPadding)
                }
                
                ButtonGrid()
                    .environmentObject(viewModel)
                Spacer()
            }
            .cornerRadius(5)
            
            if viewModel.showProgress {
                ProgressView()
            }
            Text(viewModel.errorMessage)
                .font(.footnote)
                .foregroundColor(Color.red.opacity(0.6))
            HStack {
                Spacer()
                ConfigurationGrid(enabledOperations: $viewModel.enabledOperations)
                Spacer()
            }
        }
        
    }
}


struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
