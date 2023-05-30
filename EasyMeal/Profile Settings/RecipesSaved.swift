//
//  Privacy.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 3/1/23.
//

import SwiftUI

struct RecipesSaved: View {
    @ObservedObject var recipesViewModel: RecipesViewModel = RecipesViewModel()
    
    var openCart: () -> Void
    
    func addMissingIngredients(missingRecipes: [String]) {
        // add these to the cart items
        openCart()
    }
    
    var body: some View {
        VStack {
            if (recipesViewModel.loading) {
                ProgressView()
            }
            
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 15) {
                    ForEach(recipesViewModel.recipes) { recipe in
                        RecipeView(recipe: recipe, selectRecipe: recipesViewModel.selectRecipe)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                
                Spacer(minLength: 100)
                
            }
        }
        .background(Color(hex: "#F7F7F7"))
        .fullScreenCover(item: $recipesViewModel.selectedRecipe) { recipe in
            RecipeInfo(newRecipe: recipe, newExitRecipe: {
                recipesViewModel.selectedRecipe = nil
            }, newAddMissingIngredients: addMissingIngredients)
        }
    }
}


struct RecipeSavedPreviews_Previews: PreviewProvider {
    static var previews: some View {
        RecipesSaved(, openCart: <#() -> Void#>)
    }
}
