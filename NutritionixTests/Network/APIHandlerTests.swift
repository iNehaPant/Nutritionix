//
//  APIHandlerTests.swift
//  UpTickTests
//
//  Created by Neha Pant on 31/03/2024.
//

import XCTest
@testable import UpTick

final class APIHandlerTests: XCTestCase {
    var sut: APIHandler!
    
    override func setUp() {
        super.setUp()
        sut = APIHandler()
    }
    
    func testGetData() async {
        //given
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        setUserMockProtocol()
        do {
            //when
            let (_, response) = try await sut.getData("test", isDetailRequired: true, url: "", session: urlSession)
            // Then
            XCTAssertTrue(response is HTTPURLResponse)
            XCTAssertEqual((response as? HTTPURLResponse)?.statusCode, 200)
        } catch {
            XCTFail("Error: \(error)")
        }
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func setUserMockProtocol() {
        MockURLProtocol.requestHandler = { request in
            let usersData = MockFoodItems.foodItems.data(using: .utf8)!
            let response = HTTPURLResponse.init(url: request.url!, statusCode: 200, httpVersion: "2.0", headerFields: nil)!
            return (response, usersData)
        }
    }
    
}
