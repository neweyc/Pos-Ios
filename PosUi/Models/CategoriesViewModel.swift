//
//  CategoriesViewModel.swift
//  PosUi
//
//  Created by Chris Newey on 9/8/25.
//

import Foundation

final class CategoriesViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var selectedCategory: Category?
    @Published var loading: Bool = false
    let menuService: IMenuService
    
    init(menuService: IMenuService){
        self.menuService = menuService
    }
    
    func clearSelectedCategory() {
        self.selectedCategory = nil
    }
    
    
    
    func fetchCategories() {
        self.loading = true
        defer {
            self.loading = false
        }
        self.categories = menuService.getCategories();
    }
}
