
import SwiftUI
struct RecipeInfo: View {
    
    let initialNutrientCount = 3
    
    @State private var isExpanded = false
    
    var exitRecipe: () -> Void
    var addMissingIngredients: ([String]) -> Void
    
    var recipe: Recipe
    
    @ObservedObject var recipeViewModel: RecipeViewModel
    
    init(newRecipe: Recipe, newExitRecipe: @escaping () -> Void, newAddMissingIngredients: @escaping ([String]) -> Void) {
        recipe = newRecipe
        recipeViewModel = RecipeViewModel(newRecipe: newRecipe)
        exitRecipe = newExitRecipe
        addMissingIngredients = newAddMissingIngredients
    }
    
    
    func handleAddMissingIngredients() {
        let storedItems = UserDefaults.standard.array(forKey: "savedItems") as? [[String: Any]] ?? []
        var items = storedItems.map { ShoppingItem(from: $0) }
        var itemNames = items.map { $0.name }
        var missingIngredients: [String] = []
        
        for ingredient in recipe.ingredients {
            if !ingredient.available {
                if (!itemNames.contains(ingredient.name.capitalized)) {
                    let shoppingItem: ShoppingItem = ShoppingItem(name: ingredient.name.capitalized, isChecked: false)
                    items.append(shoppingItem)
                    missingIngredients.append(ingredient.name.capitalized)
                }
            }
        }
        print(items)
        let encodedItems = items.map { $0.toDictionary() }
        UserDefaults.standard.set(encodedItems, forKey: "savedItems")
        
        addMissingIngredients(missingIngredients)
    }
        
    var body: some View {
        VStack {
            ScrollView {
                
                AsyncImage(url: URL(string: recipe.url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .cornerRadius(30)
                } placeholder: {
                    
                        ZStack {
                            Color(red: 0.8, green: 0.8, blue: 0.8)
                                .cornerRadius(10)
                            Text("No Image")
                                .foregroundColor(.gray)
                                .font(.headline)
                        }
                        .frame(width: 300, height: 300)
                        .cornerRadius(30)
                    
                }

                    
                
                Text(recipe.name)
                    .font(.title)
                    .padding(.vertical, 2)
                
                
                HStack {
                    Text("\(Int(recipe.calories)) calories")
                    Spacer()
                    Button(action: {
                        if let url = URL(string: recipe.mealLink) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue)
                            .frame(width: 120, height: 30)
                            .overlay(
                                Text("See Recipe")
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                            )
                    }
                }
                .frame(width: 280)
                
                
                
                HorizontalDivider(color: .gray.opacity(0.5))
                
                VStack {
                    Text("Nutrition Insights")
                        .font(.system(size: 18))
                        .bold()
                        .padding(.top, 4)
                    ProgressBar(value: Float(recipe.healthScore
                                            )/10)
                        .frame(height: 20)
                        .padding(.bottom, 20)
                    
                    
                    VStack(alignment: .leading) {
                        if (recipeViewModel.nutrientData.count > 3) {
                            ForEach(recipeViewModel.nutrientData[...2]) { nutrData in
                                NutrientRowView(nutrientData: nutrData)
                            }
                            if (isExpanded) {
                                ForEach(recipeViewModel.nutrientData[2...]) { nutrData in
                                    NutrientRowView(nutrientData: nutrData)
                                }
                            }
                            
                        } else {
                            ForEach(recipeViewModel.nutrientData) { nutrData in
                                NutrientRowView(nutrientData: nutrData)
                            }
                            
                        }

                    }
                    .padding(.horizontal, 16)
                    
                    if recipe.ingredients.count > initialNutrientCount {
                        Button(action: {
                            isExpanded.toggle()
                        }) {
                            Text(isExpanded ? "See Less" : "See More")
                                .foregroundColor(.blue)
                                .padding(.vertical, 6)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            isExpanded.toggle()
                        }
                    }

                    
                }
                .padding(.bottom,10)
                
                Spacer()
                
                HorizontalDivider(color: .gray.opacity(1))
                
                VStack {
                    Text("Ingredients")
                        .font(.system(size: 18))
                        .bold()
                        .padding(.bottom, 4)
                        .padding(.top, 4)
                    
                    HStack {
                        Text("\(recipe.numIngredients)/\(recipe.totalIngredients) available")
                            .font(.system(size: 18))
                        Spacer()
                        Button(action: {
                            // Send ingredients to cart
                            handleAddMissingIngredients()
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.blue)
                                .frame(width: 120, height: 30)
                                .overlay(
                                    Text("Add to Cart")
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                )
                        }
                    }
                    .frame(width: 280)
                    .padding(.horizontal, 16)
                    
                }
                
                VStack(alignment: .leading) {
                    ForEach(recipe.ingredients) { ingredient in
                        HStack {
                            Text(removeEmTags(from: ingredient.name.capitalized))
                                .padding(.leading, 8)
                            
                            if ingredient.available {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                                
                                
                            } else {
                                Image(systemName: "xmark")
                                    .foregroundColor(.red)
                            }
                            
                            Spacer()
                        }
                        .padding(.vertical, 5)
                    }
                }
                .padding(.vertical, 15)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            }
            .padding(.all, 16)
        }
    }
}

struct NutrientRow: Identifiable {
    let id = UUID()
    let nutrientName: String
    let nutrientAmount: String
}

struct NutrientRowView: View {
    let nutrientData: NutrientRow
    
