//
//  OrderViewModel.swift
//  PosUi
//
//  Created by Chris Newey on 9/7/25.
//

import Foundation

final class OrderViewModel:ObservableObject {
    @Published var activeOrders:[Order] = []
    @Published var completeOrders:[Order] = []
    @Published var selectedOrder: Order? = nil
    private var nextOrderId:Int = 1
    
    func addOrder(_ order:Order) {
        order.orderNumber = nextOrderId
        nextOrderId += 1
        order.status = .new
        activeOrders.append(order)
    }
    
    func selectOrder(_ order:Order) {
        selectedOrder = order
    }
    
    
    func completeOrder(_ order:Order) {
        if let index = activeOrders.firstIndex(of: order) {
            order.status = .complete
            activeOrders.remove(at: index)
            completeOrders.append(order)
        }
    }
    
    func clearSelectedOrder() {
        selectedOrder = nil
        
    }
    
}
