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
          Text("Order: \(order.orderNumber) \(order.customerName ?? "No Name") - Table: \(order.table ?? "No Table")")
          List{
              ForEach(order.menuItemSelections, id: \.id) { item in
                  OrderItem(menuItemSelection: item, order: order)
              }
              VStack(alignment: .trailing){
                  Text("Subtotal: \(order.subtotal(), specifier: "%.2f")")
                  Text("Tax: \(order.taxTotal(), specifier: "%.2f")")
                  Text("Total: \(order.total(), specifier: "%.2f")")
              }
              .frame(maxWidth: .infinity, alignment: .trailing)
              .padding(.trailing, 20)
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
