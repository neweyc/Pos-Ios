//
//  CategoryButton.swift
//  PosUi
//
//  Created by Chris Newey on 9/7/25.
//

import SwiftUI

struct CategoryButton: View {
    var item: Category
    var body: some View {
        Text(item.Name)
            .frame(width: 300, height: 115)
            .background(item.Color)
            .cornerRadius(10)
    }
}

#Preview {
    CategoryButton(item: .init(Name: "Some Category", Color: .blue, Items: []))
}
