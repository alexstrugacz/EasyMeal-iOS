//
//  RecipeView.swift
//  EasyMeal
//
//  Created by Miguel Aenlle on 5/18/23.
//

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe
    var selectRecipe: (Recipe) -> Void
    var body: some View {
        
            HStack(spacing: 8) {
                Button {
                    selectRecipe(recipe)
                } label: {
                    VStack {
                        AsyncImage(url: URL(string:recipe.url)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .cornerRadius(10)
                        } placeholder: {
                            ZStack {
                                Color(red: 0.8, green: 0.8, blue: 0.8)
                                    .cornerRadius(10)
                                Text("No Image")
                                    .foregroundColor(.gray)
                                    .font(.headline)
                            }
                            .frame(width: 120, height: 120)
                        }
                    }
                }

                    

                VStack(alignment: .leading) {
                    Spacer()
                    Button {
                        selectRecipe(recipe)
                    } label: {
                        
                        Text(recipe.name)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    VStack {
                        Text("\(recipe.numIngredients)/\(recipe.totalIngredients) Ingredients")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(String(format: "%.2f", round(recipe.healthScore*10)/10))/10 Health Score")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(String(format: "%.2f", round(recipe.healthScore*10)/10))/10 Health Score")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                }
                .offset(x: 5)

                Spacer()
            }
    }
}
