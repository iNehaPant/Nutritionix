//
//  ParserHandler.swift
//  UpTick
//
//  Created by Neha Pant on 31/03/2024.
//

import Foundation

protocol ParserHandlerDelegate {
    func parseData<Item: Decodable>(data: Data) throws-> Item
}

struct ParserHandler: ParserHandlerDelegate {
    func parseData<Item: Decodable>(data: Data) throws-> Item {
        return try JSONDecoder().decode(Item.self, from: data)
    }
}
