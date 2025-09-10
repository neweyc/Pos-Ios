//
//  OrdersView.swift
//  PosUi
//
//  Created by Chris Newey on 9/5/25.
//

import SwiftUI
import SwiftData

struct OrdersView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var categoriesVM: CategoriesViewModel = CategoriesViewModel(menuService: MockMenuService())
    @StateObject var ordersVM: OrderViewModel = OrderViewModel()
    @State private var navColumnVisibility: NavigationSplitViewVisibility = .all
    @State private var showAddOrderSheet: Bool = false
    @State private var showSelectOrderSheet: Bool = false

    var body: some View {
        
        NavigationSplitView(columnVisibility: $navColumnVisibility) {
            List {
                ForEach(categoriesVM.categories, id: \.Name) { item in
                    Button{
                        if(ordersVM.selectedOrder != nil){
                            categoriesVM.selectedCategory = item
                        }
                    }
                    label: {
                        CategoryButton(item: item)
                    }
                    .disabled(ordersVM.selectedOrder == nil)
                }
                Text("--------Debugging-----------")
                Button{
                    clear()
                }
                label: {
                    Text("Reset Selected")
                }
                Text("\(ordersVM.activeOrders.count)")
                Text("\(ordersVM.selectedOrder?.menuItemSelections.count ?? 0)")
                    .toolbar(removing: .sidebarToggle)
            }
            .onAppear{categoriesVM.fetchCategories()}
            .navigationTitle(Text("Categories"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("New Order") {
                        ordersVM.clearSelectedOrder()
                        showAddOrderSheet = true
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Select Order") {
                        showSelectOrderSheet = true
                    }
                }
            }
            .sheet(isPresented: $showAddOrderSheet, onDismiss: didDismissAddOrder) {
                EditOrderDetails(order: $ordersVM.selectedOrder)
            }
           .sheet(isPresented: $showSelectOrderSheet) {
               OrderList()
           }
            if(categoriesVM.loading){LoadingComponent()}
        }
        content: {
            if (ordersVM.selectedOrder != nil) {
                if let category = categoriesVM.selectedCategory {
                    ItemSelectionList(category: category)
                }
            }
            
        } detail: {
            if let selectedOrder = ordersVM.selectedOrder {
                ScrollView{
                    OrderDetails(order: selectedOrder)
                }
              } else {
                  Text("No order selected")
                      .foregroundColor(.secondary)
              }
        }
        .environmentObject(ordersVM)
        .environmentObject(categoriesVM)
        
        
    }
    
    func didDismissAddOrder() {
        if(ordersVM.selectedOrder != nil){
            ordersVM.addOrder(ordersVM.selectedOrder!)
            categoriesVM.clearSelectedCategory()
        }
    }
    
    func clear() {
        categoriesVM.clearSelectedCategory()
        ordersVM.clearSelectedOrder()
    }

}

#Preview {
    return OrdersView()
    
}

