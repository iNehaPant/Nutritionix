//
//  FoodItemViewModelTests.swift
//  UpTickTests
//
//  Created by Neha Pant on 01/04/2024.
//

import XCTest
@testable import UpTick

final class FoodItemViewModelTests: XCTestCase {
    var sut: FoodItemViewModel!
    
    override func setUp() {
        super.setUp()
        sut = FoodItemViewModel(networkManager: MockNetworkManager(mockFoodItem: FoodItem(common: [Common.mock()])))
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetFoodItems_success() async {
        //given
        let expectation = self.expectation(description: "Get Food Items")
        let mockfoodItems = FoodItem(common: [Common.mock()])
        
        //when
        sut.getFoodItem(isDetailRequired: true)
        
        //then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.sut.commonItems, mockfoodItems.common)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class MockNetworkManager: NetworkService {
    var mockFoodItems: FoodItem
    
    init(mockFoodItem:FoodItem = FoodItem(common: [Common.mock()])) {
        self.mockFoodItems = mockFoodItem
    }
    
    func getFoodItems<Item: Decodable>(_ search: String, isDetailRequired: Bool) async throws -> Item {
        return self.mockFoodItems as! Item
    }
}
