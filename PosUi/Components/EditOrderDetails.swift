//
//  EditOrderDetails.swift
//  PosUi
//
//  Created by Chris Newey on 9/8/25.
//

import SwiftUI

struct EditOrderDetails: View {
    @State private var customerName: String = ""
    @State private var table: String = ""
    @Binding var order: Order?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text("Edit Order Details")
            .font(.title)
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Customer Name")
                    .font(.headline)
                TextField("Enter customer name", text: $customerName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 44)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Table")
                    .font(.headline)
                TextField("Enter table number", text: $table)
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
                    if(order == nil){
                        order = Order(orderNumber: 0)
                    }
                    order!.customerName = customerName
                    order!.table = table
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
        .onAppear {
            customerName = order?.customerName ?? ""
            table = order?.table ?? ""
        }
    }
    
}

#Preview {
    EditOrderDetails(order: .constant(Order(orderNumber: 0)))
}
