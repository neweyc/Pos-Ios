//
//  Category.swift
//  PosUi
//
//  Created by Chris Newey on 9/5/25.
//
import SwiftUI

struct Category:Hashable{
    var Name:String
    var Color:Color
    var Items:[MenuItem]
}


struct MenuItem:Hashable, Identifiable{
    var id: String { Name }
    var Name:String
    var Price:Double
}

struct MenuItemSelection:Hashable{
    var Item:MenuItem
    var Quantity:Int
    var SpecialInstructions:String?
    
    func subTotal() -> Double{
        return Double(Quantity) * Item.Price
    }
}

enum OrderStatus:String,CaseIterable{
    case new = "New"
    case preparing = "Preparing"
    case complete = "Complete"
}


final class Order:ObservableObject, Hashable, Identifiable{
    var id: UUID = UUID()
     var orderNumber: Int
     var customerName: String? = nil
     var table: String? = nil
     @Published var menuItemSelections: [MenuItemSelection] = []
     @Published var status: OrderStatus = .new
    
    init(orderNumber:Int, customerName: String? = nil, table: String? = nil, menuItemSelections: [MenuItemSelection] = []) {
        self.orderNumber = orderNumber
        self.customerName = customerName
        self.table = table
        self.menuItemSelections = menuItemSelections
      }

    
    func addMenuItemSelection(_ menuItemSelection: MenuItemSelection) {
        self.menuItemSelections.append(menuItemSelection)
    }
    
      // Hashable conformance
      static func == (lhs: Order, rhs: Order) -> Bool {
          lhs === rhs // Reference equality
      }

      func hash(into hasher: inout Hasher) {
          hasher.combine(ObjectIdentifier(self))
      }
}



