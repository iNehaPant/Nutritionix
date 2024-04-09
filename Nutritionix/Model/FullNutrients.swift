//
//  FullNutrients.swift
//  UpTick
//
//  Created by Neha Pant on 31/03/2024.
//

import Foundation

struct FullNutrients: Codable, Equatable {
    let value: Double
    let attrId: Int
        
    enum CodingKeys: String, CodingKey {
        case value
        case attrId = "attr_id"
    }
    
    static func == (lhs: FullNutrients, rhs: FullNutrients) -> Bool {
        return lhs.value == rhs.value &&
        rhs.attrId == rhs.attrId
    }
    
}
