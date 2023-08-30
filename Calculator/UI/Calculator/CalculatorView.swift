//
//  CalculatorView.swift
//  Calculator
//
//  Created by Tony Ayoub on 23-08-2023.
//
import SwiftUI

struct CalculatorView: View {

    @StateObject private var viewModel = CalculatorViewViewModel()
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .sin, .bitCoin],
        [.seven, .eight, .nine, .divide],
        [.four, .five, .six, .multiply],
        [.one, .two, .three, .subtract],
        [.zero, .dot, .equals, .add]
    ]
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(alignment: .center, spacing: 20) {
                Spacer(minLength: 40)
                VStack(alignment: .center) {
                    Text(viewModel.display)
                        .font(.largeTitle)
                        .multilineTextAlignment(.trailing)  // Right-aligned text
                        .padding()
                        .foregroundColor(.gray)
                        .background(Color.clear)
                        .cornerRadius(10)
                    
                    
                    ButtonGrid()
                        .environmentObject(viewModel)
                    Spacer()
                }
                .background(.yellow)
                .cornerRadius(5)

                HStack {
                    Spacer()
                    ConfigurationGrid(enabledOperations: $viewModel.enabledOperations)
                    Spacer()
                }
  
            }
            .onAppear {
                let width = geometry.size.width
                let height = geometry.size.height
                let aspectRatio = width / height
                print("Aspect ratio is \(aspectRatio)")
                print("Size: \(geometry.size)")
                viewModel.screenWidth = geometry.size.width
            }
        }
        
    }
}


struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}