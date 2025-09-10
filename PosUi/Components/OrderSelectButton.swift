//
//  OrderSelectButton.swift
//  PosUi
//
//  Created by Chris Newey on 9/9/25.
//

import SwiftUI

struct OrderSelectButton: View {
    var order: Order
    var body: some View {
        HStack {
            Text("Order Number: \(order.orderNumber)")
            Text(order.table ?? "No Table")
            Text(order.customerName ?? "No Name")
        }
        .frame(maxWidth: .infinity, maxHeight:250)
            .background(.orange)
            .cornerRadius(10)
        
    }
}

#Preview {
    OrderSelectButton(order: Order(orderNumber: 1, customerName: "John Doe", table: "Table 1", menuItemSelections: []))
}
