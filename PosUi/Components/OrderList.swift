//
//  OrderList.swift
//  PosUi
//
//  Created by Chris Newey on 9/9/25.
//

import SwiftUI

struct OrderList: View {
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var categoriesVM: CategoriesViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List {
            ForEach(orderVM.activeOrders) { order in
                Button{
                    categoriesVM.clearSelectedCategory()
                    orderVM.selectOrder(order)
                    presentationMode.wrappedValue.dismiss()
                }
                label: {
                    OrderSelectButton(order:order)
                }
            }
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
            
        }
        .padding()
    }
}

#Preview {
    let viewModel = OrderViewModel()
    let sampleOrder = Order(orderNumber: 1, customerName: "John Doe", table: "Table 5")
    viewModel.activeOrders.append(sampleOrder)
    let sampleOrder2 = Order(orderNumber: 2, customerName: "Jane Doe", table: "Table 6")
    viewModel.activeOrders.append(sampleOrder2)

    return OrderList()
        .environmentObject(viewModel)
  }
