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
        
        let numberFormatter: NumberFormatter = {
            let num = NumberFormatter()
            num.maximumFractionDigits = 0
            return num
        }()
    
    var body: some View {
        VStack{

            HStack {
                Button(action: {
                    showFilter.toggle()
                }) {
                    Image(systemName: "slider.horizontal.3") // This is a built-in SwiftUI filter icon
                        .resizable()
                        .frame(width: 33, height: 30)
                        .foregroundColor(.gray)
                        .padding(.leading,10)
                }
                .padding()

                Spacer()

                Text("Recipes")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                    .offset(x: -40)
                

                Spacer()
            }
            .offset(y: -5)
            .foregroundColor(Color.white.opacity(1))
            .padding(.top, 25)
            .padding(.bottom, 10)

            if showFilter {
                HStack {
                    Button(action: {
                        if showHealth == true{
                            showHealth = false
                        } else {
                            showHealth = true
                            showMaxCal = false
                            showMinCal = false
                        }
                        }
                    ) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(custGreen)
                            .frame(width: 120, height: 30)
                            .overlay(
                                Text("Heath Score")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                            )
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if showMinCal == true{
                            showMinCal = false
                        } else {
                            showHealth = false
                            showMaxCal = false
                            showMinCal = true
                        }
                        }
                    ) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(custMedGreen)
                            .frame(width: 120, height: 30)
                            .overlay(
                                Text("Min Calories")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                            )
                    }
                    
                    Spacer()
                    
                    
                    Button(action: {
                        if showHealth == true{
                            showMaxCal = false
                        } else {
                            showHealth = false
                            showMaxCal = true
                            showMinCal = false
                        }
                        }
                    ) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(custDarkGreen)
                            .frame(width: 120, height: 30)
                            .overlay(
                                Text("Max Calories")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                            )
                    }
                }
                .offset (y: -13)
                .padding(.horizontal, 20)
                .onChange(of: recipesViewModel.minHealthScore) { newValue in
                    recipesViewModel.loadRecipes()
                }
                .onChange(of: recipesViewModel.minCalories) { newValue in
                    recipesViewModel.loadRecipes()
                }
                .onChange(of: recipesViewModel.maxCalories) { newValue in
                    recipesViewModel.loadRecipes()
                }
                
                if showHealth {
                    VStack{
                        Text("Minimum Health Score:  \(numberFormatter.string(from: NSNumber(value: recipesViewModel.minHealthScore))!)")
                            .font(.system(size:20))
                        
                        Slider(value: $recipesViewModel.minHealthScore, in: 0...10, step: 1.0, minimumValueLabel: Text("0"), maximumValueLabel: Text("10"), label: {})
                            .padding(.horizontal,20)
                            .tint(custGreen)
                    }
                    .offset(y:-5)
                }
                
                if showMinCal {
                    VStack{
                        Text("Minimum Calories:  \(numberFormatter.string(from: NSNumber(value: recipesViewModel.minCalories))!)")
                            .font(.system(size:20))
                        
                        Slider(value: $recipesViewModel.minCalories, in: 100...2000, step: 10.0, minimumValueLabel: Text("100"), maximumValueLabel: Text("2000"), label: {})
                            .padding(.horizontal,20)
                            .tint(custMedGreen)
                            
                    }
                    .offset(y:-5)
                }
                
                if showMaxCal {
                    VStack{
                        Text("Maximum Calories:  \(numberFormatter.string(from: NSNumber(value: recipesViewModel.maxCalories))!)")
                            .font(.system(size:20))
                        
                        Slider(value: $recipesViewModel.maxCalories, in: 100...2000, step: 10.0, minimumValueLabel: Text("100"), maximumValueLabel: Text("2000"), label: {})
                            .padding(.horizontal,20)
                            .tint(custDarkGreen)
                    }
                    .offset(y:-5)
                }
            }
            
            
            if (recipesViewModel.loading) {
                ProgressView()
            }
            
            ScrollView(showsIndicators: false) {
                
                LazyVStack(spacing: 20) {
                    
                    ForEach(recipesViewModel.recipes) { recipe in
                        RecipeView(recipe: recipe, selectRecipe: recipesViewModel.selectRecipe)
                        Divider()
                         .frame(height: 1)
                         .padding(.horizontal, 30)
                         .background(Color(hex: "#ccc"))
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
