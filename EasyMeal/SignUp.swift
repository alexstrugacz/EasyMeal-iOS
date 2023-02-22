//
//  SignUp.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 2/10/23.
//

import SwiftUI

struct SignUp: View {
    @State var showView = false
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
            

            Color.clear
            VStack(alignment: .leading) {

                Text("Sign Up")
                    .multilineTextAlignment(.center)
                    .foregroundColor(custGreen)
                    .font(.system(size: 60)).bold()
                
            }
            .offset(x: 40, y: 75)
        }
            
            ZStack(alignment: .bottom) {
                HStack {
                    HStack {
                        Image("email")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.leading, 10)
                        TextField("Email", text: $email)
                            .lineLimit(1)
                            .padding(.leading, 15)
                            .background(Color.clear)
                    }
                    .frame(width: 280, height: 50)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                }
                
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 0.5)
                    .foregroundColor(.black)
                    .frame(width: 300, height: 1)
                    .padding(.bottom, 10)
            }
            .padding(.top, 20)
            .offset(y: -250)




                        
            ZStack(alignment: .bottom) {
                HStack {
                    HStack {
                        Image("password")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.leading, 10)
                        SecureField("Password", text: $password)
                            .lineLimit(1)
                            .padding(.leading, 15)
                            .background(Color.clear)
                    }
                    .frame(width: 280, height: 50)
                    .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                }
                
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 0.5)
                    .foregroundColor(.black)
                    .frame(width: 300, height: 1)
                    .padding(.bottom, 10)
            }
            .padding(.top, 20)
            .offset(y: -250)




                            

            
            Button(action: {
                //code
                print("toPantry")
                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        self.showView = true
                                    }
            }) {
                Text("Create")
                    .foregroundColor(.white)
                    .padding(.horizontal, 130)
                    .padding(.vertical, 16)
                    .background(LinearGradient(gradient: Gradient(colors: [custGreen, custGreen]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .shadow(color: custShadow, radius: 1, x: 1, y: 1)
            }
            .offset(y: -175)
            NavigationLink(destination: MainView(initialTab: .refrigerator, content: {
                Pantry()
            }), isActive: $showView) {
                                EmptyView()
                            }
        }
    }
}

