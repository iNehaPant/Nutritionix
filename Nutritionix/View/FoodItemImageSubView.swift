//
//  FoodItemImageSubView.swift
//  UpTick
//
//  Created by Neha Pant on 31/03/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct FoodItemImageSubView: View {
    var url: String
    
    var body: some View {
        WebImage(url: URL(string: url))
            .resizable()
            .scaledToFill()
            .frame(width: 30, height: 30)
            .clipShape(Rectangle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 3)
    }
}

#Preview {
    FoodItemImageSubView(url: "http://google.com")
}
