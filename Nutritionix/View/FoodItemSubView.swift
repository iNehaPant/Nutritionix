//
//  FoodItemSubView.swift
//  UpTick
//
//  Created by Neha Pant on 31/03/2024.
//

import SwiftUI

struct FoodItemSubView: View {
    var title: String
    var totalContent: Double
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 10, weight: .bold))
            Text(String(String(totalContent)))
                .font(.system(size: 10))
        }
    }
}


#Preview {
    FoodItemSubView(title: "test", totalContent: 200.00)
}
