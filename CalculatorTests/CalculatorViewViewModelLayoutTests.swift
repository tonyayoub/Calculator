//
//  CalculatorViewViewModelLayoutTests.swift
//  CalculatorTests
//
//  Created by Tony Ayoub on 01-09-2023.
//

import XCTest
@testable import Calculator


final class CalculatorViewViewModelLayoutTests: XCTestCase {
    @MainActor
    func testRightColumnTallWhenEnablingTwoSimpleOperations() throws {
        let viewModel = CalculatorViewViewModel(
            service: MockedBitcoinService(responseType: .normal),
            screenWidth: 800
        )
        
        XCTAssertFalse(viewModel.tallRightColumn) // all operations are initially enabled
        
        viewModel.enabledOperations = [.sin, .cos, .bitCoin]
        XCTAssertFalse(viewModel.tallRightColumn)
        
        viewModel.enabledOperations = [.sin, .cos, .bitCoin, .add, .subtract]
        XCTAssertTrue(viewModel.tallRightColumn)
    }
}
