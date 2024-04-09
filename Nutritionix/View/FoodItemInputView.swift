//
//  FoodItemView.swift
//  UpTick
//
//  Created by Neha Pant on 31/03/2024.
//

import SwiftUI

struct FoodItemInputView: View {
    //Food Item ViewModel
    @ObservedObject var foodItemViewModel: FoodItemViewModel
    
    var body: some View {
        VStack {
            //List of Food Items
            List(foodItemViewModel.commonItems.enumerated().map { $0 }, id: \.element.id) { index, item in
                
                HStack {
                    //Showing Item image
                    FoodItemImageSubView(url: item.photo.thumb)
                    VStack(alignment: .leading) {
                        //Food Name
                        Text(item.foodName.capitalized)
                            .font(.system(size: 13, weight: .bold))
                        
                        //Fat Content values
                        FoodItemSubView(title: "Total Fat:", totalContent: item.totalFat)
                        //Calories
                        FoodItemSubView(title: "Total Calories:", totalContent: item.totalCalories)
                    }
                }
                .onTapGesture {
                    foodItemViewModel.searchText = ""
                    //add item
                    foodItemViewModel.addItemWithIndex(index)
                    foodItemViewModel.calculateTotalCalories()
                    foodItemViewModel.calculateTotalFatContent()
                    foodItemViewModel.showInputItemView = false
                }
            }
        }
        .alert(foodItemViewModel.errorMessage,
               isPresented: $foodItemViewModel.isError,
               actions: {
            Button("Ok", role: .cancel){}
        })
    }
}


#Preview {
    FoodItemAddedListView(foodItemViewModel: FoodItemViewModel(networkManager: NetworkManager(url: "https://trackapi.nutritionix.com/v2/", urlSession: URLSession.shared, apiHandler: APIHandler(), parserHandler: ParserHandler())))
}
