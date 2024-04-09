//
//  UserDefault+Extension.swift
//  UpTick
//
//  Created by Neha Pant on 31/03/2024.
//

import Foundation

extension UserDefaults {
    static func getStoredItemData() -> [Common]? {
        if let data = UserDefaults.standard.data(forKey: "store_data") {
            do {
                let items = try JSONDecoder().decode([Common].self, from: data)
                return items
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func setStoredItemData(items: [Common]?) {
        do {
            if let items = items {
                let data = try JSONEncoder().encode(items)
                UserDefaults.standard.set(data, forKey: "store_data")
            } else {
                UserDefaults.standard.removeObject(forKey: "store_data")
            }
        } catch {
            print("Error encoding data: \(error)")
        }
    }
}
