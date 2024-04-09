//
//  NetworkManager.swift
//  UpTickTests
//
//  Created by Neha Pant on 01/04/2024.
//

import XCTest

@testable import UpTick

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!
    
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let mockApiHandlerDelegate = MockApiHandlerDelegate()
        let mockParseHandlerDelegate = MockParseHandlerDelegate()
        sut = NetworkManager(url: MockFoodItems.foodItems, urlSession: urlSession, apiHandler: mockApiHandlerDelegate, parserHandler: mockParseHandlerDelegate)
    }
    
    func testGetFoodItems() async {
        do {
            let result: FoodItem = try await sut.getFoodItems("test", isDetailRequired: true)
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

class MockApiHandlerDelegate: APIHandlerDelegate {
    func getData(_ search: String, isDetailRequired: Bool, url: String, session: URLSession) async throws -> (Data, URLResponse) {
        let jsonData = MockFoodItems.foodItems.data(using: .utf8)!
        return (jsonData, HTTPURLResponse())
    }
}

class MockParseHandlerDelegate: ParserHandlerDelegate {

    func parseData<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
