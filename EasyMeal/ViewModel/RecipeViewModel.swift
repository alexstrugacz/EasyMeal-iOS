//
//  RecipeViewModel.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/18/23.
//

import SwiftUI

class RecipeViewModel : ObservableObject {
    var recipe: Recipe
    @Published var loading = false
    @Published var url: URL?
    @Published var nutrientData: [NutrientRow] = []
    @Published var ingredients: [Ingredient] = []

    @Published var numMatched = 0
    @Published var numTotal = 0
//    @Published var progressBarValue:
    
    let FIELDS: [Col] = [
        Col(colName: "protein", displayName: "Protein"),
        Col(colName: "carbohydrates", displayName: "Carbs"),
        
        Col(colName: "fiber_total_dietary", displayName: "Dietary Fiber"),
        Col(colName: "total_fats", displayName: "Fat"),
        
        Col(colName: "sugars_total", displayName: "Sugars"),
        Col(colName: "fatty_acids_total_saturated_200", displayName: "Sat. Fat")
    ]
    
    init(newRecipe: Recipe) {
        recipe = newRecipe
        getRecipeData()
    }
    
    func getRecipeData() {
        
        let apiUrl = "https://easymeal-backend.herokuapp.com/recipes/\(recipe.recipeNumber)"
        
        guard let apiUrlFormatted = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: apiUrlFormatted) else {
            loading = false
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                
                self.loading = false
                return
            }
            
            do {
                guard let dataSecure = data else {
                    self.loading = false
                    return
                }
                if let json = try JSONSerialization.jsonObject(with: dataSecure, options: .allowFragments) as? [String: [String: Any]] {
                    guard let recipe: [String: Any] = json["recipe"] else {
                        self.loading = false
                        return
                    }
                    for field in self.FIELDS {
                        if let value: Double = recipe[field.colName] as? Double {
                            self.nutrientData.append(NutrientRow(nutrientName: field.displayName, nutrientAmount: "\(value)g"))
                        }
                    }
                } else {
                    self.loading = false
                }
            } catch {
                self.loading = false
            }
            
        }
        
        task.resume()
        
        
    }
    
    
}
