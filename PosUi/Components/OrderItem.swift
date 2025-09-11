//
//  OrderItem.swift
//  PosUi
//
//  Created by Chris Newey on 9/9/25.
//

import SwiftUI

struct OrderItem: View {
    @ObservedObject var menuItemSelection: MenuItemSelection
    var order: Order
    @State private var showEdit: Bool = false
    @EnvironmentObject var orderVM: OrderViewModel
  
   
    var body: some View {
        HStack(spacing: 100){
            VStack(spacing: 10){
                Text(menuItemSelection.item.Name)
                    .font(.title)
                Text("\(menuItemSelection.quantity) x $\(menuItemSelection.item.Price, specifier: "%.2f")")
                    .font(.headline)
                Text(menuItemSelection.specialInstructions)
                    .font(.subheadline)
                HStack(spacing:40){
                    Button {
                        showEdit = true
                    } label:{
                        Text("Edit")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                  
                    Button {
                        order.removeMenuItemSelection(menuItem: menuItemSelection)
                    } label:{
                        Text("Remove")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                
            }
            .frame(minWidth: 300)
            .sheet(isPresented: $showEdit) {
                EditMenuItemSelection(item: menuItemSelection.item, selectedItem: menuItemSelection,
                onUpdate: { updatedSelection in
                    menuItemSelection.quantity = updatedSelection.quantity
                    menuItemSelection.specialInstructions = updatedSelection.specialInstructions
                    menuItemSelection.setModifiers(updatedSelection.modifiers)
                    showEdit = false
                }, onCancel: {
                    showEdit = false
                })
              }
           
            Text("$\(menuItemSelection.subTotal(), specifier: "%.2f")")
                .font(.title)
            
        }
        .frame(maxWidth: .infinity)
    }
    
}


 #Preview {
 let sampleOrder = Order(orderNumber: 1, customerName: "John Doe", table: "Table 5")
 let item = MenuItem(Name: "Hot Dog", Price: 2.5)
 let orderItem = MenuItemSelection(Item: item, Quantity: 2, SpecialInstructions: "Extra Mustard")
 return OrderItem(menuItemSelection: orderItem, order: sampleOrder)
 }
 
