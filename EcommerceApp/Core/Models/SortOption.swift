//
//  SortOption.swift
//  EcommerceApp
//
//  Created by Beyza Nur Tekerek on 25.05.2025.
//

import Foundation

struct FilterOption {
    var sortBy: SortOption?
    var brands: [String]
    var models: [String]
    
    init(sortBy: SortOption?, brands: [String], models: [String]) {
        self.sortBy = sortBy
        self.brands = brands
        self.models = models
    }
}

enum SortOption: Int, CaseIterable {
    case oldToNew = 0
    case newToOld = 1
    case priceHighToLow = 2
    case priceLowToHigh = 3
    
    var title: String {
        switch self {
        case .oldToNew:
            return "Old to new"
        case .newToOld:
            return "New to old"
        case .priceHighToLow:
            return "Price hight to low"
        case .priceLowToHigh:
            return "Price low to High"
        }
    }
}
