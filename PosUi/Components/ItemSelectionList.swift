//
//  ItemSelection.swift
//  PosUi
//
//  Created by Chris Newey on 9/7/25.
//

import SwiftUI

struct ItemSelectionList: View {
    var category: Category
    @State private var selectedItem: MenuItem? = nil
    @EnvironmentObject var orderVM: OrderViewModel
    
    var body: some View {
        List {
            ForEach(category.Items, id: \.Name) { item in
                Button{
                    selectedItem = item
                }
                label: {
                    ItemButton(category: category, item: item)
                }
            }
        }
        
        .navigationTitle(Text("Order: \(orderVM.selectedOrder?.orderNumber ?? 0) - \(category.Name)"))
        .sheet(item: $selectedItem) { item in
              if orderVM.selectedOrder != nil {
                  ItemSelection(item: item, orderVM: orderVM)
              }
          }
    }
        
}

#Preview {
    let viewModel = OrderViewModel()
    let sampleOrder = Order(orderNumber: 1, customerName: "John Doe", table: "Table 5")
    viewModel.activeOrders.append(sampleOrder)
    
    return ItemSelectionList(category: Category(Name: "Appetizers", Color: .orange, Items: [
        .init(Name: "Buffalo Wings", Price: 12.99),
        .init(Name: "Mozzarella Sticks", Price: 8.99),
        .init(Name: "Loaded Nachos", Price: 11.99),
        .init(Name: "Onion Rings", Price: 7.99),
        .init(Name: "Spinach Artichoke Dip", Price: 9.99),
        .init(Name: "Calamari Rings", Price: 13.99),
        .init(Name: "Jalapeño Poppers", Price: 8.99),
        .init(Name: "Potato Skins", Price: 10.99)
    ]))
    .environmentObject(viewModel)
}
