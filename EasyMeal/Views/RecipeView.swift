//  RecipeView.swift
//  EasyMeal
//  Created by Miguel Aenlle on 5/18/23.

import SwiftUI

struct RecipeView: View
{
    var recipe: Recipe
    var selectRecipe: (Recipe) -> Void

    var body: some View
    {
        VStack(spacing: 8)
        {
            VStack(alignment: .leading)
            {
                Text(recipe.name)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("\(recipe.numIngredients)/\(recipe.totalIngredients) Ingredients")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("\(String(format: "%.2f", round(recipe.healthScore*10)/10))/10 Health Score")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 20)
            .padding(.top, 20)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color(hex: "#d4d4d4"), radius: 5,x: 0, y: 5)
        .onTapGesture
        {
            selectRecipe(recipe)
        }
    }
}
