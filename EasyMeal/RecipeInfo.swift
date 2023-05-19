//
//  RecipeInfo.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 2/20/23.
//


import SwiftUI

struct RecipeInfo: View {
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
            
            ScrollView(showsIndicators: false) {
            
                HStack {
                    Button(action: {
                        exitRecipe()
                    }) {
                        HStack(spacing: 3) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 14))
                            Text("Back")
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                        }
                        .foregroundColor(.blue)
                    }
                    Spacer()
                }
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
                
                HStack {
                    Text("\(Int(recipe.calories)) calories")
                    Spacer()
                    Button(action: {
                        if let url = URL(string: recipe.mealLink) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("See Recipe")
                            .foregroundColor(.blue)
                    }
                }
                .frame(width: 280)
                VStack{
                    Text("Nutrition Insights")
                        .bold()
                    ProgressBar(value: Float(recipe.healthScore)/10)
                        .frame(height: 20)
                        .padding(.bottom, 20)
                    HStack {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .leading) {
                            ForEach(recipeViewModel.nutrientData) { nutrData in
                                NutrientRowView(nutrientData: nutrData)
                            }
//                                ForEach(0..<recipeViewModel.nutrientData.count/2) { index in
//                                    if column == 0 {
//                                        NutrientRowView(nutrientData: recipeViewModel.nutrientData[index])
//                                    } else {
//                                        NutrientRowView(nutrientData: recipeViewModel.nutrientData[index + recipeViewModel.nutrientData.count/2])
//                                    }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 16)
                }
                
                
                Spacer()
                    .padding()
                    .offset(y: 10)
                
                VStack{
                    Text("Ingredients")
                        .bold()
                    
                    HStack {
                        Spacer()
                        Text("\(recipe.numIngredients)/\(recipe.totalIngredients) available")
                        Spacer()
                        Button {
                            handleAddMissingIngredients()
                        } label: {
                            Text("Add Missing Items to Cart")
                            
                        }

                        Spacer()
                    }
                    .frame(width: 280)
                    
                    
                    
                    .padding(.horizontal, 16)
                    
                }
                VStack(alignment: .leading) {
                    ForEach(recipe.ingredients) { ingredient in
                        HStack {
                            Text(removeEmTags(from: ingredient.name.capitalized))
                                //.offset(x: -20)
                                .background(Color.gray.opacity(0.1))

                            if ingredient.available {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                                
                                
                            } else {
                                Image(systemName: "xmark")
                                    .foregroundColor(.red)
                            }
                                
                            Spacer()
                            
                        }

                        .padding(.vertical, 4)
                    }
                    
                }
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
            Spacer()
            Text(nutrientData.nutrientAmount)
                
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
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: geometry.size.width * 0.12)
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width * 0.72, height: geometry.size.height * 1.6)
                        .opacity(0.3)
                        .foregroundColor(Color.red.opacity(0.9))
                    
                    Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width * 0.72, geometry.size.width), height: geometry.size.height * 1.6)
                        .foregroundColor(custGreen)
                    
                    HStack{
                        Text("EasyMeal Health Score™")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .alignmentGuide(HorizontalAlignment.center) { d in d[HorizontalAlignment.center] }
                            .alignmentGuide(VerticalAlignment.bottom) { d in d[VerticalAlignment.top] - geometry.size.height }
                            .offset(x:10)
                        
                        Text("\(String(format: "%.2f", round(value*10*10)/10))/10")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .alignmentGuide(HorizontalAlignment.center) { d in d[HorizontalAlignment.center] }
                            .alignmentGuide(VerticalAlignment.bottom) { d in d[VerticalAlignment.top] - geometry.size.height }
                            .offset(x:10)
                        
                    }
                }.cornerRadius(8.0)
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


