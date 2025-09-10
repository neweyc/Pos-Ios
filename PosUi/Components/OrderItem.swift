//
//  OrderItem.swift
//  PosUi
//
//  Created by Chris Newey on 9/9/25.
//

import SwiftUI

struct OrderItem: View {
    var orderItem: MenuItemSelection
   
    var body: some View {
        HStack(spacing: 100){
            VStack(spacing: 10){
                Text(orderItem.Item.Name)
                    .font(.title)
                Text("\(orderItem.Quantity) x $\(orderItem.Item.Price, specifier: "%.2f")")
                    .font(.headline)
                Text(orderItem.SpecialInstructions ?? "")
                    .font(.subheadline)
            }
            .frame(minWidth: 300)
           
            Text("$\(orderItem.subTotal(), specifier: "%.2f")")
                .font(.title)
        }
        .frame(maxWidth: .infinity)
        
        
    }
}

#Preview {
    let sampleOrder = Order(orderNumber: 1, customerName: "John Doe", table: "Table 5")
    let item = MenuItem(Name: "Hot Dog", Price: 2.5)
    let orderItem = MenuItemSelection(Item: item, Quantity: 2, SpecialInstructions: "Extra Mustard")
    return OrderItem(orderItem: orderItem)
}
