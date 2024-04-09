//
//  NetworkManager.swift
//  UpTick
//
//  Created by Neha Pant on 31/03/2024.
//

import Foundation

protocol NetworkService {
    func getFoodItems<Item: Decodable>(_ search: String, isDetailRequired: Bool) async throws -> Item
}

struct NetworkManager: NetworkService {
    private var url: String
    private var urlSession: URLSession
    let apiHandler: APIHandlerDelegate
    let parserHandler: ParserHandlerDelegate
    
    init(url: String,
         urlSession: URLSession,
         apiHandler: APIHandlerDelegate,
         parserHandler: ParserHandlerDelegate) {
        self.url = url
        self.urlSession = urlSession
        self.apiHandler = apiHandler
        self.parserHandler = parserHandler
    }
    
    //Get food Items
    func getFoodItems<Item: Decodable>(_ search: String,
                                       isDetailRequired: Bool) async throws -> Item {
        let (data, _) = try await apiHandler.getData(search, isDetailRequired: isDetailRequired, url: url, session: urlSession)
        return try parserHandler.parseData(data: data)
    }
}



