
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
    
    let numberFormatter: NumberFormatter = {
        let num = NumberFormatter()
        num.maximumFractionDigits = 0
        return num
    }()
    
    func handleAddMissingIngredients() {
        let storedItems = UserDefaults.standard.array(forKey: "savedItems") as? [[String: Any]] ?? []
        var items = storedItems.map { ShoppingItem(from: $0) }
        var itemNames = items.map { $0.name }
        var missingIngredients: [String] = []
        
        for ingredient in recipe.ingredients {
            if !ingredient.available {
                if (!itemNames.contains(ingredient.name.capitalized)) {
                    if ingredient.name.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                        let shoppingItem: ShoppingItem = ShoppingItem(name: ingredient.name.capitalized, isChecked: false)
                        items.append(shoppingItem)
                        missingIngredients.append(ingredient.name.capitalized)
                    }
                }
            }
        }
        print(items)
        let encodedItems = items.map { $0.toDictionary() }
        UserDefaults.standard.set(encodedItems, forKey: "savedItems")
        
        addMissingIngredients(missingIngredients)
    }
        
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        ZStack {
                            Color.white
                            AsyncImage(url: URL(string: recipe.url)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geo.size.width, height: 400)
                                    .cornerRadius(20)
                            } placeholder: {
                                
                                ZStack {
                                    Color(red: 0.8, green: 0.8, blue: 0.8)
                                        .cornerRadius(10)
                                    Text("No Image")
                                        .foregroundColor(.gray)
                                        .font(.headline)
                                }
                                .frame(width: geo.size.width, height: 400)
                                .cornerRadius(20)
                                
                            }
                            VStack {
                                HStack {
                                    Button {
                                        exitRecipe()
                                    } label: {
                                        Image(systemName: "arrow.left.circle.fill")
                                            .resizable()
                                            .foregroundColor(.white)
                                            .frame(width: 40, height: 40)
                                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 7, x: 2, y: 3)
                                    }
                                    Spacer()
                                }
                                .padding(.top, 50)
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            
                        }
                        .frame(width: geo.size.width, height: 400)
                        .clipped()
                        VStack(alignment: .leading) {
                            Text(recipe.name)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top, 20)
                            
                            HStack(spacing: 5) {
                                
                                
                                Text("\(numberFormatter.string(from: NSNumber(value: recipe.calories)) ?? "-") cal.")
                                    .font(.system(size: 16))
                                    .fontWeight(.regular)
                                    .foregroundColor(.gray)
                            
                                Button(action: {
                                    if let url = URL(string: recipe.mealLink) {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    Text("See Recipe")
                                        .font(.system(size: 16))
                                        .fontWeight(.regular)
                                        .foregroundColor(custGreen)
                                }
                                
                                Spacer()
                                
                            }
                            .padding(.top, 0)
                            .padding(.bottom, 15)
                            
                            VStack {
                                HStack {
                                    Text("Nutrition Insights")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                        .bold()
                                        .padding(.top, 4)
                                    Spacer()
                                }
                                HorizontalDivider(color: .gray.opacity(0.5))
                                    .offset(y: -7)
                                
                                ProgressBar(value: Float(recipe.healthScore)/10)
                                    .frame(height: 20)
                                    .padding(.bottom, 10)

        
                                LazyVGrid(columns: [
                                    GridItem(.flexible(), alignment: .leading), GridItem(.flexible(), alignment: .leading),
                                ], alignment: .leading) {
                                    ForEach(recipeViewModel.nutrientData) { nutrData in
                                        NutrientRowView(nutrientData: nutrData)
                                    }
                                }
                            }
                            .padding(.bottom,15)
                            VStack {
                                HStack {
                                    Text("Ingredients")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                        .bold()
                                        .padding(.top, 4)
                                    Spacer()
                                }
                                HorizontalDivider(color: .gray.opacity(0.5))
                                    .offset(y: -7)
                                HStack(spacing: 5) {
                                    Text("\(recipe.numIngredients)/\(recipe.totalIngredients) available")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 16))
                                    Spacer()
                                    Button(action: {
                                        // Send ingredients to cart
                                        handleAddMissingIngredients()
                                    }) {
                                        Text("Add to Cart")
                                            .foregroundColor(custGreen)
                                            .font(.system(size: 16))
                                    }
                                }
        
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
                            .padding(.bottom, 100)

                            
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .ignoresSafeArea()
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
                .font(.system(size: 16))
                .padding(.leading, 15)
                .padding(.vertical,4)
                .bold()
            Spacer()
            Text(nutrientData.nutrientAmount)
                .font(.system(size: 16))
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
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width, height: geometry.size.height * 1.6)
                        .opacity(0.3)
                        .foregroundColor(Color.red.opacity(0.9))
                    
                    Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height * 1.6)
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
            }
            .frame(width: .infinity, height: 30)
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
            .frame(height: height)
    }
}
