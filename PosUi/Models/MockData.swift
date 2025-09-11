//
//  MockData.swift
//  PosUi
//
//  Created by Chris Newey on 9/9/25.
//

import Foundation
import SwiftUI


struct MockData {
    static var Categories: [Category] = [
        .init(Name: "Appetizers", Color: .orange, Items: [
            .init(Name: "Buffalo Wings", Price: 12.99, Modifiers: [
                .init(name: "Extra Hot", priceIncrease: 0.50, defaultSelected: false),
                .init(name: "Extra Celery", priceIncrease: 1.00, defaultSelected: false)
            ]),
            .init(Name: "Mozzarella Sticks", Price: 8.99, Modifiers: [
                .init(name: "Extra Marinara", priceIncrease: 0.75, defaultSelected: false)
            ]),
            .init(Name: "Loaded Nachos", Price: 11.99, Modifiers: [
                .init(name: "Extra Cheese", priceIncrease: 1.50, defaultSelected: false),
                .init(name: "Extra Jalapeños", priceIncrease: 0.50, defaultSelected: false),
                .init(name: "Add Guacamole", priceIncrease: 2.00, defaultSelected: false)
            ]),
            .init(Name: "Onion Rings", Price: 7.99),
            .init(Name: "Spinach Artichoke Dip", Price: 9.99),
            .init(Name: "Calamari Rings", Price: 13.99),
            .init(Name: "Jalapeño Poppers", Price: 8.99),
            .init(Name: "Potato Skins", Price: 10.99, Modifiers: [
                .init(name: "Extra Bacon", priceIncrease: 1.50, defaultSelected: false),
                .init(name: "Extra Sour Cream", priceIncrease: 0.50, defaultSelected: false)
            ])
        ]),
        .init(Name: "Entrees", Color: .red, Items: [
            .init(Name: "Classic Cheeseburger", Price: 14.99, Modifiers: [
                .init(name: "Ketchup", priceIncrease: 0.00, defaultSelected: true),
                .init(name: "Mustard", priceIncrease: 0.00, defaultSelected: true),
                .init(name: "Mayo", priceIncrease: 0.00, defaultSelected: false),
                .init(name: "Lettuce", priceIncrease: 0.00, defaultSelected: true),
                .init(name: "Pickles", priceIncrease: 0.00, defaultSelected: true),
                .init(name: "Add Bacon", priceIncrease: 2.00, defaultSelected: false),
                .init(name: "Add Avocado", priceIncrease: 1.50, defaultSelected: false),
                .init(name: "Extra Cheese", priceIncrease: 1.00, defaultSelected: false),
                .init(name: "Make it a Double", priceIncrease: 4.00, defaultSelected: false)
            ]),
            .init(Name: "Grilled Chicken Sandwich", Price: 13.99, Modifiers: [
                .init(name: "Add Bacon", priceIncrease: 2.00, defaultSelected: false),
                .init(name: "Add Avocado", priceIncrease: 1.50, defaultSelected: false)
            ]),
            .init(Name: "Fish & Chips", Price: 16.99),
            .init(Name: "BBQ Ribs", Price: 22.99),
            .init(Name: "Caesar Salad", Price: 11.99),
            .init(Name: "Steak Fajitas", Price: 19.99),
            .init(Name: "Margherita Pizza", Price: 15.99, Modifiers: [
                .init(name: "Extra Cheese", priceIncrease: 2.00, defaultSelected: false),
                .init(name: "Add Pepperoni", priceIncrease: 1.50, defaultSelected: false),
                .init(name: "Add Mushrooms", priceIncrease: 1.00, defaultSelected: false)
            ]),
            .init(Name: "Chicken Tenders", Price: 12.99)
        ]),
        .init(Name: "Sides", Color: .yellow, Items: [
            .init(Name: "Fries Basket", Price: 4.99, Modifiers: [
                .init(name: "Make them Sweet Potato", priceIncrease: 1.00, defaultSelected: false),
                .init(name: "Add Cheese", priceIncrease: 1.50, defaultSelected: false)
            ]),
            .init(Name: "Chips", Price: 1.99),
            .init(Name: "Corn Cobb", Price: 2.99),
            .init(Name: "Cole Slaw", Price: 2.99),
            .init(Name: "Green Beans", Price: 2.99)
        ]),
        .init(Name: "Beverages", Color: .blue, Items: [
            .init(Name: "Coca-Cola", Price: 2.99),
            .init(Name: "Fresh Lemonade", Price: 3.49),
            .init(Name: "Iced Tea", Price: 2.99),
            .init(Name: "Coffee", Price: 2.49),
            .init(Name: "Draft Beer", Price: 5.99, Modifiers: [
                .init(name: "Make it a Pint", priceIncrease: 1.50, defaultSelected: false)
            ]),
            .init(Name: "House Wine", Price: 7.99),
            .init(Name: "Craft Cocktail", Price: 12.99),
            .init(Name: "Sparkling Water", Price: 2.99)
        ]),
        .init(Name: "Desserts", Color: .purple, Items: [
            .init(Name: "Chocolate Cake", Price: 6.99),
            .init(Name: "Cheesecake", Price: 7.99),
            .init(Name: "Apple Pie", Price: 5.99, Modifiers: [
                .init(name: "Add Ice Cream", priceIncrease: 1.50, defaultSelected: false),
                .init(name: "Warm it Up", priceIncrease: 0.00, defaultSelected: true)
            ]),
            .init(Name: "Ice Cream Sundae", Price: 4.99),
            .init(Name: "Tiramisu", Price: 8.99),
            .init(Name: "Brownie à la Mode", Price: 6.99),
            .init(Name: "Key Lime Pie", Price: 6.99),
            .init(Name: "Crème Brûlée", Price: 7.99)
        ])
    ]
}
