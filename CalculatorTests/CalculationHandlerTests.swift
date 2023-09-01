//
//  CalculationHandlerTests.swift
//  CalculatorTests
//
//  Created by Tony Ayoub on 01-09-2023.
//

import XCTest
@testable import Calculator

final class CalculationHandlerTests: XCTestCase {
    var initialCalculation = Calculation()
    override func setUpWithError() throws {
        initialCalculation.displayedValue = "123"
        initialCalculation.pendingOperation = { $0 + $1}
        initialCalculation.storedValue = 44
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testACClearsCurrentCalculation() {
        let result = CalculationHandler.updateCalculation(
            button: .ac,
            currentCalculation: initialCalculation
        )
        XCTAssertEqual(result.displayedValue, "0")
        XCTAssertNil(result.storedValue)
        XCTAssertNil(result.pendingOperation)
    }
    
    func testOperationAccumulation() {
        let result = CalculationHandler.updateCalculation(
            button: .multiply,
            currentCalculation: initialCalculation
        )
        XCTAssertEqual(result.displayedValue, "0")
        XCTAssertEqual(result.storedValue, 167.0) // storedValue + displayedValue
        XCTAssertNotNil(result.pendingOperation)
        
        let secondResult = CalculationHandler.updateCalculation(
            button: .two,
            currentCalculation: result
        )
        
        XCTAssertEqual(secondResult.displayedValue, "2")
        XCTAssertEqual(secondResult.storedValue, 167.0) // storedValue hasn't yet changed
        XCTAssertNotNil(secondResult.pendingOperation)
        
        let thirdResult = CalculationHandler.updateCalculation(
            button: .equals,
            currentCalculation: secondResult
        )
        
        XCTAssertEqual(thirdResult.displayedValue, "334") // storedValue * 2
        XCTAssertNil(thirdResult.storedValue) // storedValue hasn't yet changed
        XCTAssertNil(thirdResult.pendingOperation)
    }
    
}
