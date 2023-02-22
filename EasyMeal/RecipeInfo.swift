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
                ProgressBar(value: $progressBarValue)
                    .frame(height: 20)
            }
            Spacer()
            .padding()
            .offset(y: 10)
        }
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
                    Rectangle().frame(width: geometry.size.width * 0.7, height: geometry.size.height * 1.6)
                        .opacity(0.3)
                        .foregroundColor(custLightRed)
                    
                    Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width * 0.7, geometry.size.width), height: geometry.size.height * 1.6)
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

    


struct RecipeInfo_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInfo()
    }
}
