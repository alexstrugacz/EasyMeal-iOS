import SwiftUI

struct Recipes: View {
    @State var showView = false
    @ObservedObject var recipesViewModel: RecipesViewModel = RecipesViewModel()
    
    var openCart: () -> Void
    
    func addMissingIngredients(missingRecipes: [String]) {
        // add these to the cart items
        recipesViewModel.selectedRecipe = nil
        openCart()
    }
    
    var body: some View {
        VStack{

            VStack {
                Text("Recipes")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                
                
            }
            .foregroundColor(Color.white.opacity(1))
            .offset(y:20)
            .padding(.bottom, 40)
            
            if (recipesViewModel.loading) {
                ProgressView()
            }
            
            ScrollView(showsIndicators: false) {
                
                LazyVStack(spacing: 20) {
                    
                    ForEach(recipesViewModel.recipes) { recipe in
                        RecipeView(recipe: recipe, selectRecipe: recipesViewModel.selectRecipe)
                    }
                
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                
                Spacer(minLength: 100)
                
            }
            
        }
        .popover(item: $recipesViewModel.selectedRecipe) { recipe in
            RecipeInfo(newRecipe: recipe, newExitRecipe: {
                recipesViewModel.selectedRecipe = nil
            }, newAddMissingIngredients: addMissingIngredients)
        }
        
    }

}
