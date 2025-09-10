//
//  ContentView.swift
//  PosUi
//
//  Created by Chris Newey on 9/5/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
  

    var body: some View {
        TabView {
            OrdersView()
                .tabItem({
                    Image(systemName:"pencil.and.list.clipboard")
                    Text("Orders")
                })
            KitchenView()
                .tabItem({
                    Image(systemName:"oven")
                    Text("Kitchen")
                })
        }
    
        
            
    }

}

#Preview {
    ContentView()
       
}
