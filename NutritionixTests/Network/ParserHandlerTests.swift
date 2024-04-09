//
//  ParserHandlerTests.swift
//  UpTickTests
//
//  Created by Neha Pant on 31/03/2024.
//

import XCTest
@testable import UpTick

final class ParseHandlerTests: XCTestCase {
    var sut: ParserHandler!
    
    override func setUp() {
        super.setUp()
        sut = ParserHandler()
    }
    
    func testParseData() async throws {
        // Given
        let jsonString = MockFoodItems.foodItems
        let jsonData = jsonString.data(using: .utf8)!
        
        // When
        do {
            let result: FoodItem = try await sut.parseData(data: jsonData)
            
            // Then
            XCTAssertEqual(result.common?.first?.foodName, "hamburger")
        } catch {
            XCTFail("Error: \(error)")
        }
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
}
