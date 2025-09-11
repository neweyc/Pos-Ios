//
//  Category.swift
//  PosUi
//
//  Created by Chris Newey on 9/5/25.
//
import SwiftUI
import Combine

struct Category:Hashable{
    var Name:String
    var Color:Color
    var Items:[MenuItem]
}


struct MenuItemModifier: Hashable {
    
    var name: String
    var priceIncrease: Double
    var defaultSelected: Bool
}


struct MenuItem:Hashable, Identifiable{
    var id: String { Name }
    var Name:String
    var Price:Double
    var Modifiers:[MenuItemModifier] = []
}

struct MenuSelectionModifier: Hashable {
    var name: String
    var priceIncrease: Double
}


class MenuItemSelection:Hashable, ObservableObject, Identifiable{
    var id: UUID = UUID()
    var item:MenuItem
    @Published var modifiers:[MenuSelectionModifier] = []
    @Published var quantity: Int = 0
    @Published var specialInstructions: String = ""
    
    init(Item: MenuItem, Quantity: Int = 0, SpecialInstructions: String = ""){
        self.item = Item
        self.quantity = Quantity
        self.specialInstructions = SpecialInstructions
        for itemMod in Item.Modifiers{
            if itemMod.defaultSelected{
                modifiers.append(MenuSelectionModifier(name: itemMod.name, priceIncrease: itemMod.priceIncrease))
            }
        }
    }
    
    func getMenuItemModifiers() -> [MenuItemModifier]{
        return item.Modifiers
    }
    
    func setModifiers(_ modifiers: [MenuSelectionModifier]){
        self.modifiers = modifiers
    }
    
    func subTotal() -> Double{
        return Double(quantity) * item.Price
    }
    
    static func == (lhs: MenuItemSelection, rhs: MenuItemSelection) -> Bool {
        lhs === rhs // Reference equality
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
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
     @Published var menuItemSelections: [MenuItemSelection] = [] {
         didSet {
             subscribeToSelectionChanges()
         }
     }
     @Published var status: OrderStatus = .new
    let taxRate: Double = 0.08
    
    private var cancellables = Set<AnyCancellable>()
    
    init(orderNumber:Int, customerName: String? = nil, table: String? = nil, menuItemSelections: [MenuItemSelection] = []) {
        self.orderNumber = orderNumber
        self.customerName = customerName
        self.table = table
        self.menuItemSelections = menuItemSelections
      }
    
    func removeMenuItemSelection(menuItem: MenuItemSelection) {
        if let index = self.menuItemSelections.firstIndex(of: menuItem) {
            self.menuItemSelections.remove(at: index)
        }
    }
    
    
    func total() -> Double {
        return subtotal() + (subtotal() * taxRate)
    }
    
    func taxTotal () -> Double {
        return (subtotal() * taxRate)
    }
    
    func subtotal() -> Double {
        return menuItemSelections.reduce(0) { result, selection in
            result + selection.subTotal()
        }
    }

    
    private func subscribeToSelectionChanges() {
        // Cancel existing subscriptions
        cancellables.removeAll()
        
        // Subscribe to changes in each MenuItemSelection
        for selection in menuItemSelections {
            selection.objectWillChange.sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.objectWillChange.send()
                }
            }.store(in: &cancellables)
        }
    }
    
    func addMenuItemSelection(_ menuItemSelection: MenuItemSelection) {
        self.menuItemSelections.append(menuItemSelection)
        // subscribeToSelectionChanges() will be called automatically via didSet
    }
    
      // Hashable conformance
      static func == (lhs: Order, rhs: Order) -> Bool {
          lhs === rhs // Reference equality
      }

      func hash(into hasher: inout Hasher) {
          hasher.combine(ObjectIdentifier(self))
      }
}



