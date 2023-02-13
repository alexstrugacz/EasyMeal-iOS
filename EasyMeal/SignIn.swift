//
//  SignIn.swift
//  EasyMeal
//
//  Created by Alexander Masztak on 2/10/23.
//

import SwiftUI

struct SignIn: View {
    @State var showView = false
    @State var showView2 = false
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
            

            Color.clear
            VStack(alignment: .leading) {

                Text("Sign In")
                    .multilineTextAlignment(.center)
                    .foregroundColor(custGreen)
                    .font(.system(size: 60))
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
                Text("Sign In")
                    .foregroundColor(.white)
                    .padding(.horizontal, 130)
                    .padding(.vertical, 16)
                    .background(LinearGradient(gradient: Gradient(colors: [custGreen, custGreen]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .shadow(color: custShadow, radius: 3, x: 0, y: 3)
            }
            .offset(y: -175)
            NavigationLink(destination: MainView(), isActive: $showView) {
                                EmptyView()
                            }
        }
        HStack {
            Rectangle().frame(width: 140, height: 1).foregroundColor(.black)
            Text("or").font(.subheadline)
            Rectangle().frame(width: 140, height: 1).foregroundColor(.black)
        }
        .offset(y:-150)
        
        Button(action: {
            //code to signup
            print("toSignUp")
                                DispatchQueue.main.asyncAfter(deadline: .now()) {
                                    self.showView2 = true
                                }
        }) {
            Text("Sign Up")
                .foregroundColor(.white)
                .padding(.horizontal, 130)
                .padding(.vertical, 16)
                .background(LinearGradient(gradient: Gradient(colors: [custGreen, custGreen]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                .shadow(color: custShadow, radius: 3, x: 0, y: 3)
        }
        .offset(y: -130)
        NavigationLink(destination: SignUp(), isActive: $showView2) {
                            EmptyView()
                        }
    }
    
    
    
}


struct Previews_SignIn_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
