//
//  MenuService.swift
//  PosUi
//
//  Created by Chris Newey on 9/9/25.
//


protocol IMenuService {
    func getCategories() -> [Category]
}



final class MockMenuService: IMenuService {
    func getCategories() -> [Category] {
        MockData.Categories
    }
}
