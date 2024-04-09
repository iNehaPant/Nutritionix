//
//  FoodItemListView.swift
//  UpTick
//
//  Created by Neha Pant on 31/03/2024.
//

import SwiftUI

struct FoodItemAddedListView: View {
    @StateObject var foodItemViewModel: FoodItemViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if foodItemViewModel.showInputItemView {
                    FoodItemInputView(foodItemViewModel: foodItemViewModel)
                } else {
                    if let storedItems = foodItemViewModel.getItems() {
                        VStack {
                            ScrollView {
                                LazyVStack {
                                    ForEach(storedItems) { item in
                                        Grid {
                                            GridRow {
                                                FoodItemImageSubView(url: item.photo.thumb)
                                                Text(item.foodName.capitalized)
                                                    .font(.system(size: 14))
                                                Text(String(Int(item.servingQty)))
                                                    .font(.system(size: 12))
                                                Text(item.servingUnit)
                                                .font(.system(size: 12))
                                                Text(String(item.totalCalories) + " " + "cal")
                                                    .font(.system(size: 12))
                                            }
                                        }
                                    }
                                }
                            }
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Total Fat:")
                                        .font(.system(size: 14, weight: .bold))
                                    Text(String(foodItemViewModel.totalFatContent) + " " + "g")
                                        .font(.system(size: 14))
                                    
                                }
                                HStack {
                                    Text("Total Calories:")
                                        .font(.system(size: 14, weight: .bold))
                                    Text(String(foodItemViewModel.totalCalories) + " " + "cal")
                                        .font(.system(size: 14))
                                }
                            }
                        }
                    }
                }
            }
            .onChange(of: foodItemViewModel.searchText) { searchText in
                foodItemViewModel.showInputItemView = searchText.count >= 3 ? true : false
            }
            .onAppear {
                foodItemViewModel.calculateTotalCalories()
                foodItemViewModel.calculateTotalFatContent()
            }
        }
        .searchable(text: $foodItemViewModel.searchText)
    }
}

#Preview {
    FoodItemAddedListView(foodItemViewModel: FoodItemViewModel(networkManager: NetworkManager(url: "https://trackapi.nutritionix.com/v2/", urlSession: URLSession.shared, apiHandler: APIHandler(), parserHandler: ParserHandler())))
}
