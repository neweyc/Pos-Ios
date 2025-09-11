//
//  ItemSelection.swift
//  PosUi
//
//  Created by Chris Newey on 9/7/25.
//

import SwiftUI
import UIKit



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
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header Section
                    VStack(spacing: 8) {
                        Text(item.Name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("$\(item.Price, specifier: "%.2f")")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top)
                    
                    // Quantity Section
                    VStack(spacing: 12) {
                        Text("Quantity")
                            .font(.headline)
                        
                        HStack(spacing: 20) {
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
                                .font(.title2)
                                .fontWeight(.semibold)
                                .frame(minWidth: 50)
                            
                            Button("+") {
                                selectedItem.quantity += 1
                            }
                            .frame(width: 50, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
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
            
                    // Special Instructions Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Special Instructions")
                            .font(.headline)
                        TextField("Enter special instructions", text: $selectedItem.specialInstructions)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(height: 44)
                    }
                    
                    // Bottom padding for scroll content
                    Spacer(minLength: 100)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Customize Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        onCancel()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add to Order") {
                        if selectedItem.quantity > 0 {
                            onUpdate(selectedItem)
                        }
                    }
                    .disabled(selectedItem.quantity < 1)
                    .fontWeight(.semibold)
                }
            }
        }
        .overlay(
            // Sticky bottom buttons for larger screens
            VStack {
                Spacer()
                if UIDevice.current.userInterfaceIdiom == .pad {
                    HStack(spacing: 20) {
                        Button("Cancel") {
                            onCancel()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(.systemGray4))
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                        
                        Button("Add to Order") {
                            if selectedItem.quantity > 0 {
                                onUpdate(selectedItem)
                            }
                        }
                        .disabled(selectedItem.quantity < 1)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(selectedItem.quantity > 0 ? Color.blue : Color(.systemGray4))
                        .foregroundColor(selectedItem.quantity > 0 ? .white : .secondary)
                        .cornerRadius(10)
                        .fontWeight(.semibold)
                    }
                    .padding()
                    .background(
                        Rectangle()
                            .fill(.regularMaterial)
                            .ignoresSafeArea(edges: .bottom)
                    )
                }
            }
        )
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

