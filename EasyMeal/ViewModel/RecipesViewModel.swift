//
//  RecipesViewModel.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/18/23.
//

import SwiftUI

class RecipesViewModel : ObservableObject {
    @Published var loading = false
    @Published var recipes: [Recipe] = []
    @Published var selectedRecipe: Recipe?
    
    func selectRecipe(recipeId: Recipe) {
        selectedRecipe = recipeId
    }
    
    func deselectRecipe() {
        selectedRecipe = nil
    }
    
    func loadRecipes() {
        loading = true
        let pantryItems = UserDefaults.standard.array(forKey: "pantryItems") as? [String] ?? []
        
        let allPantryItems = pantryItems.joined(separator: ",")
        
        let apiUrl = "https://easymeal-backend.herokuapp.com/recipes?ingredients=\(allPantryItems.lowercased())&page=0"
        
        
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
                if let json = try JSONSerialization.jsonObject(with: dataSecure, options: .allowFragments) as? [String: [[String: Any]]] {
                    guard let recipesData = json["recipes"] else {
                        DispatchQueue.main.async {
                            self.recipes = []
                        }
                        self.loading = false
                        return
                    }
                    DispatchQueue.main.async {
                        self.recipes = []
                    }
                    for recipe in recipesData {

                        if let recipeNumber = recipe["objectID"] as? String, let name = recipe["title"] as? String, let numIngredients = recipe["numIngredientsMatched"] as? Int, let totalIngredients = recipe["numIngredients"] as? Int, let healthScore = recipe["healthScore"] as? Double, let url = recipe["img"] as? String, let mealLink = recipe["url"] as? String, let calories = recipe["energy"] as? Double, let ingredients = recipe["ingredients"] as? [[String: Any]] {
                            
                            var newIngredients: [Ingredient] = []
                            
                            for ingredient in ingredients {
                                if let name = ingredient["name"] as? String, let available = ingredient["available"] as? Bool {
                                    if available == true {
                                        newIngredients.append(Ingredient(newName: name, newAvailable: available))
                                    } else {
                                        
                                        newIngredients.append(Ingredient(newName: name, newAvailable: available))
                                        
                                    }
                                }
                            }
                                
                            let individualRecipe = Recipe(recipeNumber: recipeNumber, name: name, url: url, numIngredients: numIngredients, totalIngredients: totalIngredients, healthScore: healthScore, mealLink: mealLink, calories: calories, ingredients: newIngredients)
                            DispatchQueue.main.async {
                                self.recipes.append(individualRecipe)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.loading = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self.recipes = []
                        self.loading = false
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.loading = false
                }
            }
        }
        task.resume()
    }
    
    init() {
        loadRecipes()
        
    }
}
