//
//  Common.swift
//  UpTick
//
//  Created by Neha Pant on 31/03/2024.
//

import Foundation

struct Common: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    let foodName: String
    let servingUnit: String
    let servingQty: Double
    let totalFat: Double
    let totalCalories: Double
    let photo: CommomItemPhoto
    let fullNutrients: [FullNutrients]?
    
    static func == (lhs: Common, rhs: Common) -> Bool {
        return 
                       lhs.foodName == rhs.foodName &&
                       lhs.servingUnit == rhs.servingUnit &&
                       lhs.servingQty == rhs.servingQty &&
                       lhs.totalFat == rhs.totalFat &&
                       lhs.totalCalories == rhs.totalCalories &&
                       lhs.photo == rhs.photo &&
                       lhs.fullNutrients == rhs.fullNutrients
    }
    
    init(foodName: String, servingUnit: String, servingQty: Double, totalFat: Double, totalCalories: Double, photo: CommomItemPhoto, fullNutrients: [FullNutrients]?) {
        self.foodName = foodName
        self.servingUnit = servingUnit
        self.servingQty = servingQty
        self.totalFat = totalFat
        self.totalCalories = totalCalories
        self.photo = photo
        self.fullNutrients = fullNutrients
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        foodName = try container.decode(String.self, forKey: .foodName)
        servingUnit = try container.decode(String.self, forKey: .servingUnit)
        servingQty = try container.decode(Double.self, forKey: .servingQty)
        fullNutrients = try? container.decode([FullNutrients].self, forKey: .fullNutrients)
        totalFat = (fullNutrients?.first(where: { $0.attrId == 204 })?.value ?? 0.0).rounded(toPlaces: 2)
        totalCalories = (fullNutrients?.first(where: { $0.attrId == 208 })?.value ?? 0.0).rounded(toPlaces: 2)
        photo = try container.decode(CommomItemPhoto.self, forKey: .photo)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(foodName, forKey: .foodName)
        try container.encode(servingUnit, forKey: .servingUnit)
        try container.encode(servingQty, forKey: .servingQty)
        try container.encode(fullNutrients, forKey: .fullNutrients)
        try container.encode(totalFat, forKey: .totalFat)
        try container.encode(totalCalories, forKey: .totalCalories)
        try container.encode(photo, forKey: .photo)
    }
    
    enum CodingKeys: String, CodingKey {
        case foodName = "food_name"
        case fullNutrients = "full_nutrients"
        case photo = "photo"
        case totalFat
        case totalCalories
        case servingQty = "serving_qty"
        case servingUnit = "serving_unit"
    }
}

struct CommomItemPhoto: Codable, Equatable {
    let thumb: String
    
    static func == (lhs: CommomItemPhoto, rhs: CommomItemPhoto) -> Bool {
        return lhs.thumb == rhs.thumb
    }
}

extension Common {
    static func mock() -> Common {
        return Common(
            foodName: "Hamburger",
            servingUnit: "sandwich",
            servingQty: 1.0,
            totalFat: 26.555,
            totalCalories: 540.14,
            photo: CommomItemPhoto(thumb: ""),
            fullNutrients: [
                FullNutrients(value: 34.2842, attrId: 203),
                FullNutrients(value: 26.555, attrId: 204),
                FullNutrients(value: 40.2732, attrId: 205),
            ]
        )
    }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
