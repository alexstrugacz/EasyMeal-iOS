//
//  GroupedItems.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/17/23.
//

import Foundation
struct GroupedItems: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var pantryIngredients: [PantryIngredient]
    init(name: String, pantryIngredients: [PantryIngredient]) {
        self.name = name
        self.pantryIngredients = pantryIngredients
    }
}
