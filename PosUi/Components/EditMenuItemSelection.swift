//
//  ItemSelection.swift
//  PosUi
//
//  Created by Chris Newey on 9/7/25.
//

import SwiftUI



struct EditMenuItemSelection: View {
    var item: MenuItem
    @ObservedObject var selectedItem: MenuItemSelection
    var onUpdate: (MenuItemSelection) -> Void
    var onCancel: () -> Void
    
    init(item: MenuItem, selectedItem: MenuItemSelection, onUpdate: @escaping (MenuItemSelection) -> Void, onCancel: @escaping () -> Void) {
        self.item = item
        let localItem = MenuItemSelection(Item: item, Quantity: selectedItem.quantity, SpecialInstructions: selectedItem.specialInstructions)
        localItem.setModifiers(selectedItem.modifiers)
        self.selectedItem = localItem
        self.onUpdate = onUpdate
        self.onCancel = onCancel
     }
    
  
    
    var body: some View {
        VStack(spacing: 20) {
            Text(item.Name)
                .font(.title)
            Text("$\(item.Price, specifier: "%.2f")")
                .font(.title2)
                .foregroundColor(.secondary)
            Spacer()
            HStack {
                Button("-") {
                    if selectedItem.quantity > 0 {
                        selectedItem.quantity -= 1
                    }
                }
                .frame(width: 50, height: 50)
                .background(selectedItem.quantity > 0 ? Color.red : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(selectedItem.quantity == 0)
                
                Text("\(selectedItem.quantity)")
                    .font(.title)
                    .frame(minWidth: 50)
                
                Button("+") {
                    selectedItem.quantity += 1
                }
                .frame(width: 50, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            // Modifiers Section
            if !selectedItem.getMenuItemModifiers().isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Modifiers")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 12) {
                        ForEach(selectedItem.getMenuItemModifiers(), id: \.name) { modifier in
                            ModifierToggleButton(
                                modifier: modifier,
                                isSelected: selectedItem.modifiers.contains { $0.name == modifier.name },
                                onToggle: { isSelected in
                                    if isSelected {
                                        // Add modifier
                                        let selectionModifier = MenuSelectionModifier(
                                            name: modifier.name,
                                            priceIncrease: modifier.priceIncrease
                                        )
                                        selectedItem.modifiers.append(selectionModifier)
                                    } else {
                                        // Remove modifier
                                        selectedItem.modifiers.removeAll { $0.name == modifier.name }
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Special Instructions")
                    .font(.headline)
                TextField("Enter special instructions", text: $selectedItem.specialInstructions)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 44)
            }
            
            Spacer()
            HStack(spacing: 20) {
                Button("Cancel") {
                    onCancel()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("OK") {
                    if(selectedItem.quantity > 0){
                        onUpdate(selectedItem)
                    }else {
                        print("Quantity is 0, not dismissing")
                    }
                    
                }
                .disabled(selectedItem.quantity < 1)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
    }
}

struct ModifierToggleButton: View {
    let modifier: MenuItemModifier
    let isSelected: Bool
    let onToggle: (Bool) -> Void
    
    var body: some View {
        Button(action: {
            onToggle(!isSelected)
        }) {
            VStack(spacing: 4) {
                Text(modifier.name)
                    .font(.system(size: 14, weight: .medium))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                if modifier.priceIncrease != 0 {
                    Text(modifier.priceIncrease > 0 ? "+$\(modifier.priceIncrease, specifier: "%.2f")" : "$\(modifier.priceIncrease, specifier: "%.2f")")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.secondary)
                } else {
                    Text("FREE")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
            .frame(minHeight: 60)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color.blue : Color(.systemGray6))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color.blue : Color(.systemGray4), lineWidth: 1)
            )
            .foregroundColor(isSelected ? .white : .primary)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

