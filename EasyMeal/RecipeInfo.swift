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
            
            ScrollView{
                
                Image("sampleRecipe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                
                Text("Cucumber Vinegar Salad")
                    .font(.title)
                
                HStack {
                    Text("33 calories")
                    Spacer()
                    Button(action: {
                        UIApplication.shared.open(self.recipeURL)
                    }) {
                        Text("See Recipe")
                            .foregroundColor(.blue)
                    }
                }
                .frame(width: 280)
                VStack{
                    Text("Nutrition Insights")
                        .bold()
                    ProgressBar(value: $progressBarValue)
                        .frame(height: 20)
                    
                    HStack {
                        ForEach(0..<2) { column in
                            VStack(alignment: .leading) {
                                ForEach(0..<nutrientData.count/2) { index in
                                    if column == 0 {
                                        NutrientRowView(nutrientData: nutrientData[index])
                                    } else {
                                        NutrientRowView(nutrientData: nutrientData[index + nutrientData.count/2])
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
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
                        Text("0/9 available")
                        Spacer()
                        Button(action: {
                            //send ingredients to cart
                        }) {
                            Text("Add to cart")
                                .foregroundColor(.blue)
                        }
                    }
                    .frame(width: 280)
                    
                    
                    
                    .padding(.horizontal, 16)
                    
                }
                VStack(alignment: .leading) {
                    ForEach(ingredients) { ingredient in
                        HStack {
                            Text(ingredient.name)
                                .offset(x: -20)
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
                .padding(.horizontal, 60)

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
                    
                    HStack{
                        Text("EasyMeal Health Score™")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .alignmentGuide(HorizontalAlignment.center) { d in d[HorizontalAlignment.center] }
                            .alignmentGuide(VerticalAlignment.bottom) { d in d[VerticalAlignment.top] - geometry.size.height }
                            .offset(x:10)
                        
                        Text("\(score)/10")
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
    let id = UUID()
    var name: String
    var available: Bool
}

struct RecipeInfo_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInfo()
    }
}
