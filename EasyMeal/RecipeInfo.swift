//
//  RecipeInfo.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 2/20/23.
//

import SwiftUI

struct RecipeInfo: View {
    let recipeURL = URL(string: "https://www.easymeal.me")!
    @State var progressBarValue = 90
    
    var body: some View {
        VStack {
            VStack {
                Text("Recipe")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
            }
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
                ProgressBar(percentage: progressBarValue)
                                    .frame(height: 10)
            }
            .offset(y: 10)
        }
    }
}

struct ProgressBar: View {
    let percentage: Int
    
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(custGreen)
                .frame(width: CGFloat(percentage) * 3, height: 40)
                .overlay(
                    Text("EasyMeal Health Score™")
                        .foregroundColor(.white)
                    
                        
                )
            
            Rectangle()
                .fill(custLightRed)
                .frame(width: CGFloat(100 - percentage) * 3, height: 40)
        }
        .padding(.horizontal, 20)
    }
}

struct RecipeInfo_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInfo()
    }
}
