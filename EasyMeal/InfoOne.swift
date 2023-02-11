//
//  InfoOne.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 2/10/23.
//

import SwiftUI

struct InfoOne: View {
    @State var showView = false

    var body: some View {
        
            VStack {
                Text("Input your\nIngredients")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Image("infoOne")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                
                Text("Use ingredients already\nin your pantry to\n generate meals")
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                
                Button(action: {
                    //code
                    print("toInfoTwo")
                                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                                            self.showView = true
                                        }
                }) {
                    Text("Continue")
                        .foregroundColor(.white)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 16)
                        .background(LinearGradient(gradient: Gradient(colors: [custGreen, custGreen]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                        .shadow(color: custShadow, radius: 3, x: 0, y: 3)
                }
                .offset(y: 50)
                NavigationLink(destination: InfoTwo(), isActive: $showView) {
                                    EmptyView()
                                }
            }
    }
}


