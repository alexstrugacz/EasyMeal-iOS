import SwiftUI

struct Recipes: View {
    @State var showView = false
    @State var showHealth = false
    @State var showMinCal = false
    @State var showMaxCal = false
    
    @ObservedObject var recipesViewModel: RecipesViewModel = RecipesViewModel()
    
    var openCart: () -> Void
    
    func addMissingIngredients(missingRecipes: [String]) {
        // add these to the cart items
        recipesViewModel.selectedRecipe = nil
        openCart()
    }
    
    @State var showFilter = false
    
    var body: some View {
        VStack{

            
            FiltersView(showFilter: $showFilter, showHealth: $showHealth, showMinCal: $showMinCal, showMaxCal: $showMaxCal, minHealthScore:$recipesViewModel.minHealthScore, minCalories: $recipesViewModel.minCalories, maxCalories: $recipesViewModel.maxCalories)
                .onChange(of: recipesViewModel.minHealthScoreDebounce) { newValue in
                    recipesViewModel.loadRecipes()
                }
                .onChange(of: recipesViewModel.minCaloriesDebounce) { newValue in
                    recipesViewModel.loadRecipes()
                }
                .onChange(of: recipesViewModel.maxCaloriesDebounce) { newValue in
                    recipesViewModel.loadRecipes()
                }
                
            
            
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

struct Recipes_Previews: PreviewProvider {
    static var previews: some View {
        // Substitute this with your actual ViewModel initialization
        let viewModel = RecipesViewModel()
        
        // Define a mock openCart function
        let mockOpenCart = {}
        
        // Use viewModel and mockOpenCart function in your Recipes view
        Recipes(recipesViewModel: viewModel, openCart: mockOpenCart)
    }
}