    var body: some View {
        HStack {
            Text(nutrientData.nutrientName)
                .padding(.leading, 15)
                .padding(.vertical,4)
                .bold()
            Spacer()
            Text(nutrientData.nutrientAmount)
                .padding(.trailing, 15)
        }
        .padding(.vertical, 4)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(6)
    }
}

func removeEmTags(from string: String) -> String {
    let regex = try! NSRegularExpression(pattern: "<[/]?em[^>]*>", options: .caseInsensitive)
    let range = NSRange(location: 0, length: string.utf16.count)
    return regex.stringByReplacingMatches(in: string, options: [], range: range, withTemplate: "")
}

struct ProgressBar: View {
    var value: Float
    @State var score = 10
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: geometry.size.width * 0.12)
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width * 0.72, height: geometry.size.height * 1.6)
                        .opacity(0.3)
                        .foregroundColor(Color.red.opacity(0.3))
                    
                    Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width * 0.72, geometry.size.width), height: geometry.size.height * 1.6)
                        .foregroundColor(custGreen)
                    
                    HStack {
                        Text("Health Score™")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .alignmentGuide(HorizontalAlignment.center) { d in d[HorizontalAlignment.center] }
                            .alignmentGuide(VerticalAlignment.bottom) { d in d[VerticalAlignment.top] - geometry.size.height }
                            .offset(x: 10)
                        
                        Text("\(String(format: "%.2f", round(value * 10 * 10)/10))/10")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .alignmentGuide(HorizontalAlignment.center) { d in d[HorizontalAlignment.center] }
                            .alignmentGuide(VerticalAlignment.bottom) { d in d[VerticalAlignment.top] - geometry.size.height }
                            .offset(x: 10)
                    }
                }
                .cornerRadius(8.0)
                Spacer()
                    .frame(width: geometry.size.width * 0.05)
            }
        }
    }
    
    
}
struct Ingredient: Identifiable, Hashable {
    var id: UUID
    var name: String
    var available: Bool
    init(newName: String, newAvailable: Bool) {
        id = UUID()
        name = newName
        available = newAvailable
    }
}

struct HorizontalDivider: View {
    
    let color: Color
    let height: CGFloat
    
    init(color: Color, height: CGFloat = 0.5) {
        self.color = color
        self.height = height
    }
    
    var body: some View {
        color
            .frame(width: 300, height: height)
            .padding(.top,5)
            .padding(.bottom,8)
    }
}
