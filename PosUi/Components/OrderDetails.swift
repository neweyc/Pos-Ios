//
//  OrderComponent.swift
//  PosUi
//
//  Created by Chris Newey on 9/7/25.
//

import SwiftUI

struct OrderDetails: View {
      @ObservedObject var order: Order

      var body: some View {
          Text("Order")
          LazyVStack(spacing:50) {
              ForEach(order.menuItemSelections, id: \.Item.id) { item in
                  OrderItem(orderItem: item)
              }
          }
          .frame(minWidth: 500)
      }
  }

#Preview {
    let viewModel = OrderViewModel()
    let sampleOrder = Order(orderNumber: 1, customerName: "John Doe", table: "Table 5")
    let item = MenuItem(Name: "Hot Dog", Price: 2.5)
    let orderItem = MenuItemSelection(Item: item, Quantity: 2, SpecialInstructions: "Extra Mustard")
    sampleOrder.menuItemSelections.append(orderItem)
    let item2 = MenuItem(Name: "Cheese Fries", Price: 4.5)
    let orderItem2 = MenuItemSelection(Item: item2, Quantity: 3, SpecialInstructions: "Extra Cheesy")
    sampleOrder.menuItemSelections.append(orderItem2)
    viewModel.selectedOrder = sampleOrder
    
    return OrderDetails(order: viewModel.selectedOrder!)
        
}
