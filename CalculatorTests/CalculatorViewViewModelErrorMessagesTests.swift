//
//  CalculatorViewViewModelErrorMessagesTests.swift
//  CalculatorTests
//
//  Created by Tony Ayoub on 01-09-2023.
//

import XCTest
import Combine
@testable import Calculator

@MainActor
final class CalculatorViewViewModelErrorMessagesTests: XCTestCase {
    var bag = Set<AnyCancellable>()
   
    func testErrorMessageInCaseOfServiceOverflow() async {
        let expectation = XCTestExpectation(description: "Overflow error message is displayed")

        let viewModel = CalculatorViewViewModel(
            service: MockedBitcoinService(responseType: .overFlow),
            screenWidth: 500
        )
        viewModel.buttonValue.send(.bitCoin)
        viewModel.$errorMessage.sink {
            if $0 == Constants.ErrorMessages.overFlow {
                expectation.fulfill()
            }
        }
        .store(in: &bag)
        await fulfillment(of: [expectation], timeout: 3)
    }
    
    func testErrorMessageInCaseOfDisablingAllOperations() async {
        let viewModel = CalculatorViewViewModel(
            service: MockedBitcoinService(responseType: .normal),
            screenWidth: 500
        )
        viewModel.enabledOperations = []
        XCTAssertEqual(viewModel.errorMessage, Constants.ErrorMessages.noOperationsEnabled)
    }
    
    func testErrorMessageInCaseOfConnectivityIssue() async {
        let expectation = XCTestExpectation(description: "Network error message is displayed")

        let viewModel = CalculatorViewViewModel(
            service: MockedBitcoinService(responseType: .unknown),
            screenWidth: 500
        )
        viewModel.buttonValue.send(.bitCoin)
        viewModel.$errorMessage.sink {
            if $0 == Constants.ErrorMessages.networkError {
                expectation.fulfill()
            }
        }
        .store(in: &bag)
        await fulfillment(of: [expectation], timeout: 3)
    }
}
