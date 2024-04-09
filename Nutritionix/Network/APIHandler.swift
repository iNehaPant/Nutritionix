//
//  APIHandler.swift
//  UpTick
//
//  Created by Neha Pant on 31/03/2024.
//

import Foundation

protocol APIHandlerDelegate {
    func getData(_ search: String,
                 isDetailRequired: Bool,
                 url: String,
                 session: URLSession) async throws -> (Data, URLResponse)
}

struct APIHandler: APIHandlerDelegate {

    func getData(_ search: String,
                 isDetailRequired: Bool,
                 url: String,
                 session: URLSession) async throws -> (Data, URLResponse) {
        let baseSearchQuery = "search/instant/?query="
        let detailed = "&detailed=true"
        
        // Construct the search query part based on the provided search string
        let searchQueryPart = baseSearchQuery + search
        
        // Construct the detailed part based on the isDetailRequired parameter
        let detailedPart = isDetailRequired ? detailed : ""
        
        guard let url =  URL(string: url + searchQueryPart + detailedPart) else {
            throw NSError(domain: "URL not correct", code: 404)
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = HeadersHelper.getDefaultHeaders()
        return try await session.data(for: request)
    }
}

