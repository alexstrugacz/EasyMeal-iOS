//
//  RecipeInfo.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 2/20/23.
//

import SwiftUI

struct RecipeInfo: View {
    var body: some View {
        
        
        VStack{
            HStack {
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
            
            HStack{
                Text("33 calories")
                Spacer()
                Text("See Recipe")
            }
            .frame(width: 280)
        }
    }
}

struct RecipeInfo_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInfo()
    }
}
