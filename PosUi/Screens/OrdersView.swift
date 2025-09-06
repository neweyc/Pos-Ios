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
    private var categories: [Category] = MockData.Categories

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(categories, id: \.Name) { item in
                    NavigationLink {
                        Text("You selected \(item.Name)")
                    } label: {
                        Text(item.Name)
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

}

#Preview {
    OrdersView()
       
}

