//
//  ItemButton.swift
//  PosUi
//
//  Created by Chris Newey on 9/7/25.
//

import SwiftUI

struct ItemButton: View {
    var category: Category
    var item: MenuItem
    
    var body: some View {
        Text(item.Name)
            .frame(width: 300, height: 115)
            .background(category.Color)
            .cornerRadius(10)
    }
}

#Preview {
    ItemButton(category: Category(Name: "Appetizers", Color: .orange, Items: [
        .init(Name: "Buffalo Wings", Price: 12.99),
        .init(Name: "Mozzarella Sticks", Price: 8.99),
        .init(Name: "Loaded Nachos", Price: 11.99),
        .init(Name: "Onion Rings", Price: 7.99),
        .init(Name: "Spinach Artichoke Dip", Price: 9.99),
        .init(Name: "Calamari Rings", Price: 13.99),
        .init(Name: "Jalapeño Poppers", Price: 8.99),
        .init(Name: "Potato Skins", Price: 10.99)
    ]), item: MenuItem(Name: "Buffalo Wings", Price: 12.99)  )
}
