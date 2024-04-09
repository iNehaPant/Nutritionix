//
//  NutritionixApp.swift
//  Nutritionix
//
//  Created by Neha Pant on 08/04/2024.
//

import SwiftUI

@main
struct NutritionixApp: App {
    var body: some Scene {
        WindowGroup {
            FoodItemAddedListView(foodItemViewModel: FoodItemViewModel(networkManager: NetworkManager(url: "https://trackapi.nutritionix.com/v2/", urlSession: URLSession.shared, apiHandler: APIHandler(), parserHandler: ParserHandler())))
        }
    }
}
