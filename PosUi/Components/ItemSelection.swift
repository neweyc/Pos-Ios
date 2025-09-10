//
//  ItemSelection.swift
//  PosUi
//
//  Created by Chris Newey on 9/7/25.
//

import SwiftUI

struct ItemSelection: View {
    var item: MenuItem
    @State private var quantity: Int = 0
    @State private var specialInstructions: String = ""
    @Environment(\.presentationMode) var presentationMode
    var orderVM: OrderViewModel
    
    var body: some View {
        Text("\(orderVM.selectedOrder?.orderNumber ?? 0)")
              .font(.title)
        VStack(spacing: 20) {
            Text(item.Name)
                .font(.title)
            Text("$\(item.Price, specifier: "%.2f")")
                .font(.title2)
                .foregroundColor(.secondary)
            Spacer()
            HStack {
                Button("-") {
                    if quantity > 0 {
                        quantity -= 1
                    }
                }
                
                .frame(width: 50, height: 50)
                .background(quantity > 0 ? Color.red : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(quantity == 0)
                
                Text("\(quantity)")
                    .font(.title)
                    .frame(minWidth: 50)
                
                Button("+") {
                    quantity += 1
                }
                .frame(width: 50, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Special Instructions")
                    .font(.headline)
                TextField("Enter special instructions", text: $specialInstructions)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 44)
            }
            
            Spacer()
            HStack(spacing: 20) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("OK") {
        
                    print("Quantity: \(quantity)")
                          print("selectedOrder exists: \(orderVM.selectedOrder != nil)")

                          if let selectedOrder = orderVM.selectedOrder {
                              print("Items before: \(selectedOrder.menuItemSelections.count)")
                              let menuItem = MenuItemSelection(Item: item, Quantity: quantity, SpecialInstructions:
                      specialInstructions)
                              selectedOrder.addMenuItemSelection(menuItem)
                              print("Items after: \(selectedOrder.menuItemSelections.count)")
                              presentationMode.wrappedValue.dismiss()
                          } else {
                              print("No selected order!")
                          }
                    
                }
                .disabled(quantity < 1)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
        
    }
}

#Preview {
    let viewModel = OrderViewModel()
    let sampleOrder = Order(orderNumber: 1, customerName: "John Doe", table: "Table 5")
    let item = MenuItem(Name: "Hot Dog", Price: 2.5)
    let orderItem = MenuItemSelection(Item: item, Quantity: 2, SpecialInstructions: "Extra Mustard")
    sampleOrder.menuItemSelections.append(orderItem)
    viewModel.selectedOrder = sampleOrder
    
    return ItemSelection(item: MenuItem(Name: "Chicken Wings", Price: 12.99), orderVM: viewModel)
       
    
    
}
