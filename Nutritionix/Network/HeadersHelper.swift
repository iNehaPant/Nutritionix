//
//  HeadersHelper.swift
//  UpTick
//
//  Created by Neha Pant on 31/03/2024.
//

import Foundation

struct HeadersHelper {
    enum HeaderKeys: String {
        case contentType = "application/json"
        case xAppId = "x-app-id"
        case xAppKey = "x-app-key"
    }
    
    static func getDefaultHeaders() -> [String: String] {
        var headers = [String: String]()
        //headers[HeaderKeys.contentType.rawValue] = "application/json"
        //headers[HeaderKeys.xAppId.rawValue] = ""
        //headers[HeaderKeys.xAppKey.rawValue] = ""
        return headers
    }
}
