//
//  FoodItemsViewModel.swift
//  UpTick
//
//  Created by Neha Pant on 31/03/2024.
//

import Foundation
import Combine

class FoodItemViewModel: ObservableObject {
    
    let networkManager: NetworkService
    //Error
    var isError: Bool = false
    var errorMessage: String = ""
    @Published var commonItems: [Common] = [Common]()
    private var searchCancellable: AnyCancellable?
    private var charCount = 3
    private var debounceTime = 300
    
    @Published var showInputItemView: Bool = false {
        didSet {
            if searchText.count > charCount {
                self.commonItems = []
            }
        }
    }
    
    @Published var searchText = "" {
        didSet {
            if searchText.count > charCount {
                searchCancellable?.cancel()
                searchCancellable = $searchText
                    .debounce(for: .milliseconds(debounceTime), scheduler: DispatchQueue.main)
                    .sink {[weak self] _ in
                        guard let weakSelf = self else {
                            return
                        }
                        if weakSelf.searchText.count > weakSelf.charCount {
                            weakSelf.getFoodItem(isDetailRequired: true)
                        }
                    }
            }
        }
    }
    
    @Published var storedItemArray: [Common] = [Common]()
    @Published var totalCalories: Double = 0.0
    @Published var totalFatContent: Double = 0.0

    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    
    func getFoodItem(isDetailRequired: Bool) {
        Task {
            do {
                //Call Get Food Items
                let item: FoodItem = try await networkManager.getFoodItems(searchText, isDetailRequired: isDetailRequired)
                DispatchQueue.main.async {[weak self] in
                    guard let weakSelf = self else {
                        return
                    }
                    weakSelf.commonItems = item.common ?? []
                }
            } catch {
                isError = true
                errorMessage = error.localizedDescription
            }
        }
    }
    
    //Add item which user has selected
    func addItemWithIndex(_ index: Int) {
        if index <= commonItems.count {
            storedItemArray = UserDefaults.getStoredItemData() ?? []
            storedItemArray.append(commonItems[index])
            UserDefaults.setStoredItemData(items: storedItemArray)
        }
    }
    
    //Total calories
    func calculateTotalCalories() {
        let array:[Common] = UserDefaults.getStoredItemData() ?? []
        totalCalories = array.reduce(0.0) { $0 + ($1.totalCalories ) }
        totalCalories = (totalCalories.rounded(toPlaces: 2))
    }
    
    //total fat content
    func calculateTotalFatContent() {
        let array:[Common] = UserDefaults.getStoredItemData() ?? []
        totalFatContent = array.reduce(0.0) { $0 + ($1.totalFat ) }
        totalFatContent = (totalFatContent.rounded(toPlaces: 2))
    }

    func getItems() -> [Common]? {
        return UserDefaults.getStoredItemData()
    }
}

