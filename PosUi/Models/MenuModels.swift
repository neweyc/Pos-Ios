//
//  Category.swift
//  PosUi
//
//  Created by Chris Newey on 9/5/25.
//
import SwiftUI

struct Category:Hashable{
    var Name:String
    var Color:Color
    var Items:[MenuItem]
}


struct MenuItem:Hashable{
    var Name:String
    var Price:Double
}



struct MockData {
    static var Categories: [Category] = [
        .init(Name: "Appetizers", Color: .orange, Items: [
            .init(Name: "Buffalo Wings", Price: 12.99),
            .init(Name: "Mozzarella Sticks", Price: 8.99),
            .init(Name: "Loaded Nachos", Price: 11.99),
            .init(Name: "Onion Rings", Price: 7.99),
            .init(Name: "Spinach Artichoke Dip", Price: 9.99),
            .init(Name: "Calamari Rings", Price: 13.99),
            .init(Name: "Jalapeño Poppers", Price: 8.99),
            .init(Name: "Potato Skins", Price: 10.99)
        ]),
        .init(Name: "Entrees", Color: .red, Items: [
            .init(Name: "Classic Cheeseburger", Price: 14.99),
            .init(Name: "Grilled Chicken Sandwich", Price: 13.99),
            .init(Name: "Fish & Chips", Price: 16.99),
            .init(Name: "BBQ Ribs", Price: 22.99),
            .init(Name: "Caesar Salad", Price: 11.99),
            .init(Name: "Steak Fajitas", Price: 19.99),
            .init(Name: "Margherita Pizza", Price: 15.99),
            .init(Name: "Chicken Tenders", Price: 12.99)
        ]),
        .init(Name: "Beverages", Color: .blue, Items: [
            .init(Name: "Coca-Cola", Price: 2.99),
            .init(Name: "Fresh Lemonade", Price: 3.49),
            .init(Name: "Iced Tea", Price: 2.99),
            .init(Name: "Coffee", Price: 2.49),
            .init(Name: "Draft Beer", Price: 5.99),
            .init(Name: "House Wine", Price: 7.99),
            .init(Name: "Craft Cocktail", Price: 12.99),
            .init(Name: "Sparkling Water", Price: 2.99)
        ]),
        .init(Name: "Desserts", Color: .purple, Items: [
            .init(Name: "Chocolate Cake", Price: 6.99),
            .init(Name: "Cheesecake", Price: 7.99),
            .init(Name: "Apple Pie", Price: 5.99),
            .init(Name: "Ice Cream Sundae", Price: 4.99),
            .init(Name: "Tiramisu", Price: 8.99),
            .init(Name: "Brownie à la Mode", Price: 6.99),
            .init(Name: "Key Lime Pie", Price: 6.99),
            .init(Name: "Crème Brûlée", Price: 7.99)
        ])
    ]
}
