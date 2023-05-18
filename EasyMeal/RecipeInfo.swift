//
//  RecipeInfo.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 2/20/23.
//

import SwiftUI
struct RecipeInfo: View {
    let recipeURL = URL(string: "https://www.easymeal.me")!
    
    @State var progressBarValue = Float(1)
    
    let nutrientData = [
        NutrientRow(nutrientName: "Protein", nutrientAmount: "51.8g"),
        NutrientRow(nutrientName: "Dietary Fiber", nutrientAmount: "2.1g"),
        NutrientRow(nutrientName: "Sugars", nutrientAmount: "0.6g"),
        NutrientRow(nutrientName: "Cl.", nutrientAmount: "180.9mg"),
        NutrientRow(nutrientName: "Carbs", nutrientAmount: "14.7g"),
        NutrientRow(nutrientName: "Fat", nutrientAmount: "26.7g"),
        NutrientRow(nutrientName: "Sat. Fat", nutrientAmount: "5g"),
        NutrientRow(nutrientName: "Calcium", nutrientAmount: "545.9mg")
    ]
    
    let initialNutrientCount = 3
        
    @State private var isExpanded = false
    
    @State private var ingredients = [
        Ingredient(name: "Chicken", available: true),
        Ingredient(name: "Carrot", available: true),
        Ingredient(name: "Bread Crumb", available: true),
        Ingredient(name: "Pepper", available: true),
        Ingredient(name: "Fish", available: false),
        Ingredient(name: "Tomato", available: false),
        Ingredient(name: "Salt", available: false),
        Ingredient(name: "Cucumber", available: false),
        Ingredient(name: "Asparagus", available: false)
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                Image("sampleRecipe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                
                Text("Cucumber Vinegar Salad")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 4)
                
                HStack {
                    Text("33 calories")
                        .font(.system(size: 20))
                    Spacer()
                    Button(action: {
                        UIApplication.shared.open(self.recipeURL)
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(hex:"#139c67"))
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
                    
                    ProgressBar(value: $progressBarValue)
                        .frame(height: 20)
                        .padding(.bottom, 20)
                    
                    
                    VStack(alignment: .leading) {
                        ForEach(nutrientData.prefix(isExpanded ? nutrientData.count : initialNutrientCount)) { nutrient in
                            NutrientRowView(nutrientData: nutrient)
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    if nutrientData.count > initialNutrientCount {
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
                        Text("0/9 available")
                            .font(.system(size: 18))
                        Spacer()
                        Button(action: {
                            // Send ingredients to cart
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color(hex:"#139c67"))
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
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.gray.opacity(0.1))
                    .frame(width: 350, height: 200)
                    .overlay(
                VStack(alignment: .leading) {
                    ForEach(0..<ingredients.count/2, id: \.self) { index in
                        HStack {
                            Text(ingredients[index*2].name)
                            
                            if ingredients[index*2].available {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "xmark")
                                    .foregroundColor(.red)
                            }
                            
                            Spacer()
                            
                            Text(ingredients[index*2+1].name)
                                
                            
                            if ingredients[index*2+1].available {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "xmark")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    
                    if ingredients.count % 2 != 0 {
                        HStack {
                            Text(ingredients[ingredients.count-1].name)
                                .background(Color.gray.opacity(0.1))
                            
                            if ingredients[ingredients.count-1].available {
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
                
                )
                

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

struct ProgressBar: View {
    @Binding var value: Float
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
                        Text("EasyMeal Health Score™")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .alignmentGuide(HorizontalAlignment.center) { d in d[HorizontalAlignment.center] }
                            .alignmentGuide(VerticalAlignment.bottom) { d in d[VerticalAlignment.top] - geometry.size.height }
                            .offset(x: 10)
                        
                        Text("\(score)/10")
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
    let id = UUID()
    var name: String
    var available: Bool
}

struct RecipeInfo_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInfo()
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
