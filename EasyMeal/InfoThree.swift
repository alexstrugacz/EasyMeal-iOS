//
//  InfoThree.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 2/10/23.
//

import SwiftUI

struct InfoThree: View {
    @State var showView = false

    var body: some View {
        VStack {
            Text("Find\nnutritious meals")
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
                print("toSignUp")
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
            NavigationLink(destination: SignUp(), isActive: $showView) {
                                EmptyView()
                            }
        }
    }
}

