//
//  Recipe.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/18/23.
//

import Foundation
struct Recipe: Identifiable, Hashable {
    let id = UUID()
    var recipeNumber: String
    var name: String
    var url: String
    var numIngredients: Int
    var totalIngredients: Int
    var healthScore: Double
    var mealLink: String
    var calories: Double
    var ingredients: [Ingredient]
}
